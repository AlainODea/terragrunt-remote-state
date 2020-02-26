terraform {
  required_version = ">= 0.12"
}

data "terraform_remote_state" "remote_state" {
  backend = "s3"

  config = {
    region = var.terraform_state_aws_region
    bucket = var.terraform_state_s3_bucket
    key    = "${var.aws_region}/${var.vpc_name}/${var.remote_state_path}"
  }
}
