terraform {
  source = "git::git@github.com:neuralnetes/infra-modules.git//github/user-ssh-keys?ref=master"
}

include {
  path = find_in_parent_folders()
}

dependency "random_string" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/global/shared/random/random-string"
}

inputs = {
  user_ssh_keys = [
    {
      title = "terraform-${dependency.random_string.outputs.result}"
    }
  ]
}
