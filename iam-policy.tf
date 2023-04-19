resource "aws_iam_policy" "policy" {
  name        = "awsworkshop-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

  policy = templatefile("policy.json.tftpl",{})
}
