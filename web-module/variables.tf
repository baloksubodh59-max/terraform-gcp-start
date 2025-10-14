variable "gcp_region" {
  description = "GCP REGION"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP ZONE"
  type        = string
  default     = "us-central1-a"
}


variable "gcp_project_name" {
  description = "The ID of the GCP project Name."
  type        = string
}


variable "gcp_project_id" {
  description = "The ID of the GCP project ID."
  type        = string
}

variable "gcp_billing_id" {
  description = "The Billing ID."
  type        = string
}
variable "use_existing_bucket" {
  description = "Set to true to use an existing bucket, false to create a new one."
  type        = bool
  default     = true
}

variable "bucket_prefix" {
  description = "prefix of s3 bucket for app data"
  type        = string
}

variable "bucket_name" {
  description = "The globally unique name for the GCS backend bucket."
  type        = string
}

variable "bucket_location" {
  description = "The location for the GCS bucket."
  type        = string
  default     = "US-CENTRAL1"
}


# cluster specific


variable "environment_name" {
  description = "Deployment environment (dev/staging/production)"
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "The name of the cluster "
  type        = string
  default     = null
}

variable "machine_type" {
  description = "The type of the  machine."
  type        = string
  default     = null
}

variable "initial_node_count" {
  description = "The number of nodes."
  type        = number
  default     = 1
}



