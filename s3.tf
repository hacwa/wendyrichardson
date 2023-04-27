resource "aws_s3_bucket" "www" {
  bucket = "${var.www_domain_name}"
}
resource "aws_s3_bucket_ownership_controls" "www_controls" {
  bucket = "${var.www_domain_name}"
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_public_access_block" "s3-pa-block" {
  bucket = "${var.www_domain_name}"

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_account_public_access_block" "s3-account-public-access-block" {
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket_acl" "s3bucket_acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.www_controls,
    aws_s3_bucket_public_access_block.s3-pa-block,
  ]
  bucket = "${var.www_domain_name}"
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "s3-bucket-website-config" {
  bucket = "${var.www_domain_name}"
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
  routing_rule {
    condition {
      key_prefix_equals = "docs/"
    }
    redirect {
      replace_key_prefix_with = "documents/"
    }
  }
}