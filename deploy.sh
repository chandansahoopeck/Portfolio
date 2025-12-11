#!/bin/bash
set -e

echo "🚀 Initializing Terraform..."
cd terraform
terraform init

echo "🔍 Planning infrastructure..."
terraform plan

echo "✅ Deploying to AWS..."
terraform apply -auto-approve

echo "📤 Uploading site files..."
BUCKET=$(terraform output -raw s3_bucket_name)
aws s3 sync ../site/ "s3://$BUCKET" 

echo ""
echo "🎉 DONE! Your portfolio is live at:"
terraform output portfolio_url
