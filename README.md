# Terraform code to host a wordpress website on S3.
# This will create:
# - An S3 bucket which only allows access to the buckets contents from CloudFront
# - An SSL certificate using Amazon Certificate Manager
# - A Cloudfront distribution 
# 
# Once deployed drop the static files ( created by using the wordpress plugin 'Simply Static' ) into the root of the S3 bucket.
# Change DNS to distribution URL.
#
