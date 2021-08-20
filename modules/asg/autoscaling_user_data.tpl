#!/bin/bash
set -x
set -e

# Update instance
yum update -y

# Set static hostname
sudo hostnamectl set-hostname --static ${hostname}
echo "Completed setting hostname"

# Join ECS cluster
{
  echo "ECS_CLUSTER=${ecs_cluster}"
} >> /etc/ecs/ecs.config
# start ecs

# Amazon SSM Agent, so it can be used by AWS System Manager
sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
echo "Installed ssm-agent"


# Add environment config file
sudo cat << EOF > /var/tmp/TXT_SPEECH_CONFIG.JSON
{
  "type": "${txt_config_type}",
  "project_id": "${txt_config_project_id}",
  "private_key_id": "${txt_config_private_key_id}",
  "private_key": "${txt_config_private_key}",
  "client_email": "${txt_config_client_email}",
  "client_id": "${txt_config_client_id}",
  "auth_uri": "${txt_config_auth_uri}",
  "token_uri": "${txt_config_token_uri}",
  "auth_provider_x509_cert_url": "${txt_config_auth_provider_x509_cert_url}",
  "client_x509_cert_url": "${txt_config_client_x509_cert_url}"
}
EOF

echo "Executed user data"
