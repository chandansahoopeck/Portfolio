provider "aws" {
  region = "us-east-1"  # Required for ACM (even for default CloudFront cert)
}