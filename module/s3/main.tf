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



resource "aws_s3_bucket_notification" "s3-trigger-lambda" {
  bucket = aws_s3_bucket.source-bucket.bucket
  lambda_function {
    lambda_function_arn = var.lambda-function-arn
    events = ["s3:ObjectCreated:*"]
  }
}