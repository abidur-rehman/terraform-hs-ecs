resource "aws_alb" "hs_alb" {
  lifecycle { create_before_destroy = true }
  name = "${var.name_prefix}-${var.environment}-app-alb"
  subnets = var.subnet_ids_pub
  security_groups = [var.hs_albs_sg_id]
  idle_timeout = 400
  tags = {
    Name = "${var.name_prefix}_${var.environment}_alb"
  }
}

# lb default http listener
resource "aws_alb_listener" "hs_alb_http_listener" {
  load_balancer_arn = aws_alb.hs_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ts_app_alb_tg.id
    type             = "forward"
  }
  depends_on = [aws_alb.hs_alb]
}

# lb default https listener
resource "aws_alb_listener" "hs_alb_https_listener" {
  load_balancer_arn = aws_alb.hs_alb.arn
  port              = "443"
  protocol          = "HTTPS"

  depends_on = [aws_alb_target_group.ts_api_app_alb_tg]
  certificate_arn = var.ssl_certificate

  default_action {
    target_group_arn = aws_alb_target_group.ts_api_app_alb_tg.id
    type             = "forward"
  }
}

# ts-api-app config start
resource "aws_alb_target_group" "ts_api_app_alb_tg" {
  name                 = "${var.name_prefix}-${var.environment}-ts-api-app-alb-tg"
  port                 = "4000"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "4000"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
    matcher             = "404"
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_ts_api_app_alb_tg"
  }

  depends_on = [aws_alb.hs_alb]
}

resource "aws_lb_listener_rule" "http_ts_api_routing" {
  listener_arn = aws_alb_listener.hs_alb_http_listener.arn
  priority     = 99
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ts_api_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_ts_api}-${var.environment}.holidaynumbers.co.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "https_ts_api_routing" {
  listener_arn = aws_alb_listener.hs_alb_https_listener.arn
  priority     = 99
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ts_api_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_ts_api}-${var.environment}.holidaynumbers.co.uk"]
    }
  }
}
# ts-api-app config end

# ts-app config start
resource "aws_alb_target_group" "ts_app_alb_tg" {
  name                 = "${var.name_prefix}-${var.environment}-ts-app-alb-tg"
  port                 = "3000"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "3000"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_ts_app_alb_tg"
  }

  depends_on = [aws_alb.hs_alb]
}

resource "aws_lb_listener_rule" "http_ts_routing" {
  listener_arn = aws_alb_listener.hs_alb_http_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ts_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_ts}-${var.environment}.holidaynumbers.co.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "https_ts_routing" {
  listener_arn = aws_alb_listener.hs_alb_https_listener.arn
  priority     = 100
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ts_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_ts}-${var.environment}.holidaynumbers.co.uk"]
    }
  }
}
# ts-app config end

# laparts-api-app config start
resource "aws_alb_target_group" "laparts_api_app_alb_tg" {
  name                 = "${var.name_prefix}-${var.environment}-laparts-api-app-alb-tg"
  port                 = "4001"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/health"
    port                = "4001"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_laparts_api_app_alb_tg"
  }

  depends_on = [aws_alb.hs_alb]
}

resource "aws_lb_listener_rule" "http_lapart_api_routing" {
  listener_arn = aws_alb_listener.hs_alb_http_listener.arn
  priority     = 98
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.laparts_api_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_laparts_api}.holidaynumbers.co.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "https_laparts_api_routing" {
  listener_arn = aws_alb_listener.hs_alb_https_listener.arn
  priority     = 98
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.laparts_api_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_laparts_api}.holidaynumbers.co.uk"]
    }
  }
}
# laparts-api-app config end


# laparts-app config start
resource "aws_alb_target_group" "laparts_app_alb_tg" {
  name                 = "${var.name_prefix}-${var.environment}-laparts-app-alb-tg"
  port                 = "3001"
  protocol             = "HTTP"
  vpc_id               = var.vpc_id

  deregistration_delay = 180

  health_check {
    interval            = "60"
    path                = "/"
    port                = "3001"
    healthy_threshold   = "3"
    unhealthy_threshold = "3"
    timeout             = "5"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "${var.name_prefix}_${var.environment}_laparts_app_alb_tg"
  }

  depends_on = [aws_alb.hs_alb]
}

resource "aws_lb_listener_rule" "http_lapart_routing" {
  listener_arn = aws_alb_listener.hs_alb_http_listener.arn
  priority     = 97
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.laparts_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_laparts}.holidaynumbers.co.uk"]
    }
  }
}

resource "aws_lb_listener_rule" "https_laparts_routing" {
  listener_arn = aws_alb_listener.hs_alb_https_listener.arn
  priority     = 97
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.laparts_app_alb_tg.arn
  }
  condition {
    host_header {
      values = ["${var.name_prefix_laparts}.holidaynumbers.co.uk"]
    }
  }
}
# laparts-app config end