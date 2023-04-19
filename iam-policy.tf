resource "aws_iam_policy" "policy" {
  name        = "awsworkshop-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

  policy = templatefile("policy.json.tftpl", {
    aws_account_id = data.aws_caller_identity.current.account_id
    aws_region = var.aws_region,
    function_name = var.function_name
  })
}

resource "aws_iam_policy" "policy_for_iam" {
  name = "policy_${var.service_name}"
  policy = templatefile("policy.json.tftpl")
}