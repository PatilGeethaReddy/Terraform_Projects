variable "region" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "subnet-cidr" {
  type = list(string)
}
variable "availability_zone" {
  type = list(string)
}
variable "subnet-names" {
  type = list(string)
}
variable "nat_gw_names" {
  type = list(string)
}
variable "internet_gateway_name" {
  type = string
}
variable "s3_bucket_name" {
  type = string
}
variable "flowlog-name" {
  type = string
}
variable "flowlog-log_destination" {
  type = string
}
variable "flowlog-traffic_type" {
  type = string
}