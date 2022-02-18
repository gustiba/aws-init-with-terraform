resource "aws_iam_user" "user-berca" {
    count = "${length(var.username)}"
    name = "${element(var.username,count.index)}"
}

resource "aws_iam_policy" "customer-policy" {
  name        = "customer_policy"
  path        = "/"
  policy = "${file("customerPolicy.json")}"
}

resource "aws_iam_policy" "billing-policy" {
  name        = "billing_policy"
  path        = "/"
  policy = "${file("billingPolicy.json")}"
}

resource "aws_iam_policy_attachment" "customer-attachment" {
  name       = "test-attachment"
  users      = ["${aws_iam_user.user-berca[0].name}"]
  policy_arn = aws_iam_policy.customer-policy.arn
  
  depends_on = [aws_iam_policy.customer-policy]
}

resource "aws_iam_policy_attachment" "billing-attachment" {
  name       = "policy-attachment"
  users      = ["${aws_iam_user.user-berca[1].name}"]
  policy_arn = aws_iam_policy.billing-policy.arn

  depends_on = [aws_iam_policy.billing-policy]
}