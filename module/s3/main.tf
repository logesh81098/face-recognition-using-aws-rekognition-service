#####################################################################################################################################
#                                                     S3 Bucket
#####################################################################################################################################

#S3 bucket to store source image
resource "aws_s3_bucket" "source-bucket" {
  bucket = "individuals-source-image"
  tags = {
    Name = "individuals-source-image"
    Project = "Face-Rekognition"
  }
}