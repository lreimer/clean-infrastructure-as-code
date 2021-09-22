# Terraform Module for an ECS Fargate Service

A reusable module that performs a the creation of an ECS Fargate cluster and the deployment of a
task for a given microservice image.

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
| vpc_id | The ID of the VPC | `string` |  | yes |
| public_subnets | A list of public subnets inside the VPC | `list` |  | yes |
| common_tags | The common map of tags | `map` | `{}` | no |
| service_name | The ECS service name | `string` |  | yes |
| service_image | The Docker service image to run in the ECS cluster | `string` | | yes |
| service_port | Port exposed by the docker image to redirect traffic to | `number` | `8080` | no |
| service_count | Number of ECS service containers to run | `number` | `3` | no |
| service_cpu | Fargate instance CPU units to provision (1 vCPU = 1024 CPU units) | `string` | `1024` | no |
| service_memory | Fargate instance memory to provision (in MiB) | `string` | `2048` | no |
| service_health_check_path | The health check URL path for the service | `string` | `/health` | no |

## Outputs

| Name | Description |
|------|-------------|
| alb_hostname | The ALB hostname of the service |
