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