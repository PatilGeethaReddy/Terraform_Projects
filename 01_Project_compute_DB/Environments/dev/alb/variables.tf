variable "tg-config" {
  type = map(object({
    target_type = string
    tg-name = string
    protocol_version = string
    port = number
    protocol = string
    health_check = map(string)
    stickiness = bool
    stickiness_type = string
  }))
}
variable "zone_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "sg-id" {
  type = string
}
variable "subnets" {
    type = list
}
variable "wl-op" {
  type = object({
    counts = number,
    ec2-name = string
  })
  
}
variable "wl-Admin" {
  type = object({
    counts = number,
    ec2-name = string
  })
  
}
variable "wl-Client" {
  type = object({
    counts = number,
    ec2-name = string
  }) 
}
variable "wl-RE" {
  type = object({
    counts = number,
    ec2-name = string
  }) 
}
variable "wl-PM" {
  type = object({
    counts = number,
    ec2-name = string
  }) 
}
variable "alb_name" {
  type = string
}
variable "alb_internal" {
  type = bool
}
variable "ip_address_type" {
  type = string
}
variable "load_balancer_type" {
  type = string
}
variable "record_name" {
  type = string
}
variable "record_type" {
  type = string
}
variable "record_ttl" {
  type = number
}















































/*
variable "target-group-name" {
  type = list
}
variable "port" {
  type = list
}

variable "path" {
  type = list
}

*/







/*
variable "tg-config" {
  type = map(object({
    tg-name = string
    port = number
    protocol = string
    health_check = map(string)
  }))

}
*/