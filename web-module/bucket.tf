
######### bucket module ###########


module "gcs_backend_bucket" {
  source  = "terraform-google-modules/cloud-storage/google//modules/simple_bucket"
  version = "~> 12.0" # Use the latest version


  project_id = var.gcp_project_id
  name       = var.bucket_name
  location   = var.bucket_location

  storage_class = "STANDARD" # Storage class (STANDARD, NEARLINE, COLDLINE, ARCHIVE)

  # Optional: Enable versioning
  versioning = true

  lifecycle_rules = [{
    action = {
      type = "Delete"
    }
    condition = {
      age            = 30
      with_state     = "ANY"
      matches_prefix = var.bucket_prefix # should use bucket_prefix here
    }
  }]

  force_destroy = false # keep it false , to force destroy true 
  depends_on    = [module.project]
}
