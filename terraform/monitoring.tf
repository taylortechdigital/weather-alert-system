resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "15.4.0" # Set to a stable version or leave blank for latest

  set {
    name  = "server.persistentVolume.enabled"
    value = "false"
  }

  # Optionally, set additional configuration options as needed.
}

resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  version    = "6.56.0" # Set a version or leave blank for latest

  set {
    name  = "persistence.enabled"
    value = "false"
  }

  set {
    name  = "adminPassword"
    value = "your_admin_password"  # Replace with a secure password or reference a secret.
  }

  # Optionally, you can set additional values (data sources, dashboards, etc.)
}
