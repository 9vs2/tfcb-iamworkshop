# terraform/main.tf

# provider "archive" {}

# data "archive_file" "lambda" {
#   type        = "zip"
#   source_dir  = "../lambda-jsgu"
#   output_path = "lambda.zip"
# }

data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = data.aws_iam_policy_document.AWSLambdaTrustPolicy.json
  name               = "${var.resourcesuffix}-iam-role-lambda-trigger"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_lambda_basic_execution" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "lambda_function" {
  filename = "lambda_function.zip"
  # source_code_hash = "${data.external.lambda_to_zip.result.output_hash}"
  function_name           = "${var.resourcesuffix}-lambda-function"
  role                    = aws_iam_role.iam_role.arn
  handler                 = "index.handler"
  runtime                 = "nodejs14.x"
  timeout                 = 30
  memory_size             = 128
  source_code_hash = filebase64sha256("lambda_function.zip")
}

output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
}