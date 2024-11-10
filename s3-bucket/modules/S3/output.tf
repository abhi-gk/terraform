output "s3_bucket_id" {
  description = "This is the s3 bucket id"
  value       = aws_s3_bucket.s3[0].id
}

