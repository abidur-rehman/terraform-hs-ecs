resource "aws_iam_role_policy" "lambda_policy" {
    name = "${var.name_prefix}_${var.environment}_lambda_policy"
    role = aws_iam_role.lambda_role.id
    policy = file("../modules/lambda/lambda_policy.json")
}

resource "aws_iam_role" "lambda_role" {
    name = "${var.name_prefix}_${var.environment}_lambda_role_role"
    assume_role_policy = file("../modules/lambda/lambda_role.json")
}