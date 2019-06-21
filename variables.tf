variable "aws_region" {
    default = "ap-south-1"
}


variable "base_cidr_block" {
  description = "A /16 CIDR range definition, such as 10.1.0.0/16, that the VPC will use"
  default = "10.1.0.0/16"
}


variable "cluster-name" {
  default = "terraform-eks-demo"
  type    = "string"
}

variable "enable_dns_hostnames" {
  default = "true"
}



variable "key_path" {
  description = "SSH Public Key path"
  default = "/root/terraform.pub"
}

variable "eks-cluster-demo" {
  default = "eks-cluster-demo"
}


