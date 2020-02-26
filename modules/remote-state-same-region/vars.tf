# ---------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# These variables are expected to be passed in by the operator when calling this terraform module.
# ---------------------------------------------------------------------------------------------------------------------

variable "remote_state_path" {
  description = "The path to the source module's remote state within the same VPC. This path does not need to include the region or VPC name. Example: data-stores/elasticsearch/terraform.tfstate."
  type        = string
}

variable "aws_region" {
  description = "The AWS region in which all resources will be created"
  type        = string
}

variable "terraform_state_aws_region" {
  description = "The AWS region of the S3 bucket used to store Terraform remote state"
  type        = string
}

variable "terraform_state_s3_bucket" {
  description = "The name of the S3 bucket used to store Terraform remote state"
  type        = string
}
