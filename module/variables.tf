variable "region" {
  description = "Region"
  type        = string
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
  type        = list(string)
}

variable "PUBLIC_KEY" {
  description = "Public SSH key"
  type        = string
}

variable "IP_LIST" {
  description = "IPs used for toucher script"
  type        = string
}