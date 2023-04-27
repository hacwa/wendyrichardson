resource "aws_cloudfront_origin_access_control" "example" {
  name                              = "examplewerwerwerwer"
  description                       = "Example Policy"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              =  "${aws_s3_bucket.www.bucket_domain_name}"
    origin_access_control_id = aws_cloudfront_origin_access_control.example.id
    origin_id                = "${var.www_domain_name}"  
  }
  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress = true
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${var.www_domain_name}"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 3600    
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    #viewer_protocol_policy = "allow-all"
    #min_ttl                = 0
    #default_ttl            = 3600
    #max_ttl                = 86400
  }
  aliases = ["${var.www_domain_name}"]
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.certificate.arn}"
    ssl_support_method  = "sni-only"
  }
}