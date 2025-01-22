variable "key_name" {
  type = string
}
variable "vpc_id" {
  type = string
} 
variable "hosted_zone" {
  type = string
}
variable "environment" {
  type = string
}
variable "record_type" {
  type = string
}
variable "record_ttl" {
  type = number
}
variable "aws_security_group_name" {
  type = string
}
variable "vpc_cidr" {
  type = list(string)
}
variable "protocol" {
  type = string
}
variable "config" {
  type = map(object({
    subnet_id = list(string)
    application_name = string
    no_of_instances = number
    ami_id = string
    instance_type = string
    device_name = string
    volume_size = string
    volume_type = string  
  }))
}


 


  

