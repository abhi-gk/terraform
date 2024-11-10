locals {
  lifecycle_rules = [
    {
      id = "ExpirationRuleStandardGlacier"

      expirationdays = 90
      #filter = {}
      #prefix = "${var.bucket_name}/*"
      enabled                 = "Enabled"
      noncurrent_days         = 60
      noncurrentstorage_class = "DEEP_ARCHIVE"
      transitiondays          = 30
      transitionstorage_class = "GLACIER"

    }
  ]
}


module "S3" {
  source                  = "../../modules/S3/"
  create                  = true
  bucket_name             = "jrp-wezvatech-2024"
  force_destroy           = true
  tagName                 = "wezvatech-jrp"
  EnvName                 = "DEV"
  versioningStatus        = "Enabled"
  BucketOwnerType         = "BucketOwnerEnforced"
  block_public_acls       = true
  block_public_policy     = false
  ignore_public_acls      = true
  restrict_public_buckets = false
  #  acl = "public-read"
  object_lock_enabled = "Enabled"
  #  s3_bucket_id = module.S3.s3_bucket_id
  lifecycle_rule = local.lifecycle_rules
}



