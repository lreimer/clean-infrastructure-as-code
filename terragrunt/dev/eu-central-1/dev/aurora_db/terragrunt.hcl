locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  region_vars      = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  region       = local.region_vars.locals.aws_region
  environment  = local.environment_vars.locals.environment
  component    = local.environment_vars.locals.component
  creator      = local.environment_vars.locals.creator
}

terraform {
  source = "git::git@github.com:lreimer/clean-infrastructure-as-code.git//terraform/modules/aurora_serverless?ref=v1.0.0"
}

include {
  path = find_in_parent_folders()
}

dependency "networking" {
  config_path = "../networking"

  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    vpc_id = "fake-vpc-id"
  }
}

inputs = {
  cluster_name        = "example-aurora-serverless-${local.environment}"
  vpc_id              = dependency.networking.outputs.vpc_id
  database_subnets    = dependency.networking.outputs.database_subnet_ids
  allowed_cidr_blocks = dependency.networking.outputs.private_subnet_ranges
  database_name       = "example"
  
  tags = {
    Environment = local.environment
    Component   = local.component
    Creator     = local.creator
  }
}
