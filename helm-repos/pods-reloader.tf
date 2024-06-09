# https://github.com/stakater/Reloader?tab=readme-ov-file
# This is a helm chart for reloading pods when the existing secrets are edited

resource "helm_release" "reloader" {
  name       = "reloader"
  namespace  = "default"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "1.0.101"
}