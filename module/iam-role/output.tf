output "create-rekognition-collection-id-iam-role" {
  value = aws_iam_role.rekognition-collection-id-role.arn
}

output "rekognition-faceprints-role" {
  value = aws_iam_role.rekognition-faceprints.arn
}

output "face-rekognition-ec2-instance-profile" {
  value = aws_iam_instance_profile.face-rekognition-instance-profile.name
}