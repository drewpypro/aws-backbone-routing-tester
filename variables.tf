variable "regions" {
  default = ["us-east-1", "us-east-2", "us-west-1", "us-west-2", "eu-west-1", "me-central-1"]
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0427090fd1714168b"
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "SOURCE_SSH_NET" {
  description = "Public IP to SSH to consumer ec2"
  type        = string
}

variable "PUBLIC_KEY" {
  description = "Public SSH key"
  type        = string
}

# getami.py - 11-11-2024@13:56MST
# AMI ID,AMI Name,Region
# ami-06ff9e92a8fecbb77,al2023-ami-minimal-2023.5.20240819.0-kernel-6.1-x86_64,us-east-1
# ami-0fb081d9d19c88d61,al2023-ami-minimal-2023.5.20240819.0-kernel-6.1-x86_64,us-east-2
# ami-03b2bc8987ca3dce7,al2023-ami-minimal-2023.5.20240903.0-kernel-6.1-x86_64,us-west-1
# ami-0eae74a2795d511c8,al2023-ami-minimal-2023.5.20241001.1-kernel-6.1-x86_64,us-west-2
# ami-05448b0a80dd813cf,al2023-ami-minimal-2023.5.20241001.1-kernel-6.1-x86_64,eu-west-1
# ,,il-central-1

variable "ami_ids" {
  default = {
    "us-east-1" = "ami-06ff9e92a8fecbb77"
    "us-east-2" = "ami-0fb081d9d19c88d61"
    "us-west-1" = "ami-0d4c90c7f333a7d17"
    "us-west-2" = "ami-03b2bc8987ca3dce7"
    "eu-west-1" = "ami-0eae74a2795d511c8"
    # "me-central-1"   = "ami-05448b0a80dd813cf"
  }
}