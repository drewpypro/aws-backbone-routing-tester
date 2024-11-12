resource "aws_instance" "ec2" {
  for_each = aws_subnet.subnet

  ami           = var.ami_ids[each.key]
  instance_type = var.instance_type
  subnet_id     = each.value.id
  security_groups = [aws_security_group.ec2_sg[each.key].id]
  
  tags = {
    Name = "${each.key}-ec2"
  }

  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name

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

## ELASTIC IP
resource "aws_eip" "ec2_eip" {
  for_each = aws_instance.ec2
  instance = each.value.id
  domain   = "vpc"
}

output "instance_public_ips" {
  value = { for region, instance in aws_instance.ec2 : region => instance.public_ip }
}