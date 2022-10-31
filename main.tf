terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "4.96.0"
    }
  }
}

# == Provider ==

provider "oci" {
  region = var.region
  tenancy_ocid = var.tenancy_ocid
  
  user_ocid = var.user_ocid
  private_key_path = var.user_rsa_path
  fingerprint = var.user_rsa_fingerprint
}

# == Compartment ==

resource "oci_identity_compartment" "k8s" {
  compartment_id = var.tenancy_ocid
  description = "Compartment for Free Tier K8s Cluster"
  name = "OracleManagedKubernetesCompartment"
}
