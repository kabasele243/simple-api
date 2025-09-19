# AWS Configuration
aws_region = "us-east-1"

# Project Configuration
project_name = "simple-api"
environment  = "prod"

# Network Configuration
vpc_cidr        = "10.0.0.0/16"
public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]

# Container Configuration
container_port   = 3000
container_cpu    = 256
container_memory = 512

# Auto Scaling Configuration
desired_count = 2
min_capacity  = 1
max_capacity  = 4

# Health Check
health_check_path = "/"

# GitHub Configuration
github_repository = "your-username/simple-api"