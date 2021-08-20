resource "aws_alb" "hrdd_manage_alb" {
  lifecycle { create_before_destroy = true }
  name = "${var.name_prefix_with_hyphen}-${var.environment}-app-alb"
  subnets = var.subnet_ids_pub
  security_groups = [var.hrdd_manage_albs_sg_id]
  idle_timeout = 400
  tags = {
    Name = "${var.name_prefix}_${var.environment}_alb"
  }
}

resource "aws_alb_target_group" "grafana_app_alb_tg" {
  name                 = "${var.name_prefix_with_hyphen}-${var.environment}-graf-app-alb-tg"
  port                 = "3000"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/login"
    port                = "3000"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_graf_app_alb_tg"
  }

  depends_on = [aws_alb.hrdd_manage_alb]
}

resource "aws_alb_target_group" "prometheus_app_alb_tg" {
  name                 = "${var.name_prefix_with_hyphen}-${var.environment}-prom-app-alb-tg"
  port                 = "9090"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "9090"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
    matcher             = "302"
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_prom_app_alb_tg"
  }

  depends_on = [aws_alb.hrdd_manage_alb]
}

resource "aws_alb_listener" "hrdd_manage_alb_http_listener" {
  load_balancer_arn = aws_alb.hrdd_manage_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.grafana_app_alb_tg.id
    type             = "forward"
  }
  depends_on = [aws_alb.hrdd_manage_alb]
}

resource "aws_lb_listener_rule" "http_graf_routing" {
  listener_arn = aws_alb_listener.hrdd_manage_alb_http_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.grafana_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_graf}-${var.environment}.people-dev-development.dwpcloud.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "http_prom_routing" {
  listener_arn = aws_alb_listener.hrdd_manage_alb_http_listener.arn
  priority     = 99
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.prometheus_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_prom}-${var.environment}.people-dev-development.dwpcloud.uk"]
    }
  }
}

resource "aws_alb_listener" "hrdd_manage_alb_https_listener" {
  load_balancer_arn = aws_alb.hrdd_manage_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  depends_on = [aws_alb_target_group.grafana_app_alb_tg]
  certificate_arn = var.ssl_certificate

  default_action {
    target_group_arn = aws_alb_target_group.grafana_app_alb_tg.id
    type             = "forward"
  }
}

resource "aws_lb_listener_rule" "https_grafana_routing" {
  listener_arn = aws_alb_listener.hrdd_manage_alb_https_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.grafana_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_graf}-${var.environment}.people-dev-development.dwpcloud.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "https_prom_routing" {
  listener_arn = aws_alb_listener.hrdd_manage_alb_https_listener.arn
  priority     = 99
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.prometheus_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_prom}-${var.environment}.people-dev-development.dwpcloud.uk"]
    }
  }
}