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


data "archive_file" "rekognition-collection-id" {
  type = "zip"
  source_dir = "module/lambda-function"
  output_path = "module/lambda-function/create-rekognition-collection-id.zip"
}