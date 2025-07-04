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
    # tags = local.common_tags
}