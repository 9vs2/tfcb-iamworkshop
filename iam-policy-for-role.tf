resource "aws_iam_policy" "policy2" {
  name        = "awsworkshop-role-assumption-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

  policy = templatefile("./aws-policy-json/policy.json-contractorroleassumption.tftpl",{})
}
