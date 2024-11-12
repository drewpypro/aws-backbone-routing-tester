variable "ami_ids" {
  default = {
    "us-east-1" = "ami-06ff9e92a8fecbb77"
    "us-east-2" = "ami-0fb081d9d19c88d61"
    "us-west-1" = "ami-0d4c90c7f333a7d17"
    "us-west-2" = "ami-03b2bc8987ca3dce7"
    "eu-west-1" = "ami-0eae74a2795d511c8"
  }
}

module "vpc_ec2_us_east_1" {
  source         = "./module"
  providers      = { aws = aws.us-east-1 }
  region         = "us-east-1"
  ami_id         = var.ami_ids["us-east-1"]
  SOURCE_SSH_NET = var.SOURCE_SSH_NET
  PUBLIC_KEY     = var.PUBLIC_KEY
}

module "vpc_ec2_us_east_2" {
  source         = "./module"
  providers      = { aws = aws.us-east-2 }
  region         = "us-east-2"
  ami_id         = var.ami_ids["us-east-2"]
  SOURCE_SSH_NET = var.SOURCE_SSH_NET
  PUBLIC_KEY     = var.PUBLIC_KEY
}

module "vpc_ec2_us_west_1" {
  source         = "./module"
  providers      = { aws = aws.us-west-1 }
  region         = "us-west-1"
  ami_id         = var.ami_ids["us-west-1"]
  SOURCE_SSH_NET = var.SOURCE_SSH_NET
  PUBLIC_KEY     = var.PUBLIC_KEY
}

module "vpc_ec2_us_west_2" {
  source         = "./module"
  providers      = { aws = aws.us-west-2 }
  region         = "us-west-2"
  ami_id         = var.ami_ids["us-west-2"]
  SOURCE_SSH_NET = var.SOURCE_SSH_NET
  PUBLIC_KEY     = var.PUBLIC_KEY
}

module "vpc_ec2_eu_west_1" {
  source         = "./module"
  providers      = { aws = aws.eu-west-1 }
  region         = "eu-west-1"
  ami_id         = var.ami_ids["eu-west-1"]
  SOURCE_SSH_NET = var.SOURCE_SSH_NET
  PUBLIC_KEY     = var.PUBLIC_KEY
}
