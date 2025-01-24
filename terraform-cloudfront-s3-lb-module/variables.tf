variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
 
variable "s3_force_destroy" {
  description = "Force destroy S3 bucket on delete"
  type        = bool
  default     = true
}
 
variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}
 
variable "lb_security_groups" {
  description = "Security groups for Load Balancer"
  type        = list(string)
}
 
variable "lb_subnets" {
  description = "Subnets for Load Balancer"
  type        = list(string)
}
 
variable "lb_deletion_protection" {
  description = "Enable deletion protection for the load balancer"
  type        = bool
  default     = false
}

variable "lb_target_group_name" {
  description = "Name of the Target Group"
  type        = string
}
 
variable "lb_target_port" {
  description = "Port for Target Group"
  type        = number
}
 
variable "vpc_id" {
  description = "VPC ID for Load Balancer"
  type        = string
}
 
variable "health_check_path" {
  description = "Health check path for Load Balancer"
  type        = string
  default     = "/"
}
 
variable "cloudfront_comment" {
  description = "Comment for CloudFront distribution"
  type        = string
}
 
variable "cloudfront_default_root_object" {
  description = "Default root object for CloudFront"
  type        = string
  default     = "index.html"
}
 
variable "tags" {
  description = "tags to apply to resources"
  type = map(string)
  
}