locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  environment  = local.environment_vars.locals.environment
  component    = local.environment_vars.locals.component
  creator      = local.environment_vars.locals.creator
}

terraform {
  source = "git::git@github.com:lreimer/clean-infrastructure-as-code.git//terraform/modules/fargate_service?ref=v1.0.0"
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
  vpc_id            = dependency.networking.outputs.vpc_id
  public_subnet_ids = dependency.networking.outputs.public_subnet_ids

  service_name  = "jakartaee8-java11"
  service_image = "lreimer/jakartaee8-java11:d412e89362d3ee78e3e70fc29caf4689a84caa36c9652910a301654f8c7472fa"

  common_tags = {
    Environment = local.environment
    Component   = local.component
    Creator     = local.creator
  }
}
