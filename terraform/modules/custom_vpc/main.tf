terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

data "aws_availability_zones" "available" {
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc_aws.vpc_id
}

# Use an official module.
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc_aws" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.77.0"

    name = "${var.prefix}-vpc"
    
    azs = [
        data.aws_availability_zones.available.names[0],
        data.aws_availability_zones.available.names[1],
        data.aws_availability_zones.available.names[2]
    ]

    cidr = var.cidr
    private_subnets = var.private_subnets
    public_subnets = var.public_subnets
    database_subnets = var.database_subnets
    
    create_igw = var.create_igw
    enable_nat_gateway = var.enable_nat_gateway
    single_nat_gateway = var.single_nat_gateway
    one_nat_gateway_per_az = var.one_nat_gateway_per_az

    enable_dns_support = var.enable_dns_support
    enable_dns_hostnames = var.enable_dns_hostnames

    # required for ECR to function correctly
    # https://aws.amazon.com/de/blogs/containers/using-vpc-endpoint-policies-to-control-amazon-ecr-access/
    enable_ecr_api_endpoint = var.enable_ecr_api_endpoint
    ecr_api_endpoint_security_group_ids = var.enable_ecr_api_endpoint ? [data.aws_security_group.default.id] : []

    enable_ecr_dkr_endpoint = var.enable_ecr_dkr_endpoint
    ecr_dkr_endpoint_security_group_ids = var.enable_ecr_dkr_endpoint ? [data.aws_security_group.default.id] : []

    enable_s3_endpoint = var.enable_s3_endpoint
    s3_endpoint_security_group_ids = var.enable_s3_endpoint ? [data.aws_security_group.default.id] : []

    tags = merge(var.common_tags, {
        Name = "${var.prefix}-vpc"
    })

    private_subnet_tags = {
        SubnetType = "private"
        "kubernetes.io/role/internal-elb" = "1"
    }
    public_subnet_tags = {
        SubnetType = "public"
        "kubernetes.io/role/elb" = "1"
    }
    database_subnet_tags = {
        SubnetType = "database"
    }
    
    igw_tags = var.common_tags
}

