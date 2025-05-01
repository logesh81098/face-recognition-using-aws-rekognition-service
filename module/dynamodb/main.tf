#####################################################################################################################################
#                                                     DynamoDB Table
#####################################################################################################################################

#DynamoDB table to store images face prints

resource "aws_dynamodb_table" "faceprints-table" {
  name           = "faceprints-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Rekognitionid"
  attribute {
    name = "Rekognitionid"
    type = "S"
  }

  attribute {
    name = "FullName"
    type = "S"
  }

  global_secondary_index {
    name               = "FullName-index"
    hash_key           = "FullName"
    projection_type    = "ALL"  # You can change this depending on what attributes you need to project
    read_capacity      = 5
    write_capacity     = 5
  }

  tags = {
    Name    = "faceprints-table"
    Project = "Face-Rekognition"
  }
}
