terraform {
  source = "github.com/neuralnetes/monorepo.git//terraform/modules/google/compute-addresses?ref=main"
}

include {
  path = find_in_parent_folders()
}

dependency "project_iam_bindings" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/global/iam/google/project-iam-bindings"
}

dependency "network_project" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/global/network/google/project"
}

dependency "vpc" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/global/network/google/vpc"
}

dependency "subnetworks" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/us-central1/network/google/subnetworks"
}

dependency "random_string" {
  config_path = "${get_parent_terragrunt_dir()}/non-prod/global/terraform/random/random-string"
}

locals {
  region = "us-central1"
}

inputs = {
  regional_addresses = [
    {
      project      = dependency.network_project.outputs.project_id
      name         = "istio-ingressgateway-us-central1-${dependency.vpc.outputs.network["name"]}"
      purpose      = null
      address_type = "INTERNAL"
      subnetwork   = dependency.vpc.outputs.subnetworks.subnets["cluster-${dependency.random_string.outputs.result}"]
      region       = "us-central1"
    }
  ]
  global_addresses = [
    {
      project       = dependency.network_project.outputs.project_id
      name          = "google-managed-services-global-${dependency.vpc.outputs.network["name"]}"
      prefix_length = 16
      purpose       = "VPC_PEERING"
      address_type  = "INTERNAL"
      network       = dependency.vpc.outputs.network["id"]
    }
  ]
}