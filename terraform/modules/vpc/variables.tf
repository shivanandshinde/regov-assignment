variable "cidr" {
  type    = string
  default = "172.18.0.0/16"
}

variable "subnet_ids" {
  type = list
  default =  ["172.18.0.0/24", "172.18.1.0/24", "172.18.2.0/24"] 
}

variable "tags" {
  type = map(string)
}