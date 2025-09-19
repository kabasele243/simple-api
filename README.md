# Simple Express API with AWS Infrastructure

A minimal Express.js API with complete AWS infrastructure and CI/CD pipeline.

## 🏗️ Infrastructure

- **AWS ECS Fargate** - Containerized application hosting
- **Application Load Balancer** - Traffic distribution and health checks
- **ECR** - Docker image registry
- **VPC** - Isolated network environment
- **Auto Scaling** - Automatic scaling based on CPU utilization
- **CloudWatch** - Logging and monitoring

## 🚀 Deployment via GitHub Actions

### Prerequisites

1. AWS Account with appropriate permissions
2. GitHub repository with this code
3. AWS CLI configured locally (for initial setup)

### Setup Steps

#### 1. Create S3 Bucket for Terraform State
```bash
aws s3 mb s3://simple-api-terraform-state --region us-east-1
aws s3api put-bucket-versioning --bucket simple-api-terraform-state --versioning-configuration Status=Enabled
```

#### 2. Configure GitHub Repository Variables
Add this variable to your GitHub repository (Settings > Secrets and variables > Actions > Variables):
- `AWS_ROLE_ARN` - The role ARN from Terraform output (after step 3)

#### 3. Initial Infrastructure Deployment
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values (especially github_repository)
terraform init
terraform plan
terraform apply
```

**After applying Terraform:**
1. Note the `github_actions_role_arn` output
2. Add this ARN as `AWS_ROLE_ARN` variable in your GitHub repository

#### 4. Push to GitHub
```bash
git add .
git commit -m "Initial commit with infrastructure"
git push origin main
```

### 🔄 CI/CD Pipeline

The GitHub Actions workflow automatically:

1. **On Pull Requests:**
   - Runs tests
   - Shows Terraform plan
   - Validates infrastructure changes

2. **On Main Branch Push:**
   - Runs tests
   - Builds Docker image
   - Pushes to ECR
   - Deploys to ECS
   - Updates service with zero downtime

### 📁 Project Structure

```
simple-api/
├── terraform/                 # Infrastructure as Code
│   ├── modules/
│   │   ├── vpc/              # Network infrastructure
│   │   ├── ecr/              # Container registry
│   │   └── ecs/              # Container orchestration
│   ├── main.tf               # Main Terraform configuration
│   ├── variables.tf          # Input variables
│   └── outputs.tf            # Output values
├── .github/workflows/        # CI/CD pipeline
│   └── deploy.yml           # GitHub Actions workflow
├── scripts/                  # Deployment scripts
│   └── deploy.sh            # Manual deployment script
├── index.js                  # Express application
├── index.test.js            # Test suite
├── Dockerfile               # Container configuration
└── docker-compose.yml       # Local development
```

### 🧪 Local Development

```bash
# Install dependencies
npm install

# Run tests
npm test

# Start development server
npm run dev

# Run with Docker
docker-compose up
```

### 🔧 Environment Variables

Required in production:
- `NODE_ENV=production`
- `PORT=3000`

### 📊 Monitoring

- CloudWatch logs: `/ecs/simple-api-prod`
- ECS service metrics available in AWS Console
- Auto scaling triggers at 70% CPU utilization

### 🔄 Rollback

To rollback a deployment:
1. Go to ECS Console
2. Select the cluster and service
3. Update service with previous task definition revision

### 🛠️ Manual Deployment (Alternative)

If you prefer manual deployment over GitHub Actions:
```bash
./scripts/deploy.sh
```

### 🌐 Access Your Application

After deployment, find your application URL:
```bash
aws elbv2 describe-load-balancers --names simple-api-prod-alb --query 'LoadBalancers[0].DNSName' --output text
```

## API Endpoints

- `GET /` - Welcome message
- `GET /api/users` - List all users
- `GET /api/users/:id` - Get user by ID
- `POST /api/users` - Create new user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user