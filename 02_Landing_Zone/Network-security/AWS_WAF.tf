resource "aws_wafv2_web_acl" "LZ-WAF" {
  name  = var.aws_wafv2_web_acl
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  tags = {
    Name = var.aws_wafv2_web_acl
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = var.web_acl_metrics
    sampled_requests_enabled   = true
  }
}