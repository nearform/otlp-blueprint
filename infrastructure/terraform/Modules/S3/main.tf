# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

/*===========================
      AWS S3 resources
============================*/

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

/*===========================
      AWS S3 resources for webhosting
============================*/
resource "random_pet" "bucket" {
  length = 1
}

locals {
  bucket_name = "${random_pet.bucket.id}-demo-client"
}

resource "aws_s3_bucket" "site" {
  bucket        = local.bucket_name
  force_destroy = true
}

resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id
  acl    = "public-read"
}


resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.site.arn,
          "${aws_s3_bucket.site.arn}/*",
        ]
      },
    ]
  })
}