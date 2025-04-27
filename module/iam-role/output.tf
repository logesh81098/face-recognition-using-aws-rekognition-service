output "create-rekognition-collection-id-iam-role" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.rekognition-faceprints.arn
}