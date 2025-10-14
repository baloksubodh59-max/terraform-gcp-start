
########### project module ###########

# CREATING MODULE
# A new project is created with the official "project-factory" module.
module "project" {
  source  = "terraform-google-modules/project-factory/google"
  version = "~> 18.1.0"

  name       = var.gcp_project_name
  project_id = var.gcp_project_id

  billing_account = var.gcp_billing_id

  activate_apis = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "secretmanager.googleapis.com",
    "servicemanagement.googleapis.com",
    "serviceusage.googleapis.com",
    "storage.googleapis.com",
    "dns.googleapis.com",
  ]
  default_service_account    = "deprivilege"
  disable_dependent_services = false     # keep it false, to force destroy "true"
  deletion_policy            = "PREVENT" # keep default as PREVENT, to force destroy "DELETE"

}

