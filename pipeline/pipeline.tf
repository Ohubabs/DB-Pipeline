resource "helm_release" "jenkins" {
  name       = "jenkins"
  create_namespace = true
  namespace = "pipeline"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"

  values = [
    "${file("jenkins-values.yml")}"
  ]
}

resource "kubernetes_storage_class" "jenkins-sc" {
  metadata {
    name = "jenkins-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "Immediate"
  parameters = {
    type = "gp2"
  }
}

#resource "kubernetes_storage_class" "jenkins-agent" {
 # metadata {
  #  name = "jenkins-agent"
  #}
  #storage_provisioner = "ebs.csi.aws.com"
  #volume_binding_mode = "Immediate"
  #parameters = {
  #  type = "gp2"
  #}
#}

#podTemplate {
 #   node(POD_LABEL) {
  #      stage ('Clone Git Repo'){
   #           sh "echo 'Cloning Git Repo'"
    #          git 'https://github.com/Ohubabs/tesla-app.git'
     #         sh "echo 'Build & JUnit Test'"
      #        sh "mvn clean package"
       #       sh "echo 'QualityTesting'"
        #      sh "mvn sonar:sonar"
        #}
#}
#}