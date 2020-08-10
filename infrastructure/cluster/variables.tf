variable "name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_pair_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "size" {
  type = number
}

#
# the tags for this module
#
variable "application_tag" {
  type = string
}

variable "contact_tag" {
  type = string
}

variable "managedby_tag" {
  type = string
}

variable "environment_tag" {
  type = string
}