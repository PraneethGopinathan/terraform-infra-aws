resource "helm_release" "argocd" {
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "3.35.4"

  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  values = [file("${path.module}/values/argocd.yaml")]
}