# === ArgoCD ===

## Namespace

resource "kubernetes_namespace" "argo" {
  metadata {
    name = var.argo_cd_namespace
  }

  depends_on = [
    module.oke
  ]
}

## Resources

data "http" "install" {
  url = "https://raw.githubusercontent.com/argoproj/argo-cd/v${var.argo_cd_version}/manifests/install.yaml"
}

locals {
  manifests = split("\n---\n", data.http.install.response_body)
}

resource "k8s_manifest" "argo" {
  count = length(local.manifests)

  content = local.manifests[count.index]
  namespace = var.argo_cd_namespace
  depends_on = [
    kubernetes_namespace.argo
  ]
}
