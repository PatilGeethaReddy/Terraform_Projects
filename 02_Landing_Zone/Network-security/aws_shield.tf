resource "aws_shield_protection_group" "LZ-shield-group" {
  protection_group_id = "LZ-pg-id"
  aggregation         = "MAX"
  pattern             = "ALL"
}



