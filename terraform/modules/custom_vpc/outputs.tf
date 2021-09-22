output "vpc_id" {
  value = module.vpc_aws.vpc_id
}

output "availability_zones" {
  value = module.vpc_aws.azs
}

output "public_subnet_ids" {
  value = module.vpc_aws.public_subnets
}

output "public_subnet_ranges" {
  value = module.vpc_aws.public_subnets_cidr_blocks
}

output "public_subnet_arns" {
  value = module.vpc_aws.public_subnet_arns
}

output "private_subnet_ids" {
  value = module.vpc_aws.private_subnets
}

output "private_subnet_ranges" {
  value = module.vpc_aws.private_subnets_cidr_blocks
}

output "private_subnet_arns" {
  value = module.vpc_aws.private_subnet_arns
}

output "database_subnet_ids" {
  value = module.vpc_aws.database_subnets
}

output "database_subnet_ranges" {
  value = module.vpc_aws.database_subnets_cidr_blocks
}

output "database_subnet_arns" {
  value = module.vpc_aws.database_subnet_arns
}

output "default_security_group_id" {
  value = module.vpc_aws.default_security_group_id
}

output "vpc_endpoint_ecr_api_id" {
  value = module.vpc_aws.vpc_endpoint_ecr_api_id
}

output "vpc_endpoint_ecr_dkr_id" {
  value = module.vpc_aws.vpc_endpoint_ecr_dkr_id
}

output "vpc_endpoint_s3_id" {
  value = module.vpc_aws.vpc_endpoint_s3_id
}
