provider "aws" {
  region = "eu-north-1"

}

resource "aws_vpc" "test" {
  region     = "eu-north-1"
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "test-server"
  }
}

resource "aws_subnet" "sub-pub" {
  vpc_id            = aws_vpc.test.id
  availability_zone = "eu-north-1a"
  cidr_block        = "10.0.0.0/28"
  tags = {
    Name = "sub-1"
  }
}
resource "aws_subnet" "sub" {
  vpc_id            = aws_vpc.test.id
  availability_zone = "eu-north-1b"
  cidr_block        = "10.0.0.16/28"
  tags = {
    Name = "sub-2"
  }
}
resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "internet"
  }
  vpc_id = aws_vpc.test.id
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.test.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name="rt"
  }
}
resource "aws_route_table_association" "rt-1" {
  route_table_id = aws_route_table.rt.id

  subnet_id = aws_subnet.sub-pub.id
}
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.test.id
  name = "sg"
  ingress {
    from_port = "80"
    to_port   = "80"
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = "0"
    to_port   = "0"
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg"
  }
}
resource "aws_instance" "ec2" {
    ami = "ami-0189c3f216088b7db"
   count = 3
    instance_type = "t3.micro"
    subnet_id = aws_subnet.sub-pub.id
    security_groups = [aws_security_group.sg.id] 
    tags = {
    Name = "AppServer-${count.index}"
    }
}

resource "aws_eip" "eip" {
    domain = "vpc"
}
resource "aws_nat_gateway" "nat" {
    depends_on = [
         aws_internet_gateway.igw ]
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.sub.id
        tags = {
      Name ="nat"
    }
}
resource "aws_route_table" "rt-nat" {
   vpc_id = aws_vpc.test.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
   }
   tags = {
     Name ="nat-gateway"
   }
}

resource "aws_route_table_association" "rt-2" {
  subnet_id = aws_subnet.sub.id
  route_table_id = aws_route_table.rt-nat.id

}
resource "aws_instance" "ec2" {

