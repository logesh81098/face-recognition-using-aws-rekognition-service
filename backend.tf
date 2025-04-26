terraform {
  backend "s3" {
    bucket = "terraform-backend-files-logesh"
    key = "face-recognition-using-aws-rekognition-service"
    region = "us-east-1"
  }
}