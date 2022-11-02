variable region {
  description = "Value of the 'Region' of the OCI instance"
  type = string
  default = "eu-frankfurt-1"
}

variable tenancy_ocid {
  description = "Value of the root Compartment OCID"
  type = string
  sensitive = true
}

variable user_ocid {
  description = "Value of the User OCID"
  type = string
  sensitive = true
}

variable user_rsa_path {
  description = "Value of the path to the RSA Private Key"
  type = string
  sensitive = true
}

variable user_rsa_fingerprint {
  description = "Value of the fingerprint of the RSA Public Key"
  type = string
  sensitive = true
}

variable argo_cd_version {
  description = "Value of the ArgoCD version to be deployed"
  type = string
  default = "2.5.0"
}

variable argo_cd_namespace {
  description = "Value of the Kubernetes namespace where to deploy ArgoCD resources"
  type = string
  default = "argocd"
}

variable argo_cd_gitops_repo {
  description = "Value of the repository where all the different applications are defined"
  type = string
  default = "https://github.com/dacamposol/oracle-infra"
}

variable argo_cd_gitops_infra_app {
  description = "Value of the path where is the App of Apps which sets the infrastructure"
  type = string
  default = "apps-infra"
}

