
resource "aws_security_group" "ec2_sg" {
  for_each = aws_vpc.vpc
  vpc_id   = each.value.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.SOURCE_SSH_NET]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${each.key}-ec2-sg"
  }

}

resource "aws_instance_security_group_association" "ec2_sg_association" {
  for_each = aws_instance.ec2

  instance_id       = each.value.id
  security_group_id = aws_security_group.ec2_sg[each.key].id
}

# No Default Allow on default sg
resource "aws_default_security_group" "sg_default" {
  for_each = aws_vpc.vpc
  vpc_id   = each.value.id
}

