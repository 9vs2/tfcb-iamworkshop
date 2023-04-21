# resource "aws_iam_policy" "policy2" {
#   name        = "awsworkshop-role-assumption-${var.resourcesuffix}"
#   path        = "/"
#   description = "My test policy"

#   policy = templatefile("policy.json-contractorroleassumption.tftpl",{})
# }
