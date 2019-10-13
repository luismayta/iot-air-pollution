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
