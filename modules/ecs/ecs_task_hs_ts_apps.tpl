[
  {
    "name": "ts-api-app",
    "image": "${ts_api_app_docker_image}",
    "cpu": 150,
    "memory": 200,
    "memoryReservation": 150,
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
    "volumesFrom": [],
    "environment": []
  },
  {
    "name": "ts-app",
    "image": "${ts_app_docker_image}",
    "cpu": 150,
    "memory": 200,
    "memoryReservation": 150,
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
  }
]
