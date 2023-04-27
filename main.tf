resource "aws_acm_certificate" "certificate" {
  provider                  = aws.acm_provider
  domain_name               = var.root_domain_name
  subject_alternative_names = ["www.${var.root_domain_name}"]
  validation_method         = "EMAIL"
#  tags = var.common_tags

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_acm_certificate_validation" "cert_validation" {
  provider        = aws.acm_provider
  certificate_arn = aws_acm_certificate.certificate.arn
}