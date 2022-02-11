resource "aws_launch_configuration" "hs_on_demand_cf" {
  name_prefix = "${var.name_prefix}_${var.environment}_on_demand_cf"
  instance_type = var.instance_type
  image_id = data.aws_ssm_parameter.ecs_instance_ami.value
  iam_instance_profile = var.ecs_instance_profile
  user_data = data.template_file.autoscaling_user_data.rendered
  key_name = var.ec2_key_name
  security_groups = [var.hs_instances_sg_id]
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "hs_on_demand_gp" {
  name = "${var.name_prefix}_${var.environment}_on_demand"
  max_size = 2
  min_size = 0
  desired_capacity = var.desired_capacity_on_demand
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  # launch_template {
  #   id      = aws_launch_template.hs_on_demand_lt.id
  #   version = aws_launch_template.hs_on_demand_lt.latest_version
  # }
  launch_configuration = aws_launch_configuration.hs_on_demand_cf.name
  vpc_zone_identifier = var.subnet_ids_pri

  tags = var.compliance_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_schedule" "hs_on_demand_as_up" {
  scheduled_action_name  = "${var.name_prefix}_${var.environment}_scale_up"
  min_size               = 0
  max_size               = 2
  desired_capacity       = var.desired_capacity_on_demand
  recurrence             = "00 20 * * *"
  autoscaling_group_name = aws_autoscaling_group.hs_on_demand_gp.name
}

resource "aws_autoscaling_schedule" "hs_on_demand_as_down" {
  scheduled_action_name  = "${var.name_prefix}_${var.environment}_scale_down"
  min_size               = 0
  max_size               = 2
  desired_capacity       = 0
  recurrence             = "00 22 * * *"
  autoscaling_group_name = aws_autoscaling_group.hs_on_demand_gp.name
}

data "template_file" "autoscaling_user_data" {
  template = file("../modules/asg/autoscaling_user_data.tpl")
  vars = {
    ecs_cluster = var.cluster_name,
    hostname = "${var.name_prefix}_${var.environment}_on_demand",
    txt_config_type = var.txt_config_type,
    txt_config_project_id = var.txt_config_project_id,
    txt_config_private_key_id = var.txt_config_private_key_id,
    txt_config_private_key = var.txt_config_private_key,
    txt_config_client_email = var.txt_config_client_email,
    txt_config_client_id = var.txt_config_client_id,
    txt_config_auth_uri = var.txt_config_auth_uri,
    txt_config_token_uri = var.txt_config_token_uri,
    txt_config_auth_provider_x509_cert_url = var.txt_config_auth_provider_x509_cert_url,
    txt_config_client_x509_cert_url = var.txt_config_client_x509_cert_url
  }
}

data "aws_ami" "hs_ecs_image" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

# resource "aws_launch_template" "hs_on_demand_lt" {
#   name                                 = "${var.name_prefix}_${var.environment}_on_demand_lt"
#   ebs_optimized                        = true
#   image_id                             = data.aws_ami.hs_ecs_image.id
#   instance_initiated_shutdown_behavior = "stop"
#   instance_type                        = var.instance_type
#   key_name                             = var.ec2_key_name
#   # user_data = data.template_file.autoscaling_user_data.rendered

#   iam_instance_profile {
#     name = "hs_dev_ecs_instance_profile"
#   }                

#   network_interfaces {
#     associate_public_ip_address = false
#     subnet_id                   = var.subnet_ids_pri[0]
#     security_groups             = [var.hs_instances_sg_id]
#     delete_on_termination       = false
#   }

#   user_data = base64encode(templatefile("${path.module}/autoscaling_user_data.tpl", {
#     ecs_cluster = var.cluster_name,
#     hostname = "${var.name_prefix}_${var.environment}_on_demand",
#     txt_config_type = var.txt_config_type,
#     txt_config_project_id = var.txt_config_project_id,
#     txt_config_private_key_id = var.txt_config_private_key_id,
#     txt_config_private_key = var.txt_config_private_key,
#     txt_config_client_email = var.txt_config_client_email,
#     txt_config_client_id = var.txt_config_client_id,
#     txt_config_auth_uri = var.txt_config_auth_uri,
#     txt_config_token_uri = var.txt_config_token_uri,
#     txt_config_auth_provider_x509_cert_url = var.txt_config_auth_provider_x509_cert_url,
#     txt_config_client_x509_cert_url = var.txt_config_client_x509_cert_url
#   }))

#   # we don't want to create a new template just because there is a newer AMI
#   lifecycle {
#     ignore_changes = [
#       image_id,
#     ]
#   }
# }
