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
  iam_instance_profile = var.iam-instance-profile
  user_data = <<-EOF
  #!/bin/bash
  sudo su
  set -eux
  dnf update -y
  dnf upgrade -y
  dnf install -y git
  git --version 
  dnf install -y docker
  sudo systemctl enable docker
  sudo systemctl start docker
  sleep 10
  sudo systemctl status docker
  usermod -aG docker ec2-user
  dnf install -y python3 python3-pip
  pip install boto3
  EOF
  tags = {
    Name = "Face-Rekognition-Server"
    Project = "Face-Rekognition"
  }
}



