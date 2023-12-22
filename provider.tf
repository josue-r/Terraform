#create required prioviders: github and aws
terraform {

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

#provider aws
provider "aws" {
  profile = "mangy-admin"
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
    bucket         = "jrs-tfstate"
    key            = "terraform.tfstate" #checar si esta referencia es correcta
    region         = "us-east-1"
    dynamodb_table = "terraform-backend-statelock"
    encrypt        = true
  }
}


provider "github" {
  owner = "josue-r"
}
