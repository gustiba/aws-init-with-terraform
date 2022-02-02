resource "aws_iam_user" "user-berca" {
    count = "${length(var.username)}"
    name = "${element(var.username,count.index)}"
}

