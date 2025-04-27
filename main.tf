module "s3" {
  source = "./module/s3"
  lambda-function-arn = module.lambda-function.faceprints-function-arn
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
  iam-role-rekognition-faceprints-arn = module.iam-role.rekognition-faceprints-role
  s3-bucket-arn = module.s3.s3-bucket-arn
}

module "vpc" {
  source = "./module/vpc"
}

module "security-group" {
  source = "./module/security-group"
  vpc-id = module.vpc.vpc-id
}