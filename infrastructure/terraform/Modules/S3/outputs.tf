# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "aws_s3_bucket_site_id" {
  value = aws_s3_bucket.site.id
}

output "aws_s3_bucket_site_arn" {
  value = aws_s3_bucket.site.arn
}

output "aws_s3_bucket_website_domain" {
  value = aws_s3_bucket.site.website_domain
}