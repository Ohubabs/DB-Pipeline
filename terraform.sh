#Terraform installation. Input in aws management console
#After Installation, Remember to install AWS CLI 2. Tried to add installation here but did not work as of 06/09/23
#Recommend creating an ansible playbook to configure terraform with aws cli 2 and kubectl installed. 06/09/23

Terraform + Vault + AWS CLI 2 + KUBECTL + Password Authentication
Remember to set password for terra user after signing in with the public key so that you can copy the ssh key via terminal (MacOS)
---
#!/bin/bash
sudo adduser terra
sudo hostnamectl set-hostname terraform
sudo timedatectl set-timezone America/Los_Angeles
sudo echo "terra ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terra
sudo su - terra
sudo apt update -y
curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.29.0/2024-01-04/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update -y
sudo apt-get install terraform
sudo apt update -y
sudo apt install vault
sudo apt update -y
sudo apt install unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo apt update -y
sudo apt install openjdk-17-jdk -y
sudo chown terra:terra -R /etc/ssh/sshd_config.d
sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
sudo service sshd restart

Terraform + KUBECTL
---
#!/bin/bash
sudo adduser terra
sudo echo "terra ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terra
sudo su - terra
sudo hostnamectl set-hostname terraform
sudo apt update -y
sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
sudo chown terra:terra -R /etc/ssh/sshd_config

Enabling Password Authentication
---


Terraform + AWS CLI 2 + KUBECTL
---
#! /bin/bash
sudo adduser terra
sudo echo "terra ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/terra
sudo su - terra
sudo hostnamectl set-hostname terraform
sudo apt update -y
sudo curl -O https://s3.us-west-2.amazonaws.com/amazon-eks/1.27.1/2023-04-19/bin/linux/amd64/kubectl
sudo chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
sudo chown terra:terra -R /etc/ssh/sshd_config
sudo apt install unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install




