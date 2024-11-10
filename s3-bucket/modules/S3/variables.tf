variable "bucket_name" {
  type    = string
  default = ""
}

variable "create" {
  description = "Whether to create this resource or not?"
  type        = bool
  default     = true
}

variable "versioningStatus" {
  type    = string
  default = "Enabled"
}


variable "tagName" {
  type    = string
  default = "Wezvatech-PROJECT-DEV"
}

variable "EnvName" {
  type    = string
  default = "DEV"
}

variable "BucketOwnerType" {
  type    = string
  default = "BucketOwnerPreferred"
}

variable "block_public_acls" {
  type    = bool
  default = false
}

variable "block_public_policy" {
  type    = bool
  default = false
}


variable "ignore_public_acls" {
  type    = bool
  default = false
}

variable "restrict_public_buckets" {
  type    = bool
  default = false
}

variable "acl" {
  type    = string
  default = "public-read"
}

variable "object_lock_enabled" {
  type    = string
  default = "Disabled"
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "lifecycle_rule" {
  description = "LIFECYCLE RULES FOR THE BUCKET"
  type        = list(map(string))
  default     = []
}
