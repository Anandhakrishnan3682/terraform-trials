account_num = "138871512076"
aws_region  = "us-west-2"
aws_role    = "ECM_Admin"
esrm_dev_kms_role     = "CloudAdmin"
kms_role = "CloudAdmin"
aws_r53_role = "CloudAdmin"
esrm_owner = "pgetech"

AppID       = "3489" # Identify the application this asset belongs to by its AMPS APP ID.Format = APP-####
Environment = "Dev"  # Dev, Test, QA, Prod (only one)
# If DataClassification is Confidential, Restricted, Restricted-BCSI, Confidential-BSCI, Please follow the steps
# Detailed in the wiki page https://wiki.comp.pge.com/display/CCE/KMS+and+Terraform+Modules
DataClassification = "Internal"                                       # Public, Internal, Confidential, Restricted, Restricted-BCSI, Confidential-BSCI (only one)
CRIS               = "Low"                                            # Cyber Risk Impact Score High, Medium, Low (only one)
Notify             = ["AY18@pge.com"] # Who to notify for system failure or maintenance. Should be a group or list of email addresses.
Owner              = ["AXJL", "MIBT", "SYKF"]                         # List three owners of the system, as defined by AMPS Director, Client Owner and IT Leader
Compliance         = ["None"]                                         # Identify assets with compliance requirements SOX, HIPAA, CCPA or None

optional_tags = {
  Name     = "dev"
  pge_team = "esrm-tf-developers"
}
esrm_github_repo_url = "https://github.com/pgetech/pge-esrm-api.git"
esrm_secretsmanager_github_token = "github_token_ay18:pat"
secretsmanager_github_token = "github_token_ay18:pat"
codepipeline_name = "pge-lambda-api-esrm"

github_org = "pgetech"
repo_name  = "pge-esrm-api"
branch     = "dev_tfc" # "dev"
pollchanges = true

bucket_name                  = "pge-lambda-api-esrm"
artifact_bucket_owner_access = "FULL"
artifact_path                = "dev/"

include_lib_files = false

ssm_parameter_vpc_id                = "/vpc/id"
ssm_parameter_subnet_id1            = "/vpc/privatesubnet1/id"
ssm_parameter_subnet_id2            = "/vpc/privatesubnet2/id"
ssm_parameter_subnet_id3            = "/vpc/privatesubnet3/id"
ssm_parameter_artifactory_host      = "/jfrog/host"
ssm_parameter_artifactory_repo_name = "/jfrog/artifactory/esrm_python_repo" #ccoe-cicd-pypi-virtual # Kofax-filebound-rationalization-esrm-pypi-virtual
ssm_parameter_sonar_host            = "/sonarqube/host"
secretsmanager_artifactory_token    = "jfrog_credentials_p9sz:jfrog_token"
secretsmanager_artifactory_user     = "jfrog_credentials_p9sz:jfrog_user"
secretsmanager_sonar_token          = "sonarqube_credentials_p9sz:sonar_token"

secretsmanager_github_token_secret_name = "github_token_ay18:pat"


# For testing this example, we need to create a Github token.
# and pass the value of token through ssm parameter store.
# provide the name of that parameter in the variable "token"
# warning appears in the console during "terraform apply" is due to using GitHub Version 1 since codesta ARN provided has some functional issues GitHub Version 1 is used.

project_key               = "lambda-python-unit-test"
project_name              = "lambda-python-unit-test"
project_root_directory    = "." # "esrm-api-lambda-dev/"
github_repo_url           = "https://github.com/pgetech/pge-esrm-api"
dependency_files_location = ""
unit_test_commands        = "python -m coverage run -m unittest && python -m coverage report && python -m coverage xml"
python_runtime            = "3.10"
sonar_scanner_cli_version = "5.0.1.3006" // The module has a default value of 5.0.1.3006. Users can override this value if needed.

#Iam_role
codebuild_role_service    = ["codebuild.amazonaws.com"]
codetest_role_name        = "codetest_python_iam_policy"
codepipeline_role_service = ["codepipeline.amazonaws.com"]

#codebuild stage
environment_image_codebuild      = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
environment_type_codebuild       = "LINUX_CONTAINER"
source_location_codebuild        = "https://github.com/pgetech/PGE-ESRM-AWS"
concurrent_build_limit_codebuild = 1
compute_type_codebuild           = "BUILD_GENERAL1_SMALL"
#codescan stage
environment_image_codescan      = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
environment_type_codescan       = "LINUX_CONTAINER"
concurrent_build_limit_codescan = 1
compute_type_codescan           = "BUILD_GENERAL1_SMALL"
#codepublish stage
environment_image_codepublish      = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
environment_type_codepublish       = "LINUX_CONTAINER"
concurrent_build_limit_codepublish = 1
compute_type_codepublish           = "BUILD_GENERAL1_SMALL"

#security_group
sg_name        = "sg_esrm-codebuild"
sg_description = "security group for codebuild project python"
cidr_egress_rules = [{
  from             = 0,
  to               = 0,
  protocol         = "-1",
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = []
  prefix_list_ids  = []
  description      = "ESRM egress rules"
}]
#codebuild - codetest security group
sg_name_codebuild        = "sg_codebuild_codetest_project"
sg_description_codebuild = "security group for codebuild - codetest project python"
cidr_egress_rules_codebuild = [{
  from             = 0,
  to               = 0,
  protocol         = "-1",
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = []
  prefix_list_ids  = []
  description      = "ESRM egress rules"
}]

#kms_key
kms_name        = "codebuild_key_python"
kms_description = "kms key for codebuild python"

#Lambda

lambda_function_name = "lambda-python-dev-esrm"
lambda_alias_name    = "live"
description          = "testing aws lambda"
runtime              = "python3.10"
handler              = "lambda_function.lambda_handler"

#security_group
lambda_sg_name        = "codepipeline_lambda_sg_aicg7"
lambda_sg_description = "Security group for example usage with codepipeline lambda"

lambda_cidr_ingress_rules = [{
  from             = 80,
  to               = 80,
  protocol         = "tcp",
  cidr_blocks      = ["10.90.195.0/25", "10.90.232.0/23"]
  ipv6_cidr_blocks = []
  prefix_list_ids  = []
  description      = "ESRM Ingress rules"
  },
  {
    from             = 443,
    to               = 443,
    protocol         = "tcp",
    cidr_blocks      = ["10.90.195.0/25", "10.90.232.0/23"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    description      = "ESRM Ingress rules"
}]

lambda_cidr_egress_rules = [{
  from             = 0,
  to               = 0,
  protocol         = "-1",
  cidr_blocks      = ["0.0.0.0/0"]
  ipv6_cidr_blocks = []
  prefix_list_ids  = []
  description      = "ESRM egress rules"
}]

#Iam_role 
lambda_iam_name        = "codepipeline_esrm_lambda_policy"
lambda_iam_aws_service = ["lambda.amazonaws.com"]
lambda_iam_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole", "arn:aws:iam::aws:policy/AWSLambda_FullAccess", "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"]
