include "root" {
    path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../../tf-modules/aws/EC2/"
}



inputs = {
    instance_ami = "ami-0f918f7e67a3323f0"
    key_name = "firstVm"
    instance_type = "t2.micro"
    vpc_security_group_ids = ["sg-02fe0b565c14e76eb"]
    subnet_id = "subnet-0d36e679629ff40f7"
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
    https = {
      description = "https connection"
      ip_protocol = "tcp"
      to_port = 443
      from_port = 443
      cidr_ipv4 = "0.0.0.0/0"
    }
    }
    security_group_name = "Bastion Host SG"
    security_group_vpc_id = "vpc-00bae9765467f4577" 


    # tags = local.common_tags
}