#####################################################################################################################################
#                                                     Security Groups
#####################################################################################################################################

#Security Groups for EC2 instance

resource "aws_security_group" "face-rekognition-sg" {
  name = "Face-Rekognition-SG"
  vpc_id = var.vpc-id
  description = "Security Group created for EC2 instance which hosts Face Rekognition application"
  ingress {
    from_port = 81
    to_port = 81
    protocol = "tcp"
    cidr_blocks = [var.application-cidr]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.application-cidr]
  }
  tags = {
    Name = "Face-Rekognition-SG"
    Project = "Face-Rekognition"
  }
}