[
  {
    "name": "ts-api-app",
    "image": "${ts_api_app_docker_image}",
    "cpu": 200,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 4000,
        "hostPort": 4000
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [
      {
        "containerPath": "/config",
        "sourceVolume": "ts_config_json",
        "readOnly": true
      }
    ],
    "volumesFrom": [

    ],
    "environment": [
      {
        "name": "DATABASE_URL",
        "value": "${database_url}"
      },
      {
        "name": "DATABASE_USER",
        "value": "${database_user}"
      },
      {
        "name": "DATABASE_PASSWORD",
        "value": "${database_password}"
      }
    ]
  },
  {
    "name": "ts-app",
    "image": "${ts_app_docker_image}",
    "cpu": 200,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": [],
    "environment": [
      {
        "name": "RAZZLE_ENV",
        "value": "${razzle_env}"
      }
    ]
  },
  {
    "name": "laparts-api-app",
    "image": "${laparts_api_app_docker_image}",
    "cpu": 200,
    "memory": 256,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 4001,
        "hostPort": 4001
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": [],
    "environment": [
      {
        "name": "DATABASE_URL",
        "value": "${database_url}"
      },
      {
        "name": "DATABASE_USER",
        "value": "${database_user}"
      },
      {
        "name": "DATABASE_PASSWORD",
        "value": "${database_password}"
      },
      {
        "name": "PAYPAL_CLIENT_ID",
        "value": "${paypal_client_id}"
      },
      {
        "name": "PAYPAL_SECRET",
        "value": "${paypal_secret}"
      }
    ]
  }
]
