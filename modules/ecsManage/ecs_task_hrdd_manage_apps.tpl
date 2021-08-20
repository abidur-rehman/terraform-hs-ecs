[
  {
    "name": "prometheus-app",
    "image": "${prometheus_docker_image}",
    "cpu": 500,
    "memory": 512,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 9090,
        "hostPort": 9090
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": [],
    "environment": []
  },
  {
    "name": "grafana-app",
    "image": "${grafana_docker_image}",
    "cpu": 500,
    "memory": 512,
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
    "environment": []
  },
  {
    "name": "cad-app",
    "image": "google/cadvisor",
    "cpu": 10,
    "memory": 300,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ],
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [
      {
        "sourceVolume": "root",
        "containerPath": "/rootfs",
        "readOnly": true
      },
      {
        "sourceVolume": "var_run",
        "containerPath": "/var/run",
        "readOnly": false
      },
      {
        "sourceVolume": "sys",
        "containerPath": "/sys",
        "readOnly": true
      },
      {
        "sourceVolume": "var_lib_docker",
        "containerPath": "/var/lib/docker",
        "readOnly": true
      },
      {
        "sourceVolume": "dev_disk",
        "containerPath": "/dev/disk",
        "readOnly": true
      },
      {
        "sourceVolume": "cgroup",
        "containerPath": "/sys/fs/cgroup",
        "readOnly": true
      }
    ],
    "volumesFrom": [],
    "environment": []
  }
]
