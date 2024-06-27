resource "helm_release" "external-dns" {
  name       = "external-dns"
  create_namespace = true
  namespace = "dns"
  repository = "https://kubernetes-sigs.github.io/external-dns/"
  chart      = "external-dns"

  values = [
    "${file("dns-values.yml")}"
  ]
}

resource "helm_release" "cert-manger" {
  name       = "cert-manager"
  create_namespace = true
  namespace = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name = "installCRDs"
    value = true
  }

  set {
    name = "serviceAccount.annotations.eks\\amazonaws\\.com\\/role-arn"
    value = "arn:aws:iam::083772204804:role/DB-cert-manager"
  }
}

#https://cert-manager.io/docs/configuration/acme/dns01/route53/
#https://cert-manager.io/docs/installation/helm/
#https://artifacthub.io/packages/helm/cert-manager/cert-manager
