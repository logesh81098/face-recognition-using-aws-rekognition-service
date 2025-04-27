output "vpc-id" {
  value = aws_vpc.face-rekognition-vpc.id
}

output "public-subnet-1" {
  value = aws_subnet.public-subnet-1.id
}