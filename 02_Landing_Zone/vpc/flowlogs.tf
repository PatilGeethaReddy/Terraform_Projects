resource "aws_s3_bucket" "flowlog-bucket" {
  bucket = var.s3_bucket_name
  force_destroy = true  
}
resource "aws_flow_log" "LZ-flowlog" {
  log_destination      = aws_s3_bucket.flowlog-bucket.arn
  log_destination_type = var.flowlog-log_destination
  traffic_type         = var.flowlog-traffic_type
  vpc_id               = aws_vpc.landing-zone-vpc.id
  tags = {
    Name = var.flowlog-name
  }
}
