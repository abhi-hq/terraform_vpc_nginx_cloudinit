output "public_subnet_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_sg_id" {
  value = aws_security_group.web_sg.id
}