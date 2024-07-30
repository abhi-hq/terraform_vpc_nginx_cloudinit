resource "aws_vpc" "temp_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.temp_vpc.id
  cidr_block        = var.public_sub_1_cidr
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.temp_vpc.id
  cidr_block        = var.private_sub_1_cidr
}

resource "aws_internet_gateway" "tempigw" { //igw
  vpc_id = aws_vpc.temp_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.temp_vpc.id //making the route table and attaching the igw to it

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tempigw.id
  }
}
resource "aws_route_table_association" "public_1_rt_a" { // associating the subnet and the route table
  subnet_id      = aws_subnet.public_subnet_1.id 
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "web_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.temp_vpc.id

  ingress = [{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }, 
    {from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]}]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


