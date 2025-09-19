# 🚀 Simple Express API with AWS Infrastructure

A production-ready Express.js REST API with complete AWS cloud infrastructure, containerization, and CI/CD pipeline. This project demonstrates modern DevOps practices including Infrastructure as Code, Docker containerization, and automated deployments.

## 📋 Table of Contents

- [🎯 Project Overview](#-project-overview)
- [🏗️ Architecture](#️-architecture)
- [🚀 Features](#-features)
- [📁 Project Structure](#-project-structure)
- [🛠️ Prerequisites](#️-prerequisites)
- [⚡ Quick Start](#-quick-start)
- [🔧 Local Development](#-local-development)
- [☁️ AWS Infrastructure](#️-aws-infrastructure)
- [🔄 CI/CD Pipeline](#-cicd-pipeline)
- [📊 Monitoring & Logging](#-monitoring--logging)
- [🔒 Security Features](#-security-features)
- [📡 API Documentation](#-api-documentation)
- [🧪 Testing](#-testing)
- [🚨 Troubleshooting](#-troubleshooting)
- [🤝 Contributing](#-contributing)

## 🎯 Project Overview

This is a minimal but complete REST API built with Express.js and deployed on AWS using modern cloud-native practices. The application serves a simple user management API and demonstrates:

- **Containerized application** with Docker
- **Infrastructure as Code** with Terraform
- **Serverless containers** with AWS ECS Fargate
- **Load balancing** with Application Load Balancer
- **Auto-scaling** based on CPU utilization
- **Zero-downtime deployments** with GitHub Actions
- **Security best practices** with IAM roles and OIDC

**🌐 Live Application:** http://simple-api-prod-alb-1175136082.us-east-1.elb.amazonaws.com/

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   GitHub Repo   │    │   GitHub Actions │    │   AWS Account   │
│                 │───▶│                  │───▶│                 │
│ - Source Code   │    │ - Build & Test   │    │ - ECS Fargate   │
│ - Dockerfile    │    │ - Docker Build   │    │ - Load Balancer │
│ - Terraform     │    │ - Deploy to AWS  │    │ - Auto Scaling  │
└─────────────────┘    └──────────────────┘    └─────────────────┘
                                ▲
                                │ OIDC Authentication
                                ▼
                       ┌──────────────────┐
                       │   IAM Role       │
                       │ - ECR Push       │
                       │ - ECS Deploy     │
                       │ - CloudWatch     │
                       └──────────────────┘
```

### AWS Components

- **🏗️ VPC** - Isolated network with public/private subnets
- **🐳 ECS Fargate** - Serverless container orchestration
- **⚖️ Application Load Balancer** - Traffic distribution and health checks
- **📦 ECR** - Docker container registry
- **📊 CloudWatch** - Logging and monitoring
- **🔄 Auto Scaling** - Automatic scaling based on metrics
- **🔒 IAM** - Role-based access control with OIDC

## 🚀 Features

### Application Features
- ✅ RESTful API with CRUD operations
- ✅ Express.js with middleware
- ✅ JSON request/response handling
- ✅ Error handling and validation
- ✅ Health check endpoints
- ✅ Comprehensive test suite with Jest and Supertest

### Infrastructure Features
- ✅ Infrastructure as Code with Terraform modules
- ✅ Multi-AZ deployment for high availability
- ✅ Auto-scaling from 1-4 instances
- ✅ Load balancing with health checks
- ✅ Zero-downtime rolling deployments
- ✅ Centralized logging with CloudWatch

### Security Features
- ✅ No hardcoded credentials (OIDC authentication)
- ✅ Least privilege IAM policies
- ✅ VPC with private subnets for containers
- ✅ Security groups with minimal access
- ✅ Container image scanning

### DevOps Features
- ✅ Automated CI/CD with GitHub Actions
- ✅ Docker containerization
- ✅ Terraform state management
- ✅ Automated testing in pipeline
- ✅ Infrastructure validation on PRs

## 📁 Project Structure

```
simple-api/
├── 📄 index.js                    # Main Express application
├── 🧪 index.test.js              # Test suite
├── 🐳 Dockerfile                 # Container configuration
├── 🐙 docker-compose.yml         # Local development
├── 📦 package.json               # Node.js dependencies
├── 📋 README.md                  # This file
├── 🌍 .env.example               # Environment variables template
│
├── 🏗️ terraform/                 # Infrastructure as Code
│   ├── 📄 main.tf                # Main Terraform configuration
│   ├── 📄 variables.tf           # Input variables
│   ├── 📄 outputs.tf             # Output values
│   ├── 📄 terraform.tfvars.example # Configuration template
│   │
│   └── 📁 modules/               # Reusable Terraform modules
│       ├── 🌐 vpc/               # Network infrastructure
│       ├── 📦 ecr/               # Container registry
│       ├── 🐳 ecs/               # Container orchestration
│       └── 🔒 iam/               # IAM roles and policies
│
├── 🔄 .github/workflows/         # CI/CD pipeline
│   └── 📄 deploy.yml             # GitHub Actions workflow
│
└── 📜 scripts/                   # Utility scripts
    └── 🚀 deploy.sh              # Manual deployment script
```

## 🛠️ Prerequisites

### Required Software
- **Node.js** 18+ and npm
- **Docker** and Docker Compose
- **Terraform** 1.5+
- **AWS CLI** configured with appropriate permissions
- **Git** for version control

### AWS Requirements
- AWS Account with programmatic access
- IAM user with permissions to create:
  - VPC, subnets, security groups
  - ECS clusters, services, task definitions
  - ECR repositories
  - Application Load Balancers
  - IAM roles and policies
  - CloudWatch log groups

### GitHub Requirements
- GitHub repository
- Access to repository settings for variables/secrets

## ⚡ Quick Start

### 1. Clone and Setup
```bash
git clone <your-repo-url>
cd simple-api
npm install
```

### 2. Local Development
```bash
# Run tests
npm test

# Start development server
npm run dev

# Or with Docker
docker-compose up
```

### 3. AWS Infrastructure Setup

#### Create S3 bucket for Terraform state:
```bash
aws s3 mb s3://simple-api-terraform-state --region us-east-1
aws s3api put-bucket-versioning --bucket simple-api-terraform-state --versioning-configuration Status=Enabled
```

#### Configure Terraform:
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your values:
```hcl
# Required: Update with your GitHub repository
github_repository = "your-username/simple-api"

# Optional: Customize these values
project_name = "simple-api"
environment  = "prod"
aws_region   = "us-east-1"
```

#### Deploy infrastructure:
```bash
terraform init
terraform plan
terraform apply
```

#### Get the GitHub Actions role ARN:
```bash
terraform output github_actions_role_arn
```

### 4. Configure GitHub

1. Go to your repository → **Settings** → **Secrets and variables** → **Actions** → **Variables**
2. Add variable: `AWS_ROLE_ARN` = `<your-role-arn-from-terraform-output>`

### 5. Deploy Application
```bash
git add .
git commit -m "Initial deployment"
git push origin main
```

The GitHub Actions pipeline will automatically:
1. Run tests
2. Build Docker image
3. Push to ECR
4. Deploy to ECS

### 6. Access Your Application

Find your application URL:
```bash
aws elbv2 describe-load-balancers --names simple-api-prod-alb --query 'LoadBalancers[0].DNSName' --output text
```

## 🔧 Local Development

### Development Commands
```bash
# Install dependencies
npm install

# Run in development mode with hot reload
npm run dev

# Run tests
npm test

# Run tests in watch mode
npm test -- --watch

# Lint code (if configured)
npm run lint
```

### Docker Development
```bash
# Build image
docker build -t simple-api .

# Run container
docker run -p 3000:3000 simple-api

# Or use Docker Compose
docker-compose up
```

### Environment Variables
Create `.env` file for local development:
```bash
cp .env.example .env
```

## ☁️ AWS Infrastructure

### Infrastructure Components

#### VPC and Networking
- **VPC**: 10.0.0.0/16 CIDR block
- **Public Subnets**: 10.0.1.0/24, 10.0.2.0/24 (ALB)
- **Private Subnets**: 10.0.10.0/24, 10.0.11.0/24 (ECS tasks)
- **NAT Gateways**: For outbound internet access from private subnets
- **Internet Gateway**: For public subnet internet access

#### ECS Configuration
- **Launch Type**: Fargate (serverless)
- **CPU**: 256 units (0.25 vCPU)
- **Memory**: 512 MB
- **Desired Count**: 2 tasks
- **Auto Scaling**: 1-4 tasks based on CPU utilization

#### Load Balancer
- **Type**: Application Load Balancer
- **Scheme**: Internet-facing
- **Health Check**: GET / every 30 seconds
- **Target Type**: IP (required for Fargate)

### Cost Optimization

Current configuration costs approximately:
- **ECS Fargate**: ~$15-30/month for 2 tasks
- **ALB**: ~$16/month
- **NAT Gateway**: ~$32/month (biggest cost)
- **Other services**: <$5/month

**Cost Optimization Tips:**
- Use single NAT Gateway for development
- Reduce task count during low usage
- Enable container insights only when needed

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The pipeline runs on:
- **Pull Requests**: Tests + Terraform plan
- **Main Branch Push**: Full deployment

### Pipeline Steps

#### 1. Test Stage
```yaml
- Checkout code
- Setup Node.js 18
- Install dependencies
- Run Jest tests
- Run linting (if configured)
```

#### 2. Build Stage (main branch only)
```yaml
- Configure AWS credentials (OIDC)
- Login to ECR
- Build Docker image
- Tag with commit SHA and 'latest'
- Push to ECR
```

#### 3. Deploy Stage (main branch only)
```yaml
- Download current task definition
- Update with new image URL
- Deploy to ECS
- Wait for deployment completion
```

### Security in CI/CD

- **No AWS credentials stored** in GitHub secrets
- **OIDC authentication** with temporary tokens
- **Least privilege** IAM permissions
- **Scoped to specific repository** and branches

## 📊 Monitoring & Logging

### CloudWatch Logs
- **Log Group**: `/ecs/simple-api-prod`
- **Retention**: 7 days (configurable)
- **Structured logging** from application

### Metrics and Alarms
- **ECS Service CPU/Memory utilization**
- **ALB target health and response times**
- **Auto-scaling triggers** at 70% CPU

### Health Checks
- **ALB Health Check**: GET / every 30 seconds
- **Container Health Check**: curl localhost:3000/
- **ECS Service Health**: Monitored by AWS

### Accessing Logs
```bash
# View recent logs
aws logs tail /ecs/simple-api-prod --follow

# View logs from specific time
aws logs tail /ecs/simple-api-prod --since 1h
```

## 🔒 Security Features

### Authentication & Authorization
- **GitHub OIDC Provider** for secure AWS access
- **IAM roles** with least privilege principle
- **No long-term credentials** stored anywhere

### Network Security
- **VPC isolation** with private subnets for containers
- **Security groups** allowing only necessary traffic
- **ALB** as single entry point with public access

### Container Security
- **Non-root user** in Docker container
- **Minimal base image** (Node.js Alpine)
- **ECR image scanning** for vulnerabilities
- **Regular base image updates**

### Best Practices Implemented
- ✅ No hardcoded secrets
- ✅ Least privilege IAM policies
- ✅ Network segmentation
- ✅ Automated security scanning
- ✅ Infrastructure as Code for consistency

## 📡 API Documentation

### Base URL
```
http://simple-api-prod-alb-1175136082.us-east-1.elb.amazonaws.com
```

### Endpoints

#### Welcome Message
```http
GET /
```
**Response:**
```json
{
  "message": "Welcome to the Simple API"
}
```

#### Get All Users
```http
GET /api/users
```
**Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  {
    "id": 2,
    "name": "Jane Smith",
    "email": "jane@example.com"
  }
]
```

#### Get User by ID
```http
GET /api/users/:id
```
**Response:**
```json
{
  "id": 123,
  "name": "User 123",
  "email": "user123@example.com"
}
```

#### Create User
```http
POST /api/users
Content-Type: application/json

{
  "name": "New User",
  "email": "new@example.com"
}
```
**Response:**
```json
{
  "message": "User created successfully",
  "user": {
    "id": 1640995200000,
    "name": "New User",
    "email": "new@example.com"
  }
}
```

#### Update User
```http
PUT /api/users/:id
Content-Type: application/json

{
  "name": "Updated User",
  "email": "updated@example.com"
}
```

#### Delete User
```http
DELETE /api/users/:id
```

### Example Usage
```bash
# Test the API
curl http://simple-api-prod-alb-1175136082.us-east-1.elb.amazonaws.com/

# Get users
curl http://simple-api-prod-alb-1175136082.us-east-1.elb.amazonaws.com/api/users

# Create user
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}' \
  http://simple-api-prod-alb-1175136082.us-east-1.elb.amazonaws.com/api/users
```

## 🧪 Testing

### Test Suite
The project includes comprehensive tests using **Jest** and **Supertest**:

- ✅ API endpoint testing
- ✅ HTTP status code validation
- ✅ Response body validation
- ✅ Error handling testing
- ✅ Edge case coverage

### Running Tests
```bash
# Run all tests
npm test

# Run tests in watch mode
npm test -- --watch

# Run tests with coverage
npm test -- --coverage
```

### Test Structure
```javascript
describe('API Tests', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      // Test implementation
    });
  });

  describe('POST /api/users', () => {
    it('should create a new user', async () => {
      // Test implementation
    });
  });
});
```

## 🚨 Troubleshooting

### Common Issues

#### 1. GitHub Actions Fails with Permission Error
**Problem:** `AccessDeniedException` when assuming role
**Solution:**
```bash
# Check if role ARN is correct in GitHub variables
terraform output github_actions_role_arn

# Verify GitHub repository name in terraform.tfvars
github_repository = "your-username/simple-api"  # Must match exactly
```

#### 2. ECS Tasks Not Starting
**Problem:** Tasks start then immediately stop
**Solutions:**
```bash
# Check CloudWatch logs
aws logs tail /ecs/simple-api-prod --follow

# Check ECS service events
aws ecs describe-services --cluster simple-api-prod-cluster --services simple-api-prod-service
```

#### 3. Load Balancer Health Check Fails
**Problem:** Targets are unhealthy
**Solutions:**
- Verify application starts on port 3000
- Check security group allows traffic on port 3000
- Ensure health check path returns 200 status

#### 4. Terraform Apply Fails
**Problem:** Resource already exists or permission denied
**Solutions:**
```bash
# Check current state
terraform plan

# Import existing resources if needed
terraform import aws_s3_bucket.terraform_state simple-api-terraform-state

# Check AWS credentials and permissions
aws sts get-caller-identity
```

### Getting Help

1. **Check CloudWatch Logs** for application errors
2. **Review ECS Service Events** for deployment issues
3. **Verify IAM Permissions** for GitHub Actions role
4. **Check Security Groups** for network connectivity
5. **Review Terraform State** for infrastructure issues

### Debug Commands
```bash
# Check ECS service status
aws ecs describe-services --cluster simple-api-prod-cluster --services simple-api-prod-service

# Check ALB target health
aws elbv2 describe-target-health --target-group-arn <target-group-arn>

# View recent CloudWatch logs
aws logs tail /ecs/simple-api-prod --since 30m

# Check ECR repository
aws ecr describe-repositories --repository-names simple-api-prod
```

## 🤝 Contributing

### Development Workflow

1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-feature`
3. **Make** your changes
4. **Add** tests for new functionality
5. **Run** tests: `npm test`
6. **Commit** changes: `git commit -m 'Add amazing feature'`
7. **Push** to branch: `git push origin feature/amazing-feature`
8. **Open** a Pull Request

### Code Standards
- Follow existing code style
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass
- Keep commits atomic and well-described

### Infrastructure Changes
- Test Terraform changes in development environment first
- Update documentation for new AWS resources
- Consider cost implications of infrastructure changes
- Ensure security best practices are maintained

---

## 📄 License

This project is licensed under the ISC License - see the package.json file for details.

## 👨‍💻 Author

Created as a demonstration of modern cloud-native application development with AWS, Docker, and Terraform.

---

**⭐ Star this repository if you find it helpful!**

For questions or support, please open an issue in the GitHub repository.