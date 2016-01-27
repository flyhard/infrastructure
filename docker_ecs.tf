resource "aws_ecs_cluster" "docker" {
  name = "docker"
}
resource "aws_ecs_task_definition" "consul" {
  family = "consul"
  container_definitions = <<EOF
[
  {
    "name": "consul",
    "image": "flyhard/consul",
    "essential": true,
    "command": [
      "-atlas",
      "flyhard/atlas",
      "-atlas-token",
      "${var.atlas_token}",
      "-atlas-join"
    ],
    "memory": 50,
    "cpu": 1,
    "portMappings": [
      {
        "containerPort": 8500,
        "hostPort": 80
      }
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
