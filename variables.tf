variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    Environment        = "Dev"
    Project            = "pge-esrm-medicalLOB"
    Owner              = "MIBT_AXJL_MOC5"
    Compliance         = "None"
    Notify             = "MIBT@pge.com"
    CRIS               = "Low"
    DataClassification = "Internal"
    AppID              = "APP-3489"
  }
}


variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "esrm_owner" {
  type        = string
  description = "Github Owner"
  default = "pgetech"
}
variable "aws_role" {
  type        = string
  description = "AWS role to assume"
}

variable "esrm_github_repo_url" {
  type        = string
  description = "Github url"
}

variable "esrm_secretsmanager_github_token" {
  type        = string
  description = "Github token"
}

variable "kms_role" {
  description = "AWS role to administer the KMS key."
  type        = string
}

variable "kms_description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console."
}

variable "kms_name" {
  type        = string
  description = "KMS key name for customer managed key encryption"
}

variable "account_num" {
  type        = string
  description = "Target AWS account number, mandatory"
}

#Variables for Tags
variable "optional_tags" {
  description = "optional_tags"
  type        = map(string)
  default     = {}
}

variable "AppID" {
  description = "Identify the application this asset belongs to by its AMPS APP ID.Format = APP-####"
  type        = number
}

variable "Environment" {
  type        = string
  description = "The environment in which the resource is provisioned and used, such as Dev, Test, QA, Prod."
}

variable "DataClassification" {
  type        = string
  description = "Classification of data - can be made conditionally required based on Compliance.One of the following: Public, Internal, Confidential, Restricted, Privileged (only one)"
}

variable "CRIS" {
  type        = string
  description = "Cyber Risk Impact Score High, Medium, Low (only one)"
}

variable "Notify" {
  type        = list(string)
  description = "Who to notify for system failure or maintenance. Should be a group or list of email addresses."
}

variable "Owner" {
  type        = list(string)
  description = "List three owners of the system, as defined by AMPS Director, Client Owner and IT Leader LANID1_LANID2_LANID3"
}

variable "Compliance" {
  type        = list(string)
  description = "Compliance	Identify assets with compliance requirements (SOX, HIPAA, etc.) Note: not adding NERC workloads to cloud"
}

variable "codepipeline_name" {
  description = "The name of the pipeline."
  type        = string
}

variable "github_org" {
  description = "Github organization name of the repository, pgetech, DigitalCatalyst, etc"
  type        = string
}

variable "repo_name" {
  description = "Github repository name of the application to be built"
  type        = string
}

variable "branch" {
  description = "Branch of the GitHub repository, e.g 'master"
  type        = string
}

variable "pollchanges" {
  description = "Checks for any changes in the Github Branch"
  type        = bool
  default = true
}
#####
variable "ssm_parameter_vpc_id" {
  description = "enter the value of vpc id stored in ssm parameter"
  type        = string
}

variable "ssm_parameter_subnet_id1" {
  description = "enter the value of subnet id_1 stored in ssm parameter"
  type        = string
}

variable "ssm_parameter_subnet_id2" {
  description = "enter the value of subnet id_2 stored in ssm parameter"
  type        = string
}

variable "ssm_parameter_subnet_id3" {
  description = "enter the value of subnet id_3 stored in ssm parameter"
  type        = string
}

variable "ssm_parameter_artifactory_repo_name" {
  description = "Enter the artifact repo name of jfrog stored in ssm parameter"
  type        = string
}

variable "ssm_parameter_artifactory_host" {
  description = "Enter the host value of jfrog stored in ssm parameter"
  type        = string
}

variable "secretsmanager_artifactory_token" {
  description = "Enter the token value of jfrog artifactory stored in secrets manager"
  type        = string
}

variable "secretsmanager_artifactory_user" {
  description = "Enter the name of jfrog artifactory user stored in secrets manager"
  type        = string
}

variable "secretsmanager_sonar_token" {
  description = "Enter the token of SonarQube stored in secrets manager"
  type        = string
}

variable "ssm_parameter_sonar_host" {
  description = "Enter the host value of SonarQube stored in ssm parameter"
  type        = string
}

variable "project_name" {
  description = "The display name visible in SonarQube dashboard. Example: My Project"
  type        = string
}

variable "project_root_directory" {
  description = "Enter the project root directory - variable in buildspec yml"
  type        = string
}

variable "project_key" {
  description = "A unique identifier of your project inside SonarQube"
  type        = string
}

variable "dependency_files_location" {
  description = "Enter the dependency file location - environment variable used in buildspec yml"
  type        = string
}

variable "unit_test_commands" {
  description = "Enter the unit test commands for python webapp"
  type        = string
}

variable "github_repo_url" {
  description = "Enter the github repo url for environment variable used in buildspec yml"
  type        = string
}

#######################
variable "bucket_name" {
  description = "Bucket name for codepipeline"
  type        = string
}

#variables for aws_iam_role
variable "codepipeline_role_service" {
  description = "Aws service of the iam role"
  type        = list(string)
}

#variables for security_group_project
variable "cidr_egress_rules" {
  type = list(object({
    from             = number
    to               = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    description      = string
  }))
}

variable "sg_name" {
  description = "name of the security group"
  type        = string
}

variable "sg_description" {
  description = "vpc id for security group"
  type        = string
}

#vairables for codebuild security group
variable "cidr_egress_rules_codebuild" {
  type = list(object({
    from             = number
    to               = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    description      = string
  }))
}

variable "sg_name_codebuild" {
  description = "name of the security group"
  type        = string
}

variable "sg_description_codebuild" {
  description = "vpc id for security group"
  type        = string
}

#Codebuild projects variables
variable "environment_image_codebuild" {
  description = "Docker image to use for codebuild project. Valid values include Docker images provided by codebuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
  type        = string
}

variable "environment_type_codebuild" {
  description = "Type of build environment to use for codebuild project related builds. Valid values: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER. "
  type        = string
}

variable "source_location_codebuild" {
  description = " Location of the source code from git or s3 to build codescan project."
  type        = string
}

variable "concurrent_build_limit_codebuild" {
  description = "Maximum number of concurrent builds for the project in codebuild project"
  type        = number
}

variable "compute_type_codebuild" {
  description = "Information about the compute resources the build project will use in codebuild project"
  type        = string
}

variable "environment_image_codepublish" {
  description = "Docker image to use for this codepublish project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
  type        = string
}

variable "environment_type_codepublish" {
  description = "Type of build environment to use for codepublish project related builds. Valid values: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER. "
  type        = string
}

variable "concurrent_build_limit_codepublish" {
  description = "Maximum number of concurrent builds for the codepublish project"
  type        = number
}

variable "compute_type_codepublish" {
  description = "Information about the compute resources the build project will use in codepublish project"
  type        = string
}

variable "environment_image_codescan" {
  description = "Docker image to use for this codescan project. Valid values include Docker images provided by CodeBuild (e.g aws/codebuild/standard:2.0), Docker Hub images (e.g., hashicorp/terraform:latest), and full Docker repository URIs such as those for ECR (e.g., 137112412989.dkr.ecr.us-west-2.amazonaws.com/amazonlinux:latest)."
  type        = string
}

variable "environment_type_codescan" {
  description = "Type of build environment to use for codescan related builds. Valid values: LINUX_CONTAINER, LINUX_GPU_CONTAINER, WINDOWS_CONTAINER (deprecated), WINDOWS_SERVER_2019_CONTAINER, ARM_CONTAINER. "
  type        = string
}

variable "concurrent_build_limit_codescan" {
  description = "Maximum number of concurrent builds for the codescan project"
  type        = number
}

variable "compute_type_codescan" {
  description = "Information about the compute resources the build project will use in codescan project"
  type        = string
}

variable "artifact_bucket_owner_access" {
  description = "Enter the artifact bucket owner access"
  type        = string
}

variable "artifact_path" {
  description = "Enter the path to store artifact - S3"
  type        = string
}

variable "python_runtime" {
  description = "Enter the project root directory - variable in buildspec yml"
  type        = string
}

#variables for aws_iam_role
variable "codetest_role_name" {
  description = "Name of the iam role for codepublish project"
  type        = string
}

variable "codebuild_role_service" {
  description = "Aws service of the iam role"
  type        = list(string)
}

variable "lambda_function_name" {
  description = "Enter the name of the Lambda Function"
  type        = string
}

variable "lambda_alias_name" {
  description = "Enter the name of the Lambda alias"
  type        = string
}

variable "secretsmanager_github_token_secret_name" {
  description = "secret manager path of the github OAUTH or PAT"
  type        = string
}

variable "include_lib_files" {
  description = "Set it to false if lib files need not to be added"
  type        = bool
  default     = true
}

########################################

#lambda

variable "handler" {
  description = "Function entrypoint in your code"
  type        = string
}

variable "description" {
  description = "Description of what your Lambda Function does"
  type        = string
}

variable "runtime" {
  description = " Identifier of the function's runtime"
  type        = string
}

variable "environment_variables" {
  description = "Map of environment variables that are accessible from the function code during execution"
  type        = map(string)
  default     = null
}

variable "allow_outofband_update" {
  description = "set this to 'true' if to be used with codepipeline, when updates to the code happens outside of terraform"
  type        = bool
  default     = true
}

#variables for security_group
variable "lambda_cidr_ingress_rules" {
  type = list(object({
    from             = number
    to               = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    description      = string
  }))
}

variable "lambda_cidr_egress_rules" {
  type = list(object({
    from             = number
    to               = number
    protocol         = string
    cidr_blocks      = list(string)
    ipv6_cidr_blocks = list(string)
    prefix_list_ids  = list(string)
    description      = string
  }))
}

variable "lambda_sg_name" {
  description = "name of the security group"
  type        = string
}

variable "lambda_sg_description" {
  description = "vpc id for security group"
  type        = string
}

#variables for aws_lambda_iam_role
variable "lambda_iam_name" {
  description = "Name of the iam role"
  type        = string
}

variable "lambda_iam_aws_service" {
  description = "Aws service of the iam role"
  type        = list(string)
}

variable "lambda_iam_policy_arns" {
  description = "Policy arn for the iam role"
  type        = list(string)
}

variable "sonar_scanner_cli_version" {
  description = "The version of sonar-scanner CLI binary to download. Default is the latest version."
  type        = string
  default     = "5.0.1.3006"
}
