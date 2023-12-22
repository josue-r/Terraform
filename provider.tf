#create required prioviders: github and aws
terraform {
  required_version = "1.3.7"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "4.45.0"
    }
  }
}
provider "github" {
  token = "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"
  owner = "josue-r"
}

#provider aws
provider "aws" {
#
  region  = "us-east-1"


  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = "JRS"
      Project     = "CI for VVL"
      Provider    = "Terraform"
      Company     = "Tequ.io"
    }
  }

}

terraform {
  backend "s3" {
    bucket         = "josue-tfstate"
    key            = "terraform.tfstate" #checar si esta referencia es correcta
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-jrs-statelock"
    encrypt        = true
  }
}



