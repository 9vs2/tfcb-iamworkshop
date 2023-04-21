resource "aws_iam_policy" "awsiamworkshop1" {
  name        = "awsworkshop-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"

#   policy = templatefile("policy.json.tftpl",{})
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowDepartmentEC2Management",
            "Effect": "Allow",
            "Action": "ec2:*",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:ResourceTag/department": "$${aws:PrincipalTag/department}"
                }
            }
        },
        {
            "Sid": "AllowEC2DescribeAll",
            "Effect": "Allow",
            "Action": "ec2:Describe*",
            "Resource": "*"
        },
        {
            "Sid": "DenyTagManagement",
            "Effect": "Deny",
            "Action": [
                "iam:UntagUser",
                "iam:UntagRole",
                "ec2:DeleteTags",
                "ec2:CreateTags",
                "iam:TagRole",
                "iam:TagUser"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "pawsiamworkshop2" {
  name        = "awsworkshop2-${var.resourcesuffix}"
  path        = "/"
  description = "My test policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": "sts\:AssumeRole",
        "Resource": "*",
        "Condition": {"StringLike": {"iam\:ResourceTag/contractors-assume-role": "true"}}
    }
  ]
}
EOF
}
# }



# data "aws_iam_policy_document" "awsiamworkshop1" {
#   statement {
#     sid = "AllowDepartmentEC2Management"
#     effect = "Allow"
#     actions = [
#       "s3:GetObject",
#       "s3:DeleteObject",
#     ]
#     resources = [
#       "arn:aws:s3:::test-ndgegy4364gdu-source-bucket/images/*"
#     ]
#   }

#   statement {
#     sid = "allowListBucket"
#     actions = [
#       "s3:ListBucket",
#     ]
#     resources = [
#       "arn:aws:s3:::test-ndgegy4364gdu-source-bucket",
#       "arn:aws:s3:::test-ndgegy4364gdu-source-bucket/images/*"
#     ]
#   }

#   statement {
#     sid = "putObject"
#     actions = [
#       "s3:PutObject",
#     ]
#     resources = [
#       "arn:aws:s3:::test-ndgegy4364gdu-destination-bucket/images/*"
#     ]
#   }

# }