#Provide Variable
variable "region" {
  default        = "us-east-2"
  description = "AWS Region"
}

#VPC Naming
variable "Tenacity-vpc" {
  default        = "Tenancy"
  description = "Name for VPC"
}


variable "region_name" {  
  default     ="eu-West-2"
  description = "name of the region"

}
#Vpc cidr_block
variable "vpc-cider" {  
  default     ="10.0.0.0/16"
  description = "name of the vpc cider"
  
}

#Variable for public subnet1
variable "Prod-pub-sub1" {
  default     = "10.0.1.0/24"
  description = "This is the Public Subnet 1 CIDR Block"
}

#Variable for public subnet2
variable "Prod-pub-sub2" {
  default     = "10.0.2.0/24"
  description = "This is the Public Subnet 2 CIDR Block"
}


#Variable for private subnet 1
variable "Prod-priv-sub1" {
  default     = "10.0.3.0/24"
  description = "This is the private Subnet 1 CIDR Block"
}


#Variable for private subnet 
variable "Prod-priv-sub2" {
  default     = "10.0.4.0/24"
  description = "This is the private Subnet 2 CIDR Block"
}
