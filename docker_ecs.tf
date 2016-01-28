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
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "${var.region}",
        "awslogs-group":"docker"
      }
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
