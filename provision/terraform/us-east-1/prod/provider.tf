#
# Terraform required version
#
provider "aws" {
  region  = var.aws_region
  version = ">=1.26.0"
  alias   = "main"
}

# AWS Region for Cloudfront (ACM certs only supports us-east-1)
provider "aws" {
  version = ">=1.26.0"
  region  = "us-east-1"
  alias   = "cloudfront"
}

provider "template" {
  version = ">=1.0.0"
}

provider "null" {
  version = ">=0.1.0"
}
