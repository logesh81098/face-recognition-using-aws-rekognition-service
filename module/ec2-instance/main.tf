#####################################################################################################################################
#                                                       Key pair
#####################################################################################################################################

#Creating Keypair EC2 instance

resource "tls_private_key" "project-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "face-rekognition-public-key" {
  key_name = "face-rekognition-public-key"
  public_key = tls_private_key.project-key.public_key_openssh
}

resource "local_file" "face-rekognition-private-key" {
  filename = "face-rekognition-private-key"
  content = tls_private_key.project-key.private_key_openssh
}

#####################################################################################################################################
#                                                       EC2 Instance
#####################################################################################################################################

#EC2 instance to Host Face Rekognition Application

resource "aws_instance" "face-rekognition" {
  ami = var.ami-id
  subnet_id = var.subnet-id
  instance_type = var.instance-type
  security_groups = [var.security-group]
  key_name = aws_key_pair.face-rekognition-public-key.key_name
  user_data = <<-EOF
  #!/bin/bash
  sudo su
  set -eux
  dnf update -y
  dnf upgrade -y
  dnf install -y git
  git --version 
  dnf install -y docker
  docker version
  usermod -aG docker ec2-user
  systemctl start docker
  systemctl enable docker
  git clone https://github.com/logesh81098/face-recognition-using-aws-rekognition-service.git
  EOF
  tags = {
    Name = "Face-Rekognition-Server"
    Project = "Face-Rekognition"
  }
}



