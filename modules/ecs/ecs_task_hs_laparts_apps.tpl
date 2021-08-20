[
  {
    "name": "laparts-api-app",
    "image": "${laparts_api_app_docker_image}",
    "cpu": 150,
    "memory": 256,
    "memoryReservation": 150,
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
  },
  {
    "name": "laparts-app",
    "image": "${laparts_app_docker_image}",
    "cpu": 150,
    "memory": 200,
    "memoryReservation": 150,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3001
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": [],
    "environment": [
      {
        "name": "RAZZLE_HOSTUK_USERNAME",
        "value": "${razzle_host_username}"
      },
      {
        "name": "RAZZLE_HOSTUK_PASSWORD",
        "value": "${razzle_host_password}"
      },
      {
        "name": "RAZZLE_GOOGLE_API_KEY",
        "value": "${razzle_google_api_key}"
      },
      {
        "name": "RAZZLE_GOOGLE_CLIENT_ID",
        "value": "${razzle_google_client_id}"
      },
      {
        "name": "RAZZLE_PAYPAL_CLIENT_ID",
        "value": "${razzle_paypal_client_id}"
      }
    ]
  }
]
