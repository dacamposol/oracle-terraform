terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.96.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.13.0"
    }

    k8s = {
      source  = "banzaicloud/k8s"
      version = ">= 0.8.0"
    }
  }
}

# == Provider ==

provider "oci" {
  region       = var.region
  tenancy_ocid = var.tenancy_ocid

  user_ocid        = var.user_ocid
  private_key_path = var.user_rsa_path
  fingerprint      = var.user_rsa_fingerprint
}

provider "kubernetes" {
  config_path = "${path.module}/generated/kubeconfig"
}

provider "k8s" {
  config_path = "${path.module}/generated/kubeconfig"
}

# == Compartment ==

resource "oci_identity_compartment" "k8s" {
  compartment_id = var.tenancy_ocid
  description    = "Compartment for Free Tier K8s Cluster"
  name           = "OracleManagedKubernetesCompartment"
}
