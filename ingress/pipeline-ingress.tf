resource "kubernetes_ingress_v1" "pipeline" {
  wait_for_load_balancer = true
  metadata {
    name = "pipeline"
    namespace = "pipeline"
    annotations = {
        "cert-manager.io/cluster-issuer" = "pipeline-issuer"
  }
  }
  spec {
    ingress_class_name = "nginx"
    tls {
      secret_name = "devops-secret"
      hosts = ["pipeline.domain-name" 
    }
    rule {
      host = "pipeline.domain-name"  
      http {
        path {
          path = "/"
          backend {
            service {
              name = "jenkins"
              port {
                number = 443
              }
            }
          }
        }
      }
    }
  }
}
