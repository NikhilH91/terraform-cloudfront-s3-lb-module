s3_bucket_name = "test-s3-nikhil"
lb_name = "test-lb-nikhil"
lb_target_group_name = "test-tg-nikhil"
lb_target_port = "443"
lb_security_groups = [ "sg-0262b21a6d1ad3d3f" ]
lb_subnets = [ "10.0.0.0/20" , "10.0.16.0/20" ]
vpc_id = "vpc-0836fa9afd58bc588"
tags = {
  "cloudfront" = "testing"
}