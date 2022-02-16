resource "aws_iam_user" "user-berca" {
    count = "${length(var.username)}"
    name = "${element(var.username,count.index)}"
}

resource "aws_iam_role" "my_role" {
  name               = "my_role"
  assume_role_policy = file("${path.module}/my/path/my_policy.json")
}

resource "aws_iam_policy" "customer-policy" {
  name        = "customer_policy"
  path        = "/"
  policy = "${file("billingPolicy.json")}"
}

resource "aws_iam_policy" "billing-policy" {
  name        = "customer_policy"
  path        = "/"
  policy = "${file("customerPolicy.json")}"
}

resource "aws_iam_policy_attachment" "customer-attachment" {
  name       = "test-attachment"
  users      = "${element(var.username, 0)}"
  policy_arn = aws_iam_policy.customer-policy.arn
}

resource "aws_iam_policy_attachment" "billing-attachment" {
  name       = "policy-attachment"
  users      = "${element(var.username, 1)}"
  policy_arn = aws_iam_policy.billing-policy.arn
}