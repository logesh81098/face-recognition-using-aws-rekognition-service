#####################################################################################################################################
#                                                     Archive Files
#####################################################################################################################################


data "archive_file" "rekognition-collection-id" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/create-rekognition-collection-id.zip"
}


#####################################################################################################################################
#                                                     Lambda Function
#####################################################################################################################################

#Lambda Function to create Rekognition Collection ID

resource "aws_lambda_function" "rekognition-collection-id" {
  function_name = "create-rekognition-collection-id"
  filename = "module/lambda-function/create-rekognition-collection-id.zip"
  runtime = "python3.8"
  role = var.iam-role-create-rekognition-collection-arn
  handler = "create-rekognition-collection-id.lambda_handler"
  timeout = "20"
  tags = {
    Name = "create-rekognition-collection-id"
    Project = "Face-Rekognition"
  }
}


#####################################################################################################################################
#                                                     Archive Files
#####################################################################################################################################

data "archive_file" "rekognition-faceprints" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/rekognition-faceprints.zip"
}



#####################################################################################################################################
#                                                     Lambda Function
#####################################################################################################################################

#Lambda Function to Index Faceprints

resource "aws_lambda_function" "rekognition-faceprints" {
  function_name = "rekognition-faceprints"
  filename = "module/lambda-function/rekognition-faceprints.zip"
  runtime = "python3.8"
  role = var.iam-role-rekognition-faceprints-arn
  handler = "rekognition-faceprints.lambda_handler"
  timeout = "20"
  tags = {
    Name = "rekognition-faceprints"
    Project = "Face-Rekognition"
  }
}


#S3 to trigger lambda function for each Object creation
resource "aws_lambda_permission" "s3-invoke-lambda" {
  function_name = aws_lambda_function.rekognition-faceprints.function_name
  statement_id = "s3-invoke-lambda"
  action = "lambda:InvokeFunction"
  principal = "s3.amazonaws.com"
  source_arn = var.s3-bucket-arn
}