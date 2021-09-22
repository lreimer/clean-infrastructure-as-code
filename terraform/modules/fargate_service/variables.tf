variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "The list of public subnet IDs"
  type        = list(any)
}

variable "common_tags" {
  description = "The common map of tags"
  type        = map(any)
  default     = {}
}

variable "service_name" {
  description = "The ECS service name"
  type        = string
}

variable "service_image" {
  description = "The Docker service image to run in the ECS cluster"
  type        = string
}

variable "service_port" {
  description = "Port exposed by the docker image to redirect traffic to"
  type        = number
  default     = 8080
}

variable "service_count" {
  description = "Number of ECS service containers to run"
  type        = number
  default     = 3
}

variable "service_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = string
  default     = "1024"
}

variable "service_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = string
  default     = "2048"
}

variable "service_health_check_path" {
  description = "The health check URL path for the service"
  type        = string
  default     = "/health"
}
