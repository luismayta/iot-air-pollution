terraform {
  # source = "git::git@github.com:foo/modules.git//frontend-app?ref=v0.0.3"
  extra_arguments "retry_lock" {
    commands  = get_terraform_commands_that_need_locking()
    arguments = [
      "-lock-timeout=40m"
    ]
  }
}

remote_state {
  backend = "s3"
  config = {
    bucket         = "luismayta-terraform-iot-air-pollution-terraform-state-us-east-1"
    encrypt        = true
    # Configure Terragrunt to automatically store tfstate files in an S3 bucket
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "luismayta-terraform-iot-air-pollution-us-east-1"

    s3_bucket_tags = {
      owner = "terragrunt terraform-iot-air-pollution prod"
      name = "Terraform state storage"
    }

    #   # dynamodb_table_tags is an attribute, so an equals sign is REQUIRED
    dynamodb_table_tags = {
      owner = "terragrunt terraform-iot-air-pollution prod"
      name = "Terraform lock table"
    }
  }
}