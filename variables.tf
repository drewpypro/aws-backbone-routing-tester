variable "SOURCE_SSH_NET" {
  description = "Public IP to SSH to consumer ec2"
  type        = list(string)
}

variable "PUBLIC_KEY" {
  description = "Public SSH key"
  type        = string
}
