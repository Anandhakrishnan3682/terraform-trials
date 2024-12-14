terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}
 
# ESRM
 
provider "aws" {
  region = var.aws_region
  # alias = "aws-sp" # adding alias is causing error
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}

provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}


provider "github" {
  alias = "aws-cp"
  token = local.esrm_github_token
  owner = local.esrm_owner
}


locals {
  esrm_owner               = regex("https:\\/\\/github.com\\/(\\w+)\\/([\\w-_]+)(.git$|$)", var.esrm_github_repo_url)[0]
  esrm_github_sm_list      = split(":", var.esrm_secretsmanager_github_token)
  esrm_github_sm_name      = local.esrm_github_sm_list[0]
  esrm_github_sm_key_name  = length(local.esrm_github_sm_list) == 2 ? local.esrm_github_sm_list[1] : null
  esrm_github_sm_key_value = local.esrm_github_sm_key_name != null ? jsondecode(data.aws_secretsmanager_secret_version.esrm_github_token_id.secret_string)[local.esrm_github_sm_key_name] : null
  esrm_github_token        = local.esrm_github_sm_key_value != null ? local.esrm_github_sm_key_value : data.aws_secretsmanager_secret_version.esrm_github_token_id.secret_string
}
 
data "aws_secretsmanager_secret" "esrm_github_token" {
  name = local.esrm_github_sm_name
}
 
data "aws_secretsmanager_secret_version" "esrm_github_token_id" {
  secret_id = data.aws_secretsmanager_secret.esrm_github_token.id
}

/*

# provider "aws" {
#   alias  = "esrm_r53"
#   region = var.esrm_aws_r53_region
#   assume_role {
#     role_arn = "arn:aws:iam::${var.account_num_r53}:role/${var.aws_r53_role}"
#   }
# }


provider "aws" {
  alias  = "esrm_us_east_1"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}

provider "aws" {
  alias  = "us_west_2"
  region = "us-west-2"
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}


terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_num}:role/${var.aws_role}"
  }
}


# outputs
output "message" {
  value = "hello, sudheer !  from terraform cloud - CCOE"
}
*/
