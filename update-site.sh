#!/bin/bash
set -e

cd /workspaces/Portfolio

# Sync files
BUCKET=$(cd terraform && terraform output -raw s3_bucket_name)
aws s3 sync site/ "s3://$BUCKET"

# Invalidate only index.html (fast)
DIST_ID=$(cd terraform && terraform output -raw cloudfront_distribution_id)
aws cloudfront create-invalidation --distribution-id "$DIST_ID" --paths "/index.html"

echo "✅ Updated! Changes will appear in 1-2 minutes."
echo "🔗 URL: $(terraform output -raw portfolio_url)"