variable "banjiVpcCidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "myPubSubnetCidr" {
  type = string
  default = "10.0.1.0/24"
}

variable "myPriSubnetCidr" {
  type = list(string)
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "Az" {
  type = string
  default = "us-east-1a"
}

variable "instance-type" {
  default = ["t2.micro", "t2.nano", "t2.large"]
}

variable "ami_id" {
  default = {
    Linux = "ami-033b95fb8079dc481"
    Redhat = "ami-0b0af3577fe5e3532"
  }
  
}

