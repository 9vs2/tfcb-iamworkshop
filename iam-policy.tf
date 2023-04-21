resource "aws_iam_policy" "policy" {
  name        = "awsworkshop-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

  policy = templatefile("policy.json.tftpl",{})
}

resource "aws_iam_policy" "policy-for-role-assumption" {
  name        = "awsworkshop-role-assumption-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

  policy = templatefile("policy-for-role-assumption.json-contractorroleassumption.tftpl",{})
}
