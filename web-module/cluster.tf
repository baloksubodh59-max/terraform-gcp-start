
locals {

  environment_name = var.environment_name
  project_id       = var.gcp_project_id

  allowed_environment_types = ["dev", "staging", "production"]

  master_cidr_blocks = {
    "production" = "172.16.1.0/28"
    "staging"    = "172.16.2.0/28"
    "dev"        = "172.16.3.0/28"
  }

}

module "gke_cluster" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
  version = "~> 40.0.0"


  count = contains(local.allowed_environment_types, local.environment_name) ? 1 : 0


  project_id = local.project_id
  name       = "${local.project_id}-${local.environment_name}-cluster"
  regional   = false
  region     = var.gcp_region
  zones      = [var.gcp_zone]

  network    = "shared-${var.gcp_project_id}-network" #module.vpc.network_name
  subnetwork = "${local.environment_name}-subnet"

  ip_range_pods     = "${local.environment_name}-pods"
  ip_range_services = "${local.environment_name}-services"

  enable_private_nodes    = true
  enable_private_endpoint = false # # Disable private endpoint and add my ip to connect through gcloud.
  master_ipv4_cidr_block  = lookup(local.master_cidr_blocks, local.environment_name, "172.16.0.0/28")

  gateway_api_channel = "CHANNEL_STANDARD"
  configure_ip_masq   = false


  node_pools = [
    {
      name               = "${local.environment_name}-pool"
      machine_type       = var.machine_type       # Could use smaller instances for staging
      initial_node_count = var.initial_node_count # Fewer nodes for staging,dev
    }
  ]

  remove_default_node_pool = true
  deletion_protection      = false # must be "true" to protect from deletion of this cluster

  depends_on = [
    module.vpc,
    module.cloud_nat
  ]
}

