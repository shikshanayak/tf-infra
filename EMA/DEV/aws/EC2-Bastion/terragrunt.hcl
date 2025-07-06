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
    subnet_id = dependency.VPC.outputs.public_subnets[0]
    create_security_group = true
    security_group_description = "Bastion Host SG"
    security_group_ingress_rules = {
    ssh = {
      description = "ssh connection"
      ip_protocol = "tcp"
      to_port = 22
      from_port = 22
      cidr_ipv4 = "0.0.0.0/0"
    }
    
    }
    security_group_name = "Bastion Host SG"
    security_group_vpc_id = dependency.VPC.outputs.vpc_id
}

# https = {
    #   description = "https connection"
    #   ip_protocol = "tcp"
    #   to_port = 443
    #   from_port = 443
    #   cidr_ipv4 = "0.0.0.0/0"
    # }
    # 
    #     # vpc_security_group_ids = ["sg-02fe0b565c14e76eb"]
    # 