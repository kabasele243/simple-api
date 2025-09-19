# AWS Configuration
aws_region = "us-east-1"

# Project Configuration
project_name = "simple-api"
environment  = "dev"

# Network Configuration (Different from prod)
vpc_cidr        = "10.1.0.0/16"
public_subnets  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnets = ["10.1.10.0/24", "10.1.11.0/24"]

# Container Configuration (Smaller for dev)
container_port   = 3000
container_cpu    = 256
container_memory = 512

# Auto Scaling Configuration (Lower for dev)
desired_count = 1
min_capacity  = 1
max_capacity  = 2

# Health Check
health_check_path = "/"

# GitHub Configuration
github_repository = "your-username/simple-api"