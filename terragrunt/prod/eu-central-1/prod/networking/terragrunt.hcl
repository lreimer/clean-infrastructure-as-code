locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  environment  = local.environment_vars.locals.environment
  component    = local.environment_vars.locals.component
  creator      = local.environment_vars.locals.creator
}

terraform {
  source = "git::git@github.com:lreimer/clean-infrastructure-as-code.git//terraform/modules/custom_vpc?ref=v1.0.0"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  prefix          = "example-${local.environment}"
  cidr            = "10.19.0.0/16"
  public_subnets  = ["10.19.1.0/24", "10.19.2.0/24", "10.19.3.0/24"]
  private_subnets = ["10.19.4.0/24", "10.19.5.0/24", "10.19.6.0/24"]
  common_tags = {
    Environment = local.environment
    Component   = local.component
    Creator     = local.creator
  }
}
