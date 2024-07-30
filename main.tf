terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.6.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "aws" {
  region = var.region
}

module "myvpc" {
  source = "./modules/vpc"
  vpc_cidr           = "170.11.0.0/20"
  public_sub_1_cidr  = "170.11.1.0/24"
  private_sub_1_cidr = "170.11.0.0/24"
}

module "myec2" {
  source = "./modules/ec2"
  aminame = "al2023-ami-2023.5.*-kernel-6.1-x86_64"
  pub_subnet_id          = module.myvpc.public_subnet_id
  pub_sg_id  = module.myvpc.public_sg_id //from output of vpc submodule we pass this to ec2 submodule as we pass the output of ec2 i.e public IP to connect to console
}

