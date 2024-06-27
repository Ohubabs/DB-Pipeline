resource "kubernetes_secret_v1" "aws-auth" {
  metadata {
    name = "goku"
    namespace = "cert-manager"
  }

  data = {
    kamehameha = var.kamehameha
    spiritbomb = var.spiritbomb
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "graf-auth" {
  metadata {
    name = "vegeta"
    namespace = "monitor"
  }

  data = {
    garlickgun = var.garlickgun
    finalflash = var.finalflash
  }

  type = "Opaque"
}

/*resource "kubernetes_secret_v1" "elastic-auth" {
  metadata {
    name = "food-1"
    namespace = "apm"
  }

  data = {
    username = var.konoha
    password = var.burger
  }

  type = "Opaque"
}*/

resource "kubernetes_secret_v1" "piccolo" {
  metadata {
    name = "piccolo"
    namespace = "pipeline"
  }

  data = {
    specialbeamcanon = var.specialbeamcanon #jenkins-admin-user
    masenko = var.masenko
  }

  type = "Opaque"
}
