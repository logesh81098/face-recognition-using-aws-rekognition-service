module "s3" {
  source = "./module/s3"
}

module "dynamodb" {
  source = "./module/dynamodb"
}

module "iam-role" {
  source = "./module/iam-role"
}

module "lambda-function" {
  source = "./module/lambda-function"
  iam-role-create-rekognition-collection-arn = module.iam-role.create-rekognition-collection-id-iam-role
}