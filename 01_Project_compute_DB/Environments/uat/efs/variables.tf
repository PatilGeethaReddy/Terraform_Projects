variable "subnet_ids" {
  type = list
}
variable "vpc_id" {
  type = string
}
variable "efs-file-name" {
  type = string
}
variable "performance_mode" {
  type = string
}
variable "throughput_mode" {
  type = string
}
variable "encrypted" {
  type = bool
}
variable "transition_to_ia" {
  type = string
}
variable "backup_policy_status" {
  type = string
}
variable "aws_security_group_name" {
  type = string
}
variable "vpc_cidr" {
  type = list(string)
}
variable "port" {
  type = number
}
variable "protocol" {
  type = string
}

