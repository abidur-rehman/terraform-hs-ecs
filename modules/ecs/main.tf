/* Cluster definition, which is used in autoscaling.tf */
resource "aws_ecs_cluster" "hs_test_cluster" {
  name = "${var.name_prefix}_${var.environment}_cluster"
}

/* ECS service definition for api app */
resource "aws_ecs_service" "hs_ts_apps_service" {
  name = "${var.name_prefix}_${var.environment}_ts_apps_service"
  cluster = aws_ecs_cluster.hs_test_cluster.id
  task_definition = aws_ecs_task_definition.hs_ts_apps_definition.arn
  desired_count = var.count_webapp
  deployment_minimum_healthy_percent = var.minimum_healthy_percent_webapp
  //    iam_role = "${var.ecs_service_role}"

  load_balancer {
    target_group_arn = var.ts_api_app_alb_tg_arn
    container_name = "ts-api-app"
    container_port = 4000
  }

  load_balancer {
    target_group_arn = var.ts_app_alb_tg_arn
    container_name = "ts-app"
    container_port = 3000
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "hs_ts_apps_definition" {
  family = "${var.name_prefix}_${var.environment}_ts_apps"
  container_definitions = data.template_file.task_hs_ts_apps.rendered

  lifecycle {
    create_before_destroy = true
  }

  
  volume {
    name      = "ts_config_json"
    host_path = "/var/tmp"
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

data "template_file" "task_hs_ts_apps" {
  template= file("../modules/ecs/ecs_task_hs_ts_apps.tpl")

  vars = {
    ts_api_app_docker_image = "${var.ts_api_app_docker_image_name}:${var.ts_api_app_docker_image_tag}"
    ts_app_docker_image = "${var.ts_app_docker_image_name}:${var.ts_app_docker_image_tag}"
    razzle_env = var.razzle_env
  }
}

/* ECS service definition for laparts apps */
resource "aws_ecs_service" "hs_laparts_apps_service" {
  name = "${var.name_prefix}_${var.environment}_laparts_apps_service"
  cluster = aws_ecs_cluster.hs_test_cluster.id
  task_definition = aws_ecs_task_definition.hs_laparts_apps_definition.arn
  desired_count = var.count_webapp
  deployment_minimum_healthy_percent = var.minimum_healthy_percent_webapp
  //    iam_role = "${var.ecs_service_role}"
  
  load_balancer {
    target_group_arn = var.laparts_api_app_alb_tg_arn
    container_name = "laparts-api-app"
    container_port = 4001
  }

  load_balancer {
    target_group_arn = var.laparts_app_alb_tg_arn
    container_name = "laparts-app"
    container_port = 3000
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "hs_laparts_apps_definition" {
  family = "${var.name_prefix}_${var.environment}_laparts_apps"
  container_definitions = data.template_file.task_hs_laparts_apps.rendered

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

data "template_file" "task_hs_laparts_apps" {
  template= file("../modules/ecs/ecs_task_hs_laparts_apps.tpl")

  vars = {
    laparts_api_app_docker_image = "${var.laparts_api_app_docker_image_name}:${var.laparts_api_app_docker_image_tag}"
    laparts_app_docker_image = "${var.laparts_app_docker_image_name}:${var.laparts_app_docker_image_tag}"
    database_url = var.database_url
    database_user = var.database_user
    database_password = var.database_password
    paypal_client_id = var.paypal_client_id
    paypal_secret = var.paypal_secret
    razzle_env = var.razzle_env
    razzle_host_username = var.razzle_host_username
    razzle_host_password = var.razzle_host_password
    razzle_google_api_key = var.razzle_google_api_key
    razzle_google_client_id = var.razzle_google_client_id
    razzle_paypal_client_id = var.razzle_paypal_client_id
  }
}