#####################################################################################################################################
#                                                     DynamoDB Table
#####################################################################################################################################

#DynamoDB table to store images face prints

resource "aws_dynamodb_table" "faceprints-table" {
  name = "faceprints-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "Rekognitionid"
  attribute {
    type = "S"
    name = "Rekognitionid"
  }
  tags = {
    Name = "faceprints-table"
    Project = "Face-Rekognition"
  }
}