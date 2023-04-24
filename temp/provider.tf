provider "aws" {
    region = "ap-northeast-3"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

variable "resourcesuffix" {
    default = "tfcb-jsgu"
}