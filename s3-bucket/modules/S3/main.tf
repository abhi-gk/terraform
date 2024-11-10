# CREATION OF S3 BUCKET - GENERAL PURPOSE
resource "aws_s3_bucket" "s3" {
  count         = var.create ? 1 : 0
  bucket        = var.bucket_name
  force_destroy = var.force_destroy

  tags = {
    Name = "${var.tagName}-${var.bucket_name}",
    ENV  = var.EnvName
  }

}

#S3 VERSIONING
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3[0].id

  versioning_configuration {
    status = var.versioningStatus
  }
}

#S3 BUCKET OWNERSHIP CONTROL - ACL DISABLE or ENABLE (AWS RECOMMENDED TO DISABLE [OBJECT OWNER ENFORCED]
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.s3[0].id
  rule {
    object_ownership = var.BucketOwnerType
  }
}

#S3 BLOCK OR UNBLOCK PUBLIC ACCESS - MANAGE PERMISSIONS USING ACL OR BUCKET POLICY
resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3[0].id

  block_public_acls       = var.block_public_acls       # ACL DEFAULT FALSE
  block_public_policy     = var.block_public_policy     # BUCKET POLICY DEFAULT FALSE
  ignore_public_acls      = var.ignore_public_acls      # IGNORE ACL DEFAULT FALSE
  restrict_public_buckets = var.restrict_public_buckets #RESTRICT PUBLIC ACCESS for BUCKET POLICY DEFAULT FALSE
}

#S3 ACL CONTROL
/*resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.s3[0].id
  acl    = var.acl
}*/


#S3 - BUCKET KEY
/*resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}*/

#S3 - BUCKET ENCRYPTION
/*resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.s3[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.mykey.arn
      sse_algorithm     = "aws:kms"
    }
  }
}*/


#S3 - BUCKET OBJECT LOCK
/*resource "aws_s3_bucket_object_lock_configuration" "example" {
  bucket              = aws_s3_bucket.s3[0].id
  object_lock_enabled = var.object_lock_enabled

}*/



# S3 - LIFECYCLE CONFIGURATION TO MOVE CURRENT VERSION AND NON-CURRENT VERSION TO GLACIER STORAGE CLASS AFTER 30 DAYS.
resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.s3[0].id

  dynamic "rule" {
    for_each = var.lifecycle_rule

    content {
      id     = rule.value["id"]
      status = rule.value["enabled"]
      #prefix  = rule.value["prefix"]
      expiration {
        days = rule.value["expirationdays"]
      }
      noncurrent_version_transition {
        noncurrent_days = rule.value["noncurrent_days"]
        storage_class   = rule.value["noncurrentstorage_class"]
      }
      transition {
        days          = rule.value["transitiondays"]
        storage_class = rule.value["transitionstorage_class"]
      }
    }
  }
}



resource "aws_s3_bucket_policy" "allow_public_access" {
  bucket = aws_s3_bucket.s3[0].id
  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicRead",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
        }
    ]
}
	
  
  )
}
