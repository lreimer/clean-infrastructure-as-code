# Terraform Module for a Custom Apps VPC

A reusable module that performs a the creation of a custom VPC for the apps account.
Under the hood, this module wraps and uses the AWS VPC module.

## Development

If you want to make changes to this module, proceed as follows to format and validate the module sources:

```bash
$ terraform init
$ export AWS_DEFAULT_REGION=eu-central-1

$ terraform fmt
$ terraform validate
``` 

If using this module from Terragrunt, here is how to test out changes to a module locally:

1. Update the code as necessary.
2. Go into the folder wehere you have the `terragrunt.hcl` file that uses this module.
3. Run `terragrunt plan --terragrunt-source <LOCAL_PATH>`, where `LOCAL_PATH` is the path to your local checkout of the module code.
4. If the plan looks good, run `terragrunt apply --terragrunt-source <LOCAL_PATH>`.

Using the `--terragrunt-source` parameter (or `TERRAGRUNT_SOURCE` environment variable) allows you to do rapid, iterative, make-a-change-and-rerun development.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws       | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws  | >= 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| prefix | The name prefix for the created resources | `string` |  | yes |
| cidr | The CIDR block for the VPC | `string` |  | yes |
| private_subnets | A list of private subnets inside the VPC | `list` |  | yes |
| public_subnets | A list of public subnets inside the VPC | `list` |  | yes |
| database_subnets | A list of database subnets inside the VPC | `list` |  | yes |
| common_tags | The common map of tags | `map` | `{}` | no |
| create_igw | Enable Internet Gateway for public subnets | `bool` | `true` | no |
| enable_nat_gateway | Enable NAT Gateways for each of your private network | `bool` | `true` | no |
| single_nat_gateway | Single shared NAT Gateway across all of your private networks | `bool` | `false` | no |
| one_nat_gateway_per_az | Enable only one NAT Gateway per availability zone | `bool` | `false` | no |
| enable_dns_support | Enable DNS support in the VPC | `bool` | `true` | no |
| enable_dns_hostnames | Enable DNS hostnames in the VPC | `bool` | `true` | no |
| enable_ecr_api_endpoint | Provision an ECR API endpoint to the VPC | `bool` | `false` | no |
| enable_ecr_dkr_endpoint | Provision an ECR DKR endpoint to the VPC | `bool` | `false` | no |
| enable_s3_endpoint | Provision an S3 endpoint to the VPC | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| availability_zones | The name of the AZs in the current region |
| vpc_id | The ID of the VPC |
| public_subnet_ids | The list of public subnet IDs |
| public_subnet_ranges | The list of public subnet CIDR blocks |
| public_subnet_arns | The list of public subnet ARNs |
| private_subnet_ids | The list of private subnet IDs |
| private_subnet_ranges | The list of private subnet CIDR blocks |
| private_subnet_arns | The list of private subnet ARNs |
| database_subnet_ids | The list of private subnet IDs |
| database_subnet_ranges | The list of private subnet CIDR blocks |
| database_subnet_arms | The list of private subnet ARNs |
| vpc_endpoint_ecr_api_id | The ID of VPC endpoint for ECR API |
| vpc_endpoint_ecr_dkr_id | The ID of VPC endpoint for ECR Docker |
| vpc_endpoint_s3_id | The ID of VPC endpoint for S3 |
