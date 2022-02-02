variable "region" {
  default = "ap-southeast-3"
}

variable "az" {
  type = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}

variable "vpc_cidr" {
  default = "10.20.22.0/25"
}

variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
 default = "" 
}

variable "ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0" #Variables not allowed in this func, we can use whitelisted IP Addrs
          ipv6_cidr_block = "::/0"
          description = "Allow SSH"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          ipv6_cidr_block = "::/0"
          description = "Allow HTTP"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_block  = "0.0.0.0/0"
          ipv6_cidr_block = "::/0"
          description = "Allow HTTPS"
        }
    ]
}

variable "username" {
  type = list(string)
  default = ["bhp-admin","customer-IAM"] 
}
