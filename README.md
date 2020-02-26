# terragrunt-remote-state
Utilities for sharing &lt;TF12 remote state via dependency blocks with TF12 modules

## USAGE

Load a legacy (<TF12) module's remote state.

infrastructure-live/dev/ca-central-1/_global/kms-master-key-state/terragrunt.hcl:
```hcl
# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:AlainODea/terragrunt-remote-state.git//modules/remote-state-same-region?ref=v0.0.2"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

inputs = {
  remote_state_path = "_global/kms-master-key/terraform.tfstate"
}
```

Use the remote state copy in a TF12 dependency block in another module.

infrastructure-live/dev/ca-central-1/dev/data-stores/sqs-worker/terragrunt.hcl:
```hcl
# ------------------------------------------------------------------------------
# ENVIRONMENT VARIABLES
# Define these secrets as environment variables
# ------------------------------------------------------------------------------

# AWS_ACCESS_KEY_ID
# AWS_SECRET_ACCESS_KEY

# ------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# This is the configuration for Terragrunt, a thin wrapper for Terraform that supports locking and enforces best
# practices: https://github.com/gruntwork-io/terragrunt
# ------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::git@github.com:AlainODea/infrastructure-modules.git//data-stores/sqs?ref=v0.0.123"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "kms_master_key" {
  config_path = "../../../_global/kms-master-key-state"
}

inputs = {
  name = "worker"

  visibility_timeout_seconds = 60
  message_retention_seconds = 86400
  max_message_size = 131072
  delay_seconds = 10
  receive_wait_time_seconds = 20
  dead_letter_queue = true

  kms_master_key_id = dependency.kms_master_key.outputs.key_id
}
```
