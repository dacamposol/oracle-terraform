# === Cluster ===

## Oracle Kubernetes Engine
module "oke" {
  source = "oracle-terraform-modules/oke/oci"

  compartment_id = oci_identity_compartment.k8s.id

  region              = var.region
  home_region         = var.region
  tenancy_id          = var.tenancy_ocid
  create_operator             = false
  create_bastion_host         = false
  control_plane_type          = "public"
  control_plane_allowed_cidrs = ["0.0.0.0/0"]
  kubernetes_version          = "v1.24.1"
  
  node_pools = {
    np1 = {
      boot_volume_size = 50
      node_pool_size   = 2
      ocpus            = 2
      shape            = "VM.Standard.A1.Flex"
      memory           = 12
    }
  }
  providers = {
    oci.home = oci
  }
}