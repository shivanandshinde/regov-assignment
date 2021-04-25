resource "aws_iam_policy" "cw_lambda_logging" {
  name        = "cw_lambda_logging"
  
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:CreateLogGroup"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"
  assume_role_policy = aws_iam_policy.cw_lambda_logging.arn
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.cw_lambda_logging.arn
}

data "archive_file" "dummy" {
  type = "zip"
  output_path = "${path.module}/payload.zip"
  source {
      content = "dummy"
      filename = "dummy.txt"
  }
}

resource "aws_lambda_function" "myLambda" {

  function_name = var.function_name
  filename      = data.archive_file.dummy.output_path
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "index.handler"
  runtime       = "nodejs12.x"
  depends_on    = [aws_iam_role_policy_attachment.lambda_logs]
}