variable "prefix" {
  description = "The name prefix for the created resources"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list
}

variable "common_tags" {
  description = "The common map of tags"
  type        = map
  default     = {}
}

variable "create_igw" {
  description = "Enable Internet Gateway for public subnets"
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateways for each of your private network"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Single shared NAT Gateway across all of your private networks"
  type        = bool
  default     = false
}

variable "one_nat_gateway_per_az" {
  description = "Enable only one NAT Gateway per availability zone"
  type        = bool
  default     = false
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_ecr_api_endpoint" {
  description = "Provision an ECR API endpoint to the VPC"
  type        = bool
  default     = false
}

variable "enable_ecr_dkr_endpoint" {
  description = "Provision an ECR DKR endpoint to the VPC"
  type        = bool
  default     = false
}

variable "enable_s3_endpoint" {
  description = "Provision an S3 endpoint to the VPC"
  type        = bool
  default     = false
}
