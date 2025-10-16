terraform {

  # Comment backend "gcs" At First Time. see Readme
  # clone "02-backend-clone/state" to "04-dev-node/state"
  backend "gcs" {
    bucket = "awesome-bussiness-tf-state"
    prefix = "04-dev-node/state"
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
  environment_name = "dev"

  project_name = "awesome-bussiness"
  billing_id   = "0162C8-66BEB4-31C1E6"
}


module "web-default" {

  source = "../web-module"

  # project name and id
  gcp_project_name = local.project_name
  gcp_project_id   = "${local.project_name}-devops"

  # bucket config
  bucket_prefix = "apple_meets_cherry"
  bucket_name   = "${local.project_name}-tf-state"

  # billing id
  gcp_billing_id = local.billing_id

  # cluster environment
  environment_name   = local.environment_name
  machine_type       = "e2-standard-2"
  initial_node_count = 1

}

