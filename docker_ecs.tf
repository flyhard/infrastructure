resource "aws_ecs_cluster" "docker" {
  name = "docker"
}
resource "aws_ecs_task_definition" "consul" {
  family = "consul"
  volume= {
      name = "dockerSock"
      host_path = "/var/run/docker.sock"
  }
  container_definitions = <<EOF
[
  {
    "name": "consul",
    "image": "flyhard/consul",
    "essential": true,
    "command": [
      "-bootstrap",
      "-atlas",
      "${var.atlasName}",
      "-atlas-token",
      "${var.atlas_token}",
      "-atlas-join"
    ],
    "memory": 50,
    "cpu": 1,
    "portMappings": [
    ]
  },
  {
    "name": "registrator",
    "image": "gliderlabs/registrator:latest",
    "essential": true,
    "command": [
      "consul://consul:8500"
    ],
    "memory": 50,
    "cpu": 1,
    "mountPoints": [
      {
        "sourceVolume": "dockerSock",
        "containerPath": "/tmp/docker.sock"
      }
    ],
    "links": [
      "consul:consul"
    ]
  }
]
EOF
}
resource "aws_ecs_service" "consul" {
  name = "consul"
  cluster = "${aws_ecs_cluster.docker.id}"
  count = 1
  desired_count = 1
  task_definition = "${aws_ecs_task_definition.consul.arn}"
}
