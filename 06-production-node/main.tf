terraform {

  # Comment backend "gcs" At First Time. see Readme
  # uncomment after creating bucket 
  backend "gcs" {
    bucket = "gke-bolod-devops-cherry-tf-state"
    prefix = "06-production-node/state"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.6.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 7.6.0"
    }
  }
}


locals {
  environment_name = "production"

  project_name = "awesome-bussiness"
  billing_id   = "0162C8-66BEB4-31C1E6"
}


module "web-default" {

  source = "../web-module"

  # project name and id
  gcp_project_name = local.project_name
  gcp_project_id   = "${local.project_name}-devops"

  # bucket config
  bucket_prefix = "apple_meets_cherry" # should not be project id 
  bucket_name   = "${local.project_name}-tf-state"

  # billing id
  gcp_billing_id = local.billing_id

  # cluster environment, comment to remove cluster 
  # environment_name   = local.environment_name
  # machine_type       = "e2-standard-2"
  # initial_node_count = 1

}

