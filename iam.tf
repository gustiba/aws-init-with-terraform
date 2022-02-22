data "local_file" "pgp_key" {
  filename = "public-key-binary.gpg"
}

resource "aws_iam_user" "user-berca" {
    count = "${length(var.username)}"
    name = "${element(var.username,count.index)}"
}

// ADD MORE BLOCK OF RESOURCE AWS_IAM_POLICY IF THERE IS MORE USER NEEDED
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

// ADD MORE BLOCK OF RESOURCE AWS_IAM_POLICY_ATTACHMENT IF THERE IS MORE USER NEEDED
// CHANGE [0] ACCORDING TO ARRAY LIST IN THE VARIABLE
resource "aws_iam_policy_attachment" "billing-attachment" {
  name       = "policy-attachment"
  users      = [aws_iam_user.user-berca[0].name]
  policy_arn = aws_iam_policy.billing-policy.arn

  depends_on = [aws_iam_policy.billing-policy]
}

resource "aws_iam_policy_attachment" "customer-attachment" {
  name       = "test-attachment"
  users      = [aws_iam_user.user-berca[1].name]
  // it can be use like this for get the string value
  // users = aws_iam_user.user-berca.0.name
  policy_arn = aws_iam_policy.customer-policy.arn
  
  depends_on = [aws_iam_policy.customer-policy]
}

// use this command for generate gpg key (linux based)
// gpg --generate-key
// gpg --export | base64 > public.gpg
resource "aws_iam_user_login_profile" "user-console" {
  count = "${length(var.username)}"
  user    = aws_iam_user.user-berca[count.index].name
  password_reset_required = false
  pgp_key = "keybase:gustiba"
  //pgp_key = data.local_file.pgp_key.content_base64
}

resource "aws_iam_account_password_policy" "password-policy" {
  minimum_password_length        = 12
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

// execute command echo "encrypted_password" | base64 -d | gpg -d
output "password" {
  value = aws_iam_user_login_profile.user-console.*.encrypted_password
}