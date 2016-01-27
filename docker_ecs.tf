resource "aws_ecs_cluster" "docker" {
  name = "docker"
}
resource "aws_ecs_task_definition" "consul" {
  family = "consul"
  container_definitions = "${file("consul.json")}"
}
resource "aws_ecs_service" "consul" {
  name = "consul"
  cluster = "${aws_ecs_cluster.docker.id}"
  count = 1
  desired_count = 1
  task_definition = "${aws_ecs_task_definition.consul.arn}"
}
