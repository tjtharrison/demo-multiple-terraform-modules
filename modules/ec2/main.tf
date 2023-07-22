# aws_instance terraform resource
resource "aws_instance" "example" {
  #checkov:skip=CKV2_AWS_41: "This is a test instance, role not required"
  #checkov:skip=CKV_AWS_126: "This is a test instance, detailed monitoring not required"
  ami           = "ami-0786f5bc3943ad52d"
  instance_type = "t2.micro"
  tags = {
    Name = var.name
  }
  security_groups = [aws_security_group.allow_ssh.name]
  ebs_optimized   = true
  root_block_device {
    encrypted = true
  }
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

# Lookup default vpc
data "aws_vpc" "default" {
  default = true
}

# Add security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH from everywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }
}