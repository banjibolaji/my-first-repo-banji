resource "aws_vpc" "banjiVpc" {
    cidr_block = var.banjiVpcCidr
    tags = {
      "Name" = "banjiVpc"
    }
}

resource "aws_subnet" "myPubSubnet" {
  vpc_id = aws_vpc.banjiVpc.id
  cidr_block = var.myPubSubnetCidr
  availability_zone = var.Az
  tags = {
    "Name" = "myPubSubnet"
  }
}

resource "aws_subnet" "myPriSubnet" {
  vpc_id = aws_vpc.banjiVpc.id
  cidr_block = var.myPriSubnetCidr[count.index]
  availability_zone = var.Az
  tags = {
    "Name" = "myPriSubnet-${count.index}"
  }
  count = 2
}

resource "aws_internet_gateway" "banjiigw" {
  vpc_id = aws_vpc.banjiVpc.id
}

resource "aws_route_table" "pubsubrt" {
  vpc_id = aws_vpc.banjiVpc.id
}

resource "aws_route" "pubsubroute" {
  route_table_id = aws_route_table.pubsubrt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.banjiigw.id
}

resource "aws_security_group" "tf-sg" {
  name        = "tf-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.banjiVpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.banjiVPC.cidr_block]

  }
  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.banjiVPC.cidr_block]
    
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "testec2" {
  ami           = var.ami_id["Linux"]
  instance_type = var.instance-type[0]
  count = 2
  tags = {"Name"  = "TestEC2-${count.index}"}
  vpc_security_group_ids = aws_security_gro
}