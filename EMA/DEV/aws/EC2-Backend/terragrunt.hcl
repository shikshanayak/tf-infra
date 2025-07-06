include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../tf-modules/aws/EC2/"
}

dependency "VPC" {
  config_path = "../VPC"
  mock_outputs = {
    private_subnets = "subnet-xyz"
    public_subnets = "subnet-abc"
    vpc_cidr_block = "10.0.0.0/16"
    vpc_id = "vpc-xyz"
  }
}

inputs = {
    instance_ami = "ami-0f918f7e67a3323f0"
    # key_name = "firstVm"
    instance_type = "t2.micro"
    subnet_id = dependency.VPC.outputs.private_subnets[0]
    create_security_group = true
    security_group_description = "Backend Host SG"
    security_group_ingress_rules = {
    VPC_Range = {
      description = "allow all IPs Range"
      ip_protocol = "-1"
      cidr_ipv4 = dependency.VPC.outputs.vpc_cidr_block
    }
    
    }
    security_group_name = "Backend Host SG"
    security_group_vpc_id = dependency.VPC.outputs.vpc_id
}