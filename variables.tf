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
