#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
AWS_REGION=${AWS_REGION:-us-east-1}
PROJECT_NAME=${PROJECT_NAME:-simple-api}
ENVIRONMENT=${ENVIRONMENT:-prod}

echo -e "${YELLOW}Starting deployment of ${PROJECT_NAME}-${ENVIRONMENT}...${NC}"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo -e "${RED}AWS CLI is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo -e "${RED}Terraform is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}Docker is not installed. Please install it first.${NC}"
    exit 1
fi

# Build and push Docker image
echo -e "${YELLOW}Building and pushing Docker image...${NC}"

# Get ECR login
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $(aws sts get-caller-identity --query Account --output text).dkr.ecr.$AWS_REGION.amazonaws.com

# Build and tag image
IMAGE_TAG=$(git rev-parse --short HEAD 2>/dev/null || echo "latest")
ECR_REGISTRY=$(aws sts get-caller-identity --query Account --output text).dkr.ecr.$AWS_REGION.amazonaws.com
ECR_REPOSITORY=$PROJECT_NAME-$ENVIRONMENT

docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG .
docker build -t $ECR_REGISTRY/$ECR_REPOSITORY:latest .

# Push images
docker push $ECR_REGISTRY/$ECR_REPOSITORY:$IMAGE_TAG
docker push $ECR_REGISTRY/$ECR_REPOSITORY:latest

echo -e "${GREEN}Docker image pushed successfully!${NC}"

# Deploy to ECS
echo -e "${YELLOW}Updating ECS service...${NC}"

# Update ECS service to use new image
aws ecs update-service \
    --cluster $PROJECT_NAME-$ENVIRONMENT-cluster \
    --service $PROJECT_NAME-$ENVIRONMENT-service \
    --force-new-deployment \
    --region $AWS_REGION

echo -e "${GREEN}ECS service updated successfully!${NC}"

# Wait for deployment to complete
echo -e "${YELLOW}Waiting for deployment to complete...${NC}"
aws ecs wait services-stable \
    --cluster $PROJECT_NAME-$ENVIRONMENT-cluster \
    --services $PROJECT_NAME-$ENVIRONMENT-service \
    --region $AWS_REGION

echo -e "${GREEN}Deployment completed successfully!${NC}"

# Get ALB URL
ALB_DNS=$(aws elbv2 describe-load-balancers \
    --names $PROJECT_NAME-$ENVIRONMENT-alb \
    --query 'LoadBalancers[0].DNSName' \
    --output text \
    --region $AWS_REGION 2>/dev/null || echo "ALB not found")

if [ "$ALB_DNS" != "ALB not found" ] && [ "$ALB_DNS" != "None" ]; then
    echo -e "${GREEN}Application is available at: http://$ALB_DNS${NC}"
else
    echo -e "${YELLOW}Could not retrieve ALB URL. Check AWS Console for the load balancer URL.${NC}"
fi