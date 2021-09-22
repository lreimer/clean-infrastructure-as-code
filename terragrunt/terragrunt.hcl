locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Automatically load region-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Automatically load environment-level variables
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

  # Extract the variables we need for easy access
  account_name = local.account_vars.locals.account_name
  account_id   = local.account_vars.locals.aws_account_id
  aws_profile  = local.account_vars.locals.aws_profile

  aws_region   = local.region_vars.locals.aws_region

  component    = local.environment_vars.locals.component
  creator      = local.environment_vars.locals.creator
  environment  = local.environment_vars.locals.environment
}

# Generate an AWS provider block
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.aws_region}"
  profile = "${local.aws_profile}"
}
EOF
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "${local.account_name}-tfstate-${local.aws_region}"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = local.aws_region

    profile        = local.aws_profile
    dynamodb_table = "terraform-locks"

    s3_bucket_tags = {
      Component   = local.component
      Creator     = local.creator
      Environment = local.environment
    }

    dynamodb_table_tags = {
      Component   = local.component
      Creator     = local.creator
      Environment = local.environment
    }

    # this is MUST be true, otherwise bucket is not created correctly
    skip_bucket_root_access = true
    skip_bucket_versioning  = false
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}