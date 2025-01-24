output "s3_bucket_arn" {
  value = aws_s3_bucket.cloudfront_bucket.arn
}
 
output "load_balancer_arn" {
  value = aws_lb.app_lb.arn
}
 
output "cloudfront_distribution_id" {
value = aws_cloudfront_distribution.cdn.id
}
 
output "cloudfront_distribution_domain_name" {
  value = aws_cloudfront_distribution.cdn.domain_name
}