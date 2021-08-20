# terraform-hs-ecs

This repository provides a terraform to create an environment providing cluster which utilizes ECS as its container service.

## Requirement

- AWS User with following permission:-
  - AmazonRDSFullAccess
  - AmazonEC2FullAccess
  - IAMFullAccess
  - AmazonS3FullAccess
  - AmazonECS_FullAccess
  - AmazonEC2ContainerRegistryPowerUser
  - AmazonRoute53FullAccess

- RDS snapshot containing the empty db with all tables. This will be used to create an rds instance.
- Kay pair value (optional), which could be used to ssh into instance. 
- ECR repositories with relevant images of LM, CW and API.
- S3 bucket to store state remotely.

## Directory structure

Following are the directory structure:
- `modules`: contains reusable modules
- `vpc_deployment`: contains code to create a full fledged environment with apps
- `vpc_management`: contains code to create management apps such as Prometheus, Grafana and cAdvisor

```
├── modules
|   ├── alb
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf
|   ├── albManage
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf    
|   ├── asg
|   |   ├── autoscaling_user_data.tpl
|   |   ├── main.tf
|   |   └── vars.tf  
|   ├── ecs
|   |   ├── ecs_task_hrdd_apps.tpl
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf
|   ├── ecsManager
|   |   ├── ecs_task_hrdd_manage_apps.tpl
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf
|   ├── peer
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf      
|   ├── rds_form_snapshot
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf  
|   ├── roles
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf  
|   ├── route53
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf
|   ├── route53Manage
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf   
|   ├── security_groups
|   |   ├── data.tf
|   |   ├── main.tf
|   |   ├── output.tf
|   |   └── vars.tf  
|   └── vpc
|       ├── data.tf
|       ├── main.tf
|       ├── output.tf
|       └── vars.tf
|
├── vpc_deployment
|   ├── configuration.tfvars
|   ├── main.tf
|   ├── outputs.tf
|   ├── remote_state.tf
|   └── vars.tf
|
└── vpc_deployment
    ├── configuration.tfvars
    ├── main.tf
    ├── outputs.tf
    ├── remote_state.tf
    └── vars.tf

```


## Deployment steps
Go to the vpc_deployment folder:-

1. Modify `configuration.tfvars` variables with your values
2. Run `terraform init` to initialize modules
3. Run `terraform workspace list` to list existing workspaces (currently `dev, test, stage, prod`)
4. Run `terraform workspace select test` to select the test(or any other existing) workspace
5. Run `terraform plan -var-file=configuration.tfvars` and confirm changes
6. Run `terraform apply -var-file=configuration.tfvars`
7. Wait till the apps are deployed. Urls of the apps will be displayed as output of the terraform
8. Repeat the steps (1-7) by going into the vpc_management folder.


## Accessing ECS-EC2 instances with AWS System Manager

As all the EC2 instances are created in private network without public IP, therefore its not possible to access
them with SSH client. AWS System Manager -> Session Manager can be used to establish ssh connection without any
client. This connection is possible because of AWS System Manager Agent is being installed on EC2 instance by ECS
 during deployment. 
 
 ## Migrating changes to RDS DB
 
 Create a temp RDS from a snapshot, access it via pgAdmin and apply changes to the temp DB. 
 Create a snapshot of the temp database. Now deploy a new RDS within ECS using the new snapshot.

## Current Issues
1. There are some control tags created on each EC2 instance, which allows DWP Cloud Services to control
these EC2 instances. For example a Persistence tag controls the up times of EC2 instance, when this tag is provided the EC2
instance is terminated instead of being stopped. The next day a new instance is created.

2. When a new update of code is applied on running ECS either from Gitlab CI or AWS CLI with the following command.

`aws ecs update-service --cluster <cluster name> --service <service name> --force-new-deployment`
 
This does not work properly. The existing ECS service stops but new service is not started. When the events under ECS tabs are checked, the error
says, not enough memory. Currently, it can be resolved by terminating the existing EC2 instance. As a result
ECS (ASG) will launch a new EC2 instance with new code.
