#####################################################################################################################################
#                                                       EC2 Instance
#####################################################################################################################################

#EC2 instance to Host Face Rekognition Application

resource "aws_instance" "face-rekognition" {
  ami = var.ami-id
  subnet_id = var.subnet-id
  instance_type = var.instance-type
  security_groups = [var.security-group]
  tags = {
    Name = "Face-Rekognition-Server"
    Project = "Face-Rekognition"
  }
}