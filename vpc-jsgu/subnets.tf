resource "aws_subnet" "private-ap-northeast-3a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.0.0/19"
  availability_zone = "ap-northeast-3a"

  tags = {
    "Name"                                      = "private-ap-northeast-3a"
    "TerraformTag"                              = "vpc-jsgu-prv-az-3a"
  }
}

resource "aws_subnet" "public-ap-northeast-3a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.64.0/19"
  availability_zone       = "ap-northeast-3a"
  map_public_ip_on_launch = true

  tags = {
    "Name"                                      = "public-ap-northeast-3a"
    "TerraformTag"                              = "vpc-jsgu-pub-az-3a"
  }
}

output "pub_subnet_id" {
  value = aws_subnet.public-ap-northeast-3a.id
}

output "prv_subnet_id" {
  value = aws_subnet.private-ap-northeast-3a.id
}