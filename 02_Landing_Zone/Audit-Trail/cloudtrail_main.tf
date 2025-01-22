data "aws_caller_identity" "current" {}
resource "aws_s3_bucket" "LZ-bucket" {
bucket        = var.aws_cloudtrail_s3_bucket_name
force_destroy = true
}
resource "aws_cloudtrail" "LZ-trail" {
name                          = var.aws_cloudtrail_name
s3_bucket_name                = aws_s3_bucket.LZ-bucket.id
s3_key_prefix                 = "prefix"
include_global_service_events = false
tags = {
  Name = var.aws_cloudtrail_name
}
}
resource "aws_s3_bucket_policy" "LZ-sample" {
bucket = aws_s3_bucket.LZ-bucket.id
policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "AWSCloudTrailAclCheck",
"Effect": "Allow",
"Principal": {
"Service": "cloudtrail.amazonaws.com"
},
"Action": "s3:GetBucketAcl",
"Resource": "arn:aws:s3:::${var.aws_cloudtrail_s3_bucket_name}"
},
{
"Sid": "AWSCloudTrailWrite",
"Effect": "Allow",
"Principal": {
"Service": "cloudtrail.amazonaws.com"
},
"Action": "s3:PutObject",
"Resource": "arn:aws:s3:::${var.aws_cloudtrail_s3_bucket_name}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
"Condition": {
"StringEquals": {
"s3:x-amz-acl": "bucket-owner-full-control"
}
}
}
]
}
EOF
}