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
sudo apt install unzip
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
sudo apt update -y
sudo apt install openjdk-17-jdk -y
sudo chown terra:terra -R /etc/ssh/sshd_config.d
sudo sed -i 's/no/yes/' /etc/ssh/sshd_config.d/*.conf
sudo service sshd restart

#Old setup for password authentication
#sudo chown terra:terra -R /etc/ssh/sshd_config
#sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config
