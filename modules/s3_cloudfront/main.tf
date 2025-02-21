resource "aws_s3_bucket" "images_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = var.bucket_name
  }
}

resource "aws_cloudfront_distribution" "cf_distribution" {
  origin {
    domain_name = aws_s3_bucket.images_bucket.bucket_regional_domain_name
    origin_id   = "S3-${aws_s3_bucket.images_bucket.id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = ""

  default_cache_behavior {
    target_origin_id       = "S3-${aws_s3_bucket.images_bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = var.bucket_name
  }
}
