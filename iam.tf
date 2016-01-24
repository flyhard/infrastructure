resource "aws_iam_instance_profile" "default" {
  name = "ecsInstanceProfile"
  roles = [
    "${aws_iam_role.ecsRole.name}"]
}

resource "aws_iam_role" "ecsRole" {
  name = "ecsRole"
  assume_role_policy = "${file("ecsRole_policy.json")}"
}