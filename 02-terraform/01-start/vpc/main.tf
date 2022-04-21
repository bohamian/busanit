provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_vpc" "vpc-std22" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "std22"
  }
}

data "aws_vpcs" "this" {}

output "vpc-std22" {
  value = data.aws_vpcs.this
}