variable "ports" {
  type    = map(number)
  default = {
    http  = 80
    https = 443
  }
}

variable "vpc_id"{
  type = any
}