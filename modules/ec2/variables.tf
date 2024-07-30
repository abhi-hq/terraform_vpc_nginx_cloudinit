variable "pub_sg_id" {
  description = "ID of the security group for the public subnet"
  type        = string
}

variable "pub_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "aminame" {
  description = "AMI name"
  type = string
}