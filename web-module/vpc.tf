# # Single shared VPC for both environments
module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 12.0.0"


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
      subnet_name           = "dev-subnet"
      subnet_ip             = "10.0.32.0/20"
      subnet_region         = var.gcp_region
      subnet_private_access = "false" # Whether this subnet will have private Google access enabled
      # subnet_flow_logs          = "true"
      # subnet_flow_logs_interval = "INTERVAL_10_MIN"
      # subnet_flow_logs_sampling = 0.7
      # subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
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


module "cloud_router" {
  source  = "terraform-google-modules/cloud-router/google"
  version = "~> 7.3.0"

  name    = "nat-router"
  project = var.gcp_project_id
  region  = var.gcp_region
  network = module.vpc.network_name # or "shared-awesome-bussiness-devops-network" if created separately

  depends_on = [module.vpc]

}

module "cloud_nat" {
  source  = "terraform-google-modules/cloud-nat/google"
  version = "~> 5.4.0"

  name                               = "nat-config"
  project_id                         = var.gcp_project_id
  region                             = "us-central1"
  router                             = module.cloud_router.router.name
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  depends_on = [module.cloud_router]
}
