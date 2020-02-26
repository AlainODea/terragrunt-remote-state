# Load Remote State from same VPC

This Terraform Module allows you to create a TF12 module with the outputs of a <TF12 module. This is useful to support dependency blocks in live configuration.

## How do you use this module?

* See the [root README](/README.md) for instructions on using Terraform modules.
* See [vars.tf](./vars.tf) for all the variables you can set on this module.

## Core concepts

[Terraform: terraform_remote_state](https://www.terraform.io/docs/providers/terraform/d/remote_state.html)

> Retrieves state data from a Terraform backend. This allows you to use the root-level outputs of one or more Terraform configurations as input data for another configuration.
>
> Although this data source uses Terraform's backends, it doesn't have the same limitations as the main backend configuration. You can use any number of remote_state data sources with differently configured backends, and you can use interpolations when configuring them.
