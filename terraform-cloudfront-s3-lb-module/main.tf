terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

variable "aws_region" {
  default = "us-east-1" # Replace with your desired AWS region
}
resource "aws_s3_bucket" "cloudfront_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = var.s3_force_destroy
 
  tags = merge(var.tags, {
    "Name" = var.s3_bucket_name
  })
}

# Optionally, define a bucket policy for more control
resource "aws_s3_bucket_policy" "cloudfront_policy" {
bucket = aws_s3_bucket.cloudfront_bucket.id
 
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.cloudfront_bucket.arn}/*"
      }
    ]
  })
}
resource "aws_lb" "app_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_security_groups
  subnets            = var.lb_subnets
 
  enable_deletion_protection = var.lb_deletion_protection
 
  tags = var.tags
}
 
resource "aws_lb_target_group" "target_group" {
  name        = var.lb_target_group_name
  port        = var.lb_target_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  health_check {
    enabled             = true
    interval            = 30
    path                = var.health_check_path
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
 
  tags = var.tags
}

resource "aws_cloudfront_distribution" "cdn" {
  origin {
    domain_name = aws_s3_bucket.cloudfront_bucket.bucket_regional_domain_name
    origin_id   = "S3Origin"
 
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }
 
  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.cloudfront_comment
  default_root_object = var.cloudfront_default_root_object
 
  default_cache_behavior {
    target_origin_id       = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"
 
    allowed_methods = ["GET", "HEAD", "OPTIONS"] # Added "OPTIONS" for compatibility
    cached_methods  = ["GET", "HEAD"]
 
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
 
  restrictions {
    geo_restriction {
      restriction_type = "none" # Use "blacklist" or "whitelist" to specify restricted locations
    }
  }
 
  viewer_certificate {
    cloudfront_default_certificate = true # Use a default certificate or specify an ACM certificate
  }
 
  tags = var.tags
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for S3"
}