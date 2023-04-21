# variable "policies" {
#   type = list(object({
#     name      = string
#     statement = object
#   }))
#   default = [
#     {
#       name = "awsworkshop-${var.resourcesuffix}"
#       statement = {
#         sid       = "XXX"
#         actions   = ["ec2:XXX"]
#         resources = ["XXX"]
#       }
#     },
#     {
#       name = "awsworkshop-role-assumption-${var.resourcesuffix}"
#       statement = {
#         sid       = "XXX"
#         actions   = ["ec2:XXX"]
#         resources = ["XXX"]
#       }
#     }
#   ]
# }

# data "aws_iam_policy_document" "this" {
#   for_each = { for policy in var.policies : policy.name => policy }

#   statement = each.value.statement
# }

# resource "aws_iam_policy" "this" {
#   for_each = { for policy in var.policies : policy.name => policy }

#   name   = format("${local.csi}-%s", each.key)
#   path   = "/"
#   policy = data.aws_iam_policy_document.this[each.key].json
# }

# resource "aws_iam_group" "this" {
#   for_each = { for policy in var.policies : policy.name => policy }

#   name = each.key
# }

# resource "aws_iam_group_policy_attachment" "security_read_only" {
#   for_each = { for policy in var.policies : policy.name => policy }

#   group      = aws_iam_group.this[each.key].name
#   policy_arn = aws_iam_policy.this[each.key].arn
# }