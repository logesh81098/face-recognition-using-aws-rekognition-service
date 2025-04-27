#####################################################################################################################################
#                                                       VPC
#####################################################################################################################################

#VPC for EC2 instance

resource "aws_vpc" "face-rekognition-vpc" {
  cidr_block = var.vpc-cidr
  tags = {
    Name = "Face-Rekognition-VPC"
    Project = "Face-Rekognition"
  }
}


#####################################################################################################################################
#                                                    VPC - Subnet
#####################################################################################################################################

#Public Subnet for EC2 instance

resource "aws_subnet" "public-subnet-1" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  cidr_block = var.public-subnet-1-cidr
  availability_zone = var.az-1
  map_public_ip_on_launch = true
  tags = {
    Name = "Face-Rekognition-Public-Subnet-1"
    Project = "Face-Rekognition"
  }
}

resource "aws_subnet" "public-subnet-2" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  cidr_block = var.public-subnet-2-cidr
  availability_zone = var.az-2
  map_public_ip_on_launch = true
  tags = {
    Name = "Face-Rekognition-Public-Subnet-2"
    Project = "Face-Rekognition"
  }
}

#####################################################################################################################################
#                                                    VPC - Route Table
#####################################################################################################################################

#Route Table for VPC

resource "aws_route_table" "face-rekognition-route-table" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  route {
    gateway_id = aws_internet_gateway.face-rekognition-igw.id
    cidr_block = "0.0.0.0/0"
  }
  tags = {
    Name = "Face-Rekognition-Route-Table"
    Project = "Face-Rekognition"
  }
}

#Route Table for Association
resource "aws_route_table_association" "route-table-association-1" {
  subnet_id = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.face-rekognition-route-table.id
}

resource "aws_route_table_association" "route-table-association-2" {
  subnet_id = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.face-rekognition-route-table.id
}

#####################################################################################################################################
#                                                    VPC - Internet Gateway
#####################################################################################################################################

#Internet Gateway for Public Subnets
resource "aws_internet_gateway" "face-rekognition-igw" {
  vpc_id = aws_vpc.face-rekognition-vpc.id
  tags = {
    Name = "Face-Rekognition-IGW"
    Project = "Face-Rekognition"
  }
}