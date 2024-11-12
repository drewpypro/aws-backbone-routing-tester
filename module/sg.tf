resource "aws_security_group" "ec2_sg" {
  vpc_id   = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.SOURCE_SSH_NET
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-sg-${var.region}"
  }

}

# No Default Allow on default sg
resource "aws_default_security_group" "sg_default" {
  vpc_id   = aws_vpc.vpc.id
}
