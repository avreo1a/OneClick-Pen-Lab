resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

#Internet Gateway for VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_igw"
  }
}

#Routing table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}

#Routing table for the public subnet
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "private_route_table"
  }
}

#assosication routing for public/private subnets
resource aws_route_table_association "public_subnet_association" {
  subnet_id      = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource aws_route_table_association "private_subnet_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


#Public Subnet for Kali Instance
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a" 

  tags = {
    Name = "main_subnet"
  }
}

#Private Subnet for DVWA Instance
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false #private subnet does not map public IPs
  availability_zone       = "us-east-1a" 
  tags = {
    Name = "private_subnet"
  }
}


#Creating an elastic IP(Static) assigned to the NAT
resource "aws_eip" "nat_gateway_eip" {
  tags = {
    Name = "nat_gateway_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.main_subnet.id

  tags = {
    Name = "nat_gateway"
  }

  depends_on = [ aws_internet_gateway.igw ]
}


resource "aws_security_group" "kali_sg" {

  name        = "kali_security_group"
  description = "Allowing SSH from your IP and outbound to targets"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #right now the IP is accessible to any inbound but eventually change this to = [var.your_ip] Lock to your IP
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] #allow all outbound
  }
} 

resource "aws_security_group" "dvwa_sg" {

  name        = "dvwa_security_group"
  description = "Allowing HTTP and SSH from Kali"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
  security_groups = [aws_security_group.kali_sg.id]
  }
}