variable "allocated_storage" {
  type = number
  default = 10
}

variable "engine" {
  type = string
  default = "mysql"
}

variable "engine_version" {
  type = string
  default = "5.7"
}

variable "instance_class" {
  type = string
  default = "db.t3.micro"
}

variable "name" {
  type = string
  default = "myrds"
}

variable "username" {
  type = string
  default = "admin"
}

variable "parameter_group_name" {
  type = string
  default = "default.mysql5.7"
}

variable "subnet_ids" {
  type = list
}