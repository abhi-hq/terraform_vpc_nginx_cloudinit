data "aws_ami" "amzlnx2023" {
  most_recent = true
  name_regex  = var.aminame
  owners      = ["amazon"]
}

resource "aws_instance" "web_instance" {
  ami           = data.aws_ami.amzlnx2023.id
  instance_type = "t2.micro"

  subnet_id                   = var.pub_subnet_id
  vpc_security_group_ids      = [var.pub_sg_id]
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash -ex
  yum install -y nginx
  systemctl enable --now nginx
  EOF
}