/* Cluster definition, which is used in autoscaling.tf */
resource "aws_ecs_cluster" "hrdd_manage_test_cluster" {
  name = "${var.name_prefix}_${var.environment}_cluster"
}

/* ECS service definition for api app */
resource "aws_ecs_service" "hrdd_manage_apps_service" {
  name = "${var.name_prefix}_${var.environment}_apps_service"
  cluster = aws_ecs_cluster.hrdd_manage_test_cluster.id
  task_definition = aws_ecs_task_definition.hrdd_manage_apps_definition.arn
  desired_count = var.count_webapp
  deployment_minimum_healthy_percent = var.minimum_healthy_percent_webapp
  //    iam_role = "${var.ecs_service_role}"

  load_balancer {
    target_group_arn = var.prom_app_alb_tg_arn
    container_name = "prometheus-app"
    container_port = 9090
  }

  load_balancer {
    target_group_arn = var.graf_app_alb_tg_arn
    container_name = "grafana-app"
    container_port = 3000
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "hrdd_manage_apps_definition" {
  family = "${var.name_prefix}_${var.environment}_apps"
  container_definitions = data.template_file.task_hrdd_manage_apps.rendered

  lifecycle {
    create_before_destroy = true
  }

  volume {
    name      = "root"
    host_path = "/"
  }

  volume {
    name      = "var_run"
    host_path = "/var/run"
  }

  volume {
    name      = "sys"
    host_path = "/sys"
  }

  volume {
    name      = "var_lib_docker"
    host_path = "/var/lib/docker"
  }

  volume {
    name      = "dev_disk"
    host_path = "/dev_disk"
  }

  volume {
    name      = "cgroup"
    host_path = "/cgroup"
  }
}

data "template_file" "task_hrdd_manage_apps" {
  template= file("../modules/ecsManage/ecs_task_hrdd_manage_apps.tpl")

  vars = {
    prometheus_docker_image = "${var.prom_docker_image_name}:${var.prom_docker_image_tag}"
    grafana_docker_image = "${var.graf_docker_image_name}:${var.graf_docker_image_tag}"
  }
}