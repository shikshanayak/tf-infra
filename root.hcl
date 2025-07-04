locals {
    common_tags = {
        Name = "test"
        owner = "Shiksha"
        Managed_by = "terraform terragrunt"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
provider "aws" {
    region = "ap-south-1"
}
EOF
}

generate "terraform" {
    path = "terraform.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
    required_version = "v1.5.7"
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = ">= 5.0"
        }
}
}
EOF
}

remote_state {
    backend = "s3"
    generate = {
        path = "backend.tf"
        if_exists = "overwrite"
    }
    config = {
        bucket         = "skillii-devops-25b2"
        key            = "${path_relative_to_include()}/terraform.tfstate"
        region         = "ap-south-1"
        encrypt        = true
    }
}