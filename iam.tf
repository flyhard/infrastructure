resource "aws_iam_instance_profile" "default" {
  name = "ecsInstanceProfile"
  roles = [
    "${aws_iam_role.ecsRole.name}"]
}

resource "aws_iam_role" "ecsRole" {
  name = "ecsRole"
  assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
      {
          "Action": "sts:AssumeRole",
          "Principal": {
              "Service": "ec2.amazonaws.com"
          },
          "Effect": "Allow",
          "Sid": ""
      }
  ]
}
EOF
}

