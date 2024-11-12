# AMI ID,AMI Name,Region
# ami-09190d816c07cca00,al2023-ami-minimal-2023.6.20241010.0-kernel-6.1-x86_64,us-east-1
# ami-0fb081d9d19c88d61,al2023-ami-minimal-2023.5.20240819.0-kernel-6.1-x86_64,us-east-2
# ami-086a2d9f28fe39627,al2023-ami-minimal-2023.6.20241031.0-kernel-6.1-x86_64,us-west-1
# ami-0c968d9bc191231c8,al2023-ami-minimal-2023.6.20241031.0-kernel-6.1-x86_64,us-west-2
# ami-02e6e695469fdfaac,al2023-ami-minimal-2023.5.20240819.0-kernel-6.1-x86_64,eu-west-1
# None,il-central-1


variable "ami_ids" {
  default = {
    "us-east-1" = "ami-09190d816c07cca00"
    "us-east-2" = "ami-0fb081d9d19c88d61"
    "us-west-1" = "ami-086a2d9f28fe39627"
    "us-west-2" = "ami-0c968d9bc191231c8"
    "eu-west-1" = "ami-02e6e695469fdfaac"
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
