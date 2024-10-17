provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}
resource "aws_vpc" "my_vpc_terraform" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "my_vpc_terraform"
  }
}
resource "aws_subnet" "my_subnet_1" {
  vpc_id                  = aws_vpc.my_vpc_terraform.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-1"
  }
}
resource "aws_subnet" "my_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc_terraform.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-2"
  }
}
resource "aws_subnet" "my_private_subnet_2" {
  vpc_id                  = aws_vpc.my_vpc_terraform.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-private-subnet-2"
  }
}
resource "aws_subnet" "my_private_subnet_3" {
  vpc_id                  = aws_vpc.my_vpc_terraform.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "my-private-subnet-3"
  }
}
resource "aws_internet_gateway" "my_duvan" {
  vpc_id = aws_vpc.my_vpc_terraform.id
  tags = {
    Name = "my-duvan"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.my_vpc_terraform.id
  tags = {
    Name = "route-table"
  }
}
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_duvan.id
}
resource "aws_route_table_association" "subnet_1_association" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "subnet_2_association" {
  subnet_id      = aws_subnet.my_subnet_2.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc_terraform.id
  tags = {
    Name = "private-route-table"
  }
}
resource "aws_route_table_association" "private_subnet_2_association" {
  subnet_id      = aws_subnet.my_private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_subnet_3_association" {
  subnet_id      = aws_subnet.my_private_subnet_3.id
  route_table_id = aws_route_table.private_route_table.id
}
