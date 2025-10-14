# # Single shared VPC for both environments
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 12.0.0"

  count = 0

  project_id   = var.gcp_project_id
  network_name = "shared-${var.gcp_project_id}-network" # Fixed name, not cluster-specific
  subnets = [
    {
      subnet_name   = "production-subnet"
      subnet_ip     = "10.0.0.0/20"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "staging-subnet"
      subnet_ip     = "10.0.16.0/20"
      subnet_region = var.gcp_region
    },
    {
      subnet_name   = "dev-subnet"
      subnet_ip     = "10.0.32.0/20"
      subnet_region = var.gcp_region
    }
  ]
  secondary_ranges = {
    "production-subnet" = [
      {
        range_name    = "production-pods"
        ip_cidr_range = "10.1.0.0/16"
      },
      {
        range_name    = "production-services"
        ip_cidr_range = "10.2.0.0/20"
      }
    ]
    "staging-subnet" = [
      {
        range_name    = "staging-pods"
        ip_cidr_range = "10.3.0.0/16"
      },
      {
        range_name    = "staging-services"
        ip_cidr_range = "10.4.0.0/20"
      }
    ]
    "dev-subnet" = [
      {
        range_name    = "dev-pods"
        ip_cidr_range = "10.5.0.0/16"
      },
      {
        range_name    = "dev-services"
        ip_cidr_range = "10.6.0.0/20"
      }
    ]
  }
  depends_on = [module.project]
}
