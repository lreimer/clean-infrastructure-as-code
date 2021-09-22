# Terraform Module for Amazon Aurora with PostgreSQL compatibility (Serverless)

A module to create a Serverless Amazon Aurora DB with PostgreSQL compatibility. Under the hood it
uses the official AWS `rds_aurora` module found [here](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora).

## Development

If you want to make changes to this module, proceed as follows to format and validate the module sources:

```bash
$ terraform init
$ export AWS_DEFAULT_REGION=eu-central-1

$ terraform fmt
$ terraform validate
``` 

## Usage

```
module "aurora_serverless" {
    source = git::git@github.com:lreimer/clean-infrastructure-as-code.git//terraform/modules/aurora_serverless?ref=v1.0.0
    
    cluster_name        = "example-aurora-db"
    vpc_id              = "vpc-12345678"
    database_subnets    = ["subnet-12345678", "subnet-87654321"]
    allowed_cidr_blocks = ["10.20.0.0/20"]

    tags = {
        Creator = "Terraform"
        Environment = "Dev"
        Component = "CLOUD"
    }
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.0 |
| aws       | >= 3.0    |

## Providers

| Name | Version |
|------|---------|
| aws  | >= 3.0  |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster_name | Name for Aurora DB cluster | `string` |  | yes |
| vpc_id | ID of the VPC to use | `string` |  | yes |
| database_subnets | A list of database subnets to use | `list(string)` |  | yes |
| allowed_cidr_blocks | A list of allowed CIDR ranges allowed to access the database (e.g. the private subnet ranges) | `list(string)` |  | yes |
| database_name | Name of the initial database | `string` | `""` | no |
| username | Name of the master user | `string` | `postgres` | no |
| port | The database port | `number` | `5432` | no |
| min_capacity | The minimum ACU" | `number` | `2` | no |
| max_capacity | The maximum ACU | `number` | `4` | no |
| monitoring_interval | The monitoring interval in seconds | `number` | `60` | no |
| backup_retention_period | The backup retention period in days | `number` | `7` | no |
| preferred_backup_window | The preferred backup window time slot | `string` | `02:00-03:00` | no |
| preferred_maintenance_window | The preferred time slot for DB maintenance | `string` | `sun:05:00-sun:06:00` | no |
| deletion_protection | If the DB instance should be deletion protection enabled | `bool` | `false` | no |
| tags | Tags to set on the Aurora DB cluster and associated resources | `map(string)` | `{}` | no |


## Outputs

| Name | Description |
|------|-------------|
| cluster_id | The ID of the cluster |
| cluster_arn | The ARN of the cluster |
| cluster_endpoint | The cluster endpoint |
| cluster_port | The cluster port |
| cluster_instance_ids | A list of all cluster instance ids |
| cluster_instance_endpoints | A list of all cluster instance endpoints |
| cluster_hosted_zone_id | Route53 hosted zone id of the created cluster |
| cluster_database_name | Name for an automatically created database on cluster creation |
| cluster_master_username | The master username |
| cluster_master_password | The master password |


The master username and password are marked as `sensitive`, they will not be output on the console.
To retrieve these values, issue the following command: `terragrunt state pull | jq '.outputs[].value'`
