variable "region" {
  default = "ap-southeast-3"
}

variable "az" {
  type = list(string)
  default = ["ap-southeast-3a", "ap-southeast-3b", "ap-southeast-3c"]
}

variable "cidr_vpc" {
  default = "10.20.0.0/16"
}

variable "cidr_pub_subnet" {
  default = "10.20.0.0/24"
}

variable "cidr_priv_subnet1" {
  default = "10.20.1.0/24"
}

variable "cidr_priv_subnet2" {
  default = "10.20.2.0/24"
}

// YOU CAN FILL THIS WITH PATH OF YOUR AWS CONFIGURATION OR LET IT BLANK AND IT WILL ASKED WHILE YOU EXECUTE APPLY COMMAND
variable "aws_access_key" {
  default = ""
}

variable "aws_secret_key" {
 default = "" 
}

// LIST OF INBOUND RULES FOR SECURITY GROUP, YOU CAN ADD MORE RULES BY COPYING RULES BLOCK
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

// LIST OF ARRAY THAT CONTAIN USERNAME OF IAM
variable "username" {
  type = list(string)
  default = ["bhp-admin","customer-IAM"] 
}
