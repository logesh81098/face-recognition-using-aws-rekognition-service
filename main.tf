module "s3" {
  source = "./module/s3"
}

module "dynamodb" {
  source = "./module/dynamodb"
}

module "iam-role" {
  source = "./module/iam-role"
}