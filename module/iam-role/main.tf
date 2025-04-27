#####################################################################################################################################
#                                                     IAM Role
#####################################################################################################################################

#IAM Role to create Rekognition Collection ID

resource "aws_iam_role" "rekognition-collection-id-role" {
  name = "rekognition-collection-id"
  description = "IAM Role to Create, List and Delete Rekognition Collection ID"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Principal": {
            "Service":"lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
    }
    ]

}  
EOF
}


#####################################################################################################################################
#                                                     IAM Policy
#####################################################################################################################################

#IAM Policy with permissions to create Rekognition Collection ID

resource "aws_iam_policy" "rekognition-collection-id-create-policy" {
  name = "rekognition-collection-id-create-policy"
  description = "IAM Policy with permission to Create, List and Delete Rekognition Collection ID"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
    {
        "Sid": "CollectingRekognition",
        "Effect": "Allow",
        "Action": [
            "rekognition:CreateCollection",
            "rekognition:DeleteCollection",
            "rekognition:ListCollections"
        ],
        "Resource": "*"
    },
    {
        "Sid": "CWLogGroup",
        "Effect": "Allow",
        "Action": [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    }
    ]
}  
EOF
}


#####################################################################################################################################
#                                                     IAM Role Policy Attachment
#####################################################################################################################################

#Attaching IAM Role and Policy

resource "aws_iam_role_policy_attachment" "rekognition-collection-id-role-policy-attachment" {
  role = aws_iam_role.rekognition-collection-id-role.id
  policy_arn = aws_iam_policy.rekognition-collection-id-create-policy.arn
}


#####################################################################################################################################
#                                                     IAM Role
#####################################################################################################################################

#IAM Role for Lambda to with permission to get objects from S3, process it with Lambda function, create faceprints using Rekognition service and store faceprints in DynamoDb table

resource "aws_iam_role" "rekognition-faceprints" {
  name = "rekognition-faceprints"
  description = "IAM Role for Lambda to with permission to get objects from S3, process it with Lambda function, create faceprints using Rekognition service and store faceprints in DynamoDb table"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}  
EOF
}

#####################################################################################################################################
#                                                     IAM Policy
#####################################################################################################################################

#IAM Policy with permission to get objects from S3, process it with Lambda function, create faceprints using Rekognition service and store faceprints in DynamoDb table

resource "aws_iam_policy" "rekognition-faceprints-policy" {
  name = "rekognition-faceprints-policy"
  description = "IAM Policy with permission to get objects from S3, process it with Lambda function, create faceprints using Rekognition service and store faceprints in DynamoDb table"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CloudWatchLogGroup",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
        ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Sid": "S3Bucket",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:HeadObject"
            ],
            "Resource": "arn:aws:s3:::individuals-source-image/*"

        },
        {
            "Sid": "DynamoDB",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem"
            ],
            "Resource": "arn:aws:dynamodb:*:*:table/faceprints-table"
        },
        {
            "Sid": "RekognitionCollectionID",
            "Effect": "Allow",
            "Action": [
                "rekognition:IndexFaces"
            ],
            "Resource": "arn:aws:rekognition:*:*:collection/*"
        }
    ]
}  
EOF
}


#####################################################################################################################################
#                                                     IAM Role Policy Attachment
#####################################################################################################################################

#Attaching IAM Role and Policy

resource "aws_iam_role_policy_attachment" "faceprints-role-policy" {
  role = aws_iam_role.rekognition-faceprints.id
  policy_arn = aws_iam_policy.rekognition-faceprints-policy.arn
}