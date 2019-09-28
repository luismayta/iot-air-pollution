include {
  path = "${find_in_parent_folders()}"
}

terraform {
  extra_arguments "retry_lock" {
    # Using a function within first-class expressions!
    commands  = get_terraform_commands_that_need_locking()
    arguments = ["-lock-timeout=40m"]
  }
}

inputs = {
  # This now works with Terragrunt 0.19.x and newer!
  foo = get_env("FOO", "default")
}
