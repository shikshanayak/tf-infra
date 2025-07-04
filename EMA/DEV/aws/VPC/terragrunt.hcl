include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../tf-modules/aws/VPC/"
}

inputs = {
    vpc_name = "SKILLii-DevOps"
    vpc_cidr = "10.0.0.0/16"
    vpc_azs = ["ap-south-1a", "ap-south-1b"]
    vpc_private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
    vpc_public_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
    create_private_nat_gateway_route = true
    enable_nat_gateway = true
    single_nat_gateway = true
}