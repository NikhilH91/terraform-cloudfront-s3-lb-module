# Terraform Module for CloudFront, S3, and Load Balancer
 
This module provisions:
- S3 Bucket for static content
- CloudFront distribution
- Load Balancer (ALB or NLB)
 
## Usage
 
```hcl
module "cloudfront_s3_lb" {
  source              = "./path/to/module"
  s3_bucket_name      = "my-app-bucket"
  s3_force_destroy    = true
  lb_name             = "my-load-balancer"
  lb_security_groups  = ["sg-12345"]
  lb_subnets          = ["subnet-12345", "subnet-67890"]
  target_group_port   = 80
  vpc_id              = "vpc-12345"
  price_class         = "PriceClass_100"
  tags                = { Environment = "prod", Application = "my-app" }
}
