# ### Sample cluster creation , needs vpc setup

# data "google_client_config" "default" {}

# module "gke_cluster" {
#   source  = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster"
#   version = "~> 40.0.0"

#   project_id = "" #var.gcp_project_id
#   name       = "" #var.cluster_name
#   regional   = false
#   region     = "" #var.gcp_region
#   zones      = "" #[var.gcp_zone]
#   network    = module.vpc.network_name
#   subnetwork = module.vpc.subnets_names[0]

#   ip_range_pods     = "subnet-01-pods"
#   ip_range_services = "subnet-01-services"

#   enable_private_nodes    = true
#   enable_private_endpoint = true
#   master_ipv4_cidr_block  = "10.3.0.0/28" # Choose an unused /28 block from your VPC

#   gateway_api_channel = "CHANNEL_STANDARD" # Enables the Gateway API
#   node_pools = [
#     {
#       name               = "default-node-pool"
#       machine_type       = "e2-standard-2"
#       initial_node_count = 2
#     }
#   ]

#   deletion_protection = false

#   depends_on = [module.vpc]
# }

