resource "aws_instance" "ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet.id
  security_groups = [aws_security_group.ec2_sg.id]
  
  tags = {
    Name = "ec2-${var.region}"
  }

  # iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    http_protocol_ipv6          = "disabled"
  }

  user_data = templatefile("scripts/consumer_ec2.sh", {
    public_key = var.PUBLIC_KEY
  })

}


resource "aws_eip" "ec2_eip" {
  instance = aws_instance.ec2.id
  domain   = "vpc"
}
