# User gitlab_ci_deploy is used to execute the terraform.
# S3 Bucket aws-hostservice-terraform is used to store state.

name_prefix = "hs"
aws_region = "eu-west-2"

# rds config values
ingress_ports = [5432]
//db_instance_id (Instance/Cluster Name) is located in the details of snapshot
db_instance_id = "laparts"  //Dont change this, as this is the template rds
//db_snapshot_id (DB snapshot name) is located in the details of snapshot
db_snapshot_id = "hs-db-template-with-test-date-12062021" //Dont change this, as this is the template rds
username = "postgres"    //This should be same as database_user
password = "myAdmin009" //This should be same as database_password

# alb config values
name_prefix_ts_api = "ts-api"
name_prefix_ts = "ts"
name_prefix_laparts_api = "laparts-api"
name_prefix_laparts = "laparts"
ssl_certificate = "arn:aws:acm:eu-west-2:044970577237:certificate/ca0c7b32-42bb-4d7e-a7e8-2f39fcf8ef63"

# asg config values
instance_type = "t2.micro"
ec2_key_name = "hostservice_ec2_key"
// increased to 2 coz of laparts-deployment
desired_capacity_on_demand = 1

# ecs config values
count_webapp = 1
minimum_healthy_percent_webapp = 50
ts_api_app_docker_image_name = "044970577237.dkr.ecr.eu-west-2.amazonaws.com/ts-api"
ts_api_app_docker_image_tag = "latest"
ts_app_docker_image_name = "044970577237.dkr.ecr.eu-west-2.amazonaws.com/ts"
ts_app_docker_image_tag = "latest"
laparts_api_app_docker_image_name = "abidurrehman/laparts-api"
laparts_api_app_docker_image_tag = "latest"
database_user = "postgres"
database_password = "myAdmin009"
paypal_client_id = "AXofz3yL4F5w-CxSFA6WooO1MvmjtLKQ4SadIJKWZPUubMxNJrev_z7GpKUAyoYVd6I3rjwb3YayqjNY"
paypal_secret = "EGmi0Ap0v45G0YgsLmMynvafP7a6fvtEcyzTc-873zTGa2wbK78qk9aH6ksbaWuGPacJFaKnuY3ikjgw"

# txt config file
txt_config_type = "service_account"
txt_config_project_id = "text2speech-298713"
txt_config_private_key_id = "21cedaad852775233c3c17efc25d3dafbbcc38a6"
txt_config_private_key = "-----BEGIN PRIVATE KEY-----\\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDeTeY0pqdtR110\\n6WWpCYaV/w/5iDcdaDWvMQDoSFR6A0z29Ez+2k7swylyldPSYX0AYnQqJpkC9n5n\\n8+9BfuZ/i/4ohstyRug1SOO9cV8w3EuSIzYeAzBF3dhBq0VKs0Qdtjx3TObm6Te5\\n3BhIkR8QJd99pRHpbKSjmNk3zSefUAVyJt79k41QYla7c2lhs/4Qkr3hQOewRGHk\\nE3PBFCRI2X0H7TSUx7+5IwG39TnYqz9cZ5Mzi5fswFedOozJnWiGtqiFoAE5C3Kf\\nerz+2KQdhAQ2hpYjZ3Y3u/RvyRDVsnyzA7dUvyuLJCu46jdp7ezPy6m4AwZRTmH9\\n0HeZe3QFAgMBAAECggEANOqtpPRTr+lYN4N0WdHE6fEibBdu6S7ccpSzXteS1k1x\\nVWqvZk3wkh7dv6MnHjHrF7uX4822yBQFYHjaR8itlQhtqld118DFtyNf5ME3M9II\\noiOEFw5SwBrQBse+cYrtKLZvu8VARJCY3YLk++chkg413jp8IkikgzXX5RbOevcX\\njL0ttxaRhB7MhTKGLJ0kwn/mWlBy7JUfq4xlawJ96OLAMZT/UW/vl6oiHl94eC6f\\nCMcXYUnRDcAoBIC/UdjkJFtjbC6QMNUt1ap0nZnehi1jdCx7yvXECTTc2DL7OMdZ\\nN66rWKVd69djL4JAwehdFXiAuh9nWXUI81S7F0dZ0QKBgQD0rJ3T9y1t+xjWe3iu\\ncniBGnqHjbrXcYTVazqU8UdBUVCnb4EHYMWK9Ylz+TAMkgRl2YzawpSvofoBDrg+\\nQDCQPTP3hUJiTIGVhW2+G11UCIZkx+CTs4X1nZtvtnHO3971L961y4fMtbBpdawX\\ne/f8uq58f+k95OFhh/wquxLZtQKBgQDomDLvvS9n2ZRNuktvyWoYNsJ3442oSYuU\\nBqpS7zoZu7JqfXhZrvse4CZF35jRso/4d1YrlotTeQ01XnO81LgOX+B4TcJzMnjL\\nZusqexb65Z7fmS8oFiqd/RwTGaVQJpAUig0I3bhcLyxAeT+8mvxVcQduHl0Uq7Z7\\nsHBPtSJjEQKBgQDx0IQv0JP6pXbXy7HrH0FPv16oCABIG26ACvkb6RZWTMpcoMwy\\nAYdbHe6aSwYc9lcYXhliv3p51qkiUGzxQTl95K8ui2qfgiN0JinfAGaNvdstUYn4\\nEC5uIDVWBEeYgRN22bfPjncJb+wJXn4Vu7TM96epbjWTsVi6rs4fYUJxHQKBgG8h\\nsUystsbGxb4xobOCp8dz+oyv09IxeZg7awv/M2JyNPf+hQ9MtL122bKO+ARRbcqI\\nskpXPrCeaPoz69awSFTN6IFyndLOrbp5rSj58Ovl5HfvSAG+PZSJB+30VfEqy7KU\\nl0/CKEEbZOhVRmfGIYRtYeByb4Td2m3UyoS7BfgRAoGBAJjWFfYGLTH/Ht9zu3j7\\nKAk/iCyeQ0DDaDhwOnzoQvNhsxQrod17WX6HwH8t+XnS17aoh7M+cahp8QwSmfnF\\nvKvrL/ZxGTXW2JcGrXk2nqlIkMYfu5u0nVo0O9/6Jo1rRXt17MQNcVc2Fa+QPhF6\\nU4MtLG+fVXYzgdskYsA4H86I\\n-----END PRIVATE KEY-----\\n"
txt_config_client_email = "t2s-936@text2speech-298713.iam.gserviceaccount.com"
txt_config_client_id = "106395684255305641461"
txt_config_auth_uri = "https://accounts.google.com/o/oauth2/auth"
txt_config_token_uri = "https://oauth2.googleapis.com/token"
txt_config_auth_provider_x509_cert_url = "https://www.googleapis.com/oauth2/v1/certs"
txt_config_client_x509_cert_url = "https://www.googleapis.com/robot/v1/metadata/x509/t2s-936%40text2speech-298713.iam.gserviceaccount.com"

# laparts-ui config
laparts_app_docker_image_name = "abidurrehman/laparts-ui"
laparts_app_docker_image_tag = "latest"
razzle_host_username = "admin@hostserviceuk.com"
razzle_host_password = "8EF710BC"
razzle_google_api_key = "AIzaSyB6w_WDy6psJ5HPX15Me1-o6CkS5jTYWnE"
razzle_google_client_id = "934759428954-a4i3n9drtqdmiiu44nshdqn7hjflek7p.apps.googleusercontent.com"
razzle_paypal_client_id = "AXofz3yL4F5w-CxSFA6WooO1MvmjtLKQ4SadIJKWZPUubMxNJrev_z7GpKUAyoYVd6I3rjwb3YayqjNY"