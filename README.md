#DragonBall Project

## Background

This is the first portion of a 7-part project series to launch the following stateless applications below in an EKS cluster with Fargate Nodes using a CI/CD pipeline setup in Jenkins named DB:

1)	A simple static website/webpage running on an NGINX web server
2)	A 3 tier Login SpringBoot Java Application connected to a MongoDB NoSQL database.

In addition, you will provision an EC2 instance using terraform that will have Docker installed then connected to Jenkins as a Worker Node and deploy SonarQube in the DB cluster to perform code quality testing on the Springboot application. Finally, you will launch monitoring tools Prometheus and Grafana to track the performance of all active applications in the DB cluster 

## Project 1 Scenario
For this project, perform the following tasks:

1)	Setup an EKS Cluster named “DB” 
2)	Deploy a Jenkins application into the cluster 
3)	Configure the Jenkins application with persistent storage 
4)	Create a custom url for your Jenkins application that’ll be registered to AWS via External DNS connected to Route 53
5)	Encrypt your site using Cert-Manager and Let’s Encrypt
6)	Expose your application securely to the internet with SSL encryption using a NGINX ingress behind an Application LoadBalancer.
7)	Login to Jenkins from a browser and install necessary plugins such as SSH server, Publish Over SSH, Pipeline Stage View, Docker, etc… 
8)	Edit the Jenkins system to be monitored by Prometheus and add tools such as Maven for your project.
9)	Add credentials for your Worker Node Server
10)	Add your host server, with Terraform, Kubernetes, and Java, installed to your Jenkins server as a worker node to remotely run tasks on it.  

## Prerequisites

-	Visual Studio Code
-	Knowledge on Kubernetes, Terraform, Helm Charts, AWS, CI/CD pipelines and Visual Studion Code/IDEs

Note:- If you do not have the applications & CLIs above installed, run the shell script “db.sh” after setting up your EC2 instance.

## Setup Jenkins in EKS Cluster

### Step 1: Create a Non-root user with Sudo privileges and install: AWS CLI v2, Terraform, Kubectl, and Java by running the shell script. 

	      sh db.sh

Afterwards switch into the new user and clone this repository


### Step 2:  Deploy DB EKS Cluster and VPC with necessary permissions via IAM Service accounts to configure pods with access to EBS storage, VPC networking, and Application LoadBalancer Network Trafficking to expose deployed applications to the internet. Note:- It will take 10 – 20 mins for your cluster to be deployed.

-	Enter the eks/ directory
-	Execute the following commands:
	
        terraform init

 	![Screenshot 2024-10-02 at 12 23 04 PM](https://github.com/user-attachments/assets/a61a652f-2f59-4ed6-93e3-5edc7b5fe54b)

 	![Screenshot 2024-10-02 at 12 23 17 PM](https://github.com/user-attachments/assets/182039ad-d2c2-4fcb-856c-a4a6c7a83d98)
 	
        terraform validate

![Screenshot 2024-10-02 at 12 23 38 PM](https://github.com/user-attachments/assets/14b582f2-eb60-44e3-bedf-6c481c64de21)

 	      terraform plan
 	
 ![Screenshot 2024-10-02 at 12 24 45 PM](https://github.com/user-attachments/assets/cdc51066-f576-44a2-87d5-c79c3a014388)

        terraform apply --auto-approve

![Screenshot 2024-10-02 at 12 27 12 PM](https://github.com/user-attachments/assets/c58802e0-fe31-4baa-8923-be6138c669cb)

![Screenshot 2024-10-02 at 12 44 22 PM](https://github.com/user-attachments/assets/d537ea85-027c-4060-953c-b61d4d8e1ee8)



### Step 3: Update Kubeconfig after cluster deployment by executing the aws commad:

        aws eks update-kubeconfig --name <name-of-cluster> --region <region-of-cluster-deployment

![Screenshot 2024-10-02 at 12 45 05 PM](https://github.com/user-attachments/assets/ea675193-a872-417f-b95f-6d96a67198c5)

Check that your cluster is created by checking your EC2 managed nodes

        kubectl get nodes

![Screenshot 2024-10-02 at 12 47 10 PM](https://github.com/user-attachments/assets/173e966d-dee3-4347-b228-20c8b203947d)



### Step 4: Setup Namespaces within DB Cluster.

-	Enter the namespace/ directory
-	Execute the following commands:

        terraform init

 	![Screenshot 2024-10-02 at 12 51 04 PM](https://github.com/user-attachments/assets/3e58e967-8507-4bd3-ae35-f438ba65b18a)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 12 51 17 PM](https://github.com/user-attachments/assets/91e5e784-dfb1-45b4-b468-3930cc43119b)
  
  ![Screenshot 2024-10-02 at 12 51 22 PM](https://github.com/user-attachments/assets/c06b9b79-c803-4f16-a703-e76f701a7860)


### Step 5: Setup Secrets within DB Cluster.

-	Enter the Kamehouse / directory
-	Execute the following commands:

        terraform init
 	![Screenshot 2024-10-02 at 12 55 11 PM](https://github.com/user-attachments/assets/42bd8487-10bf-49c5-a7b5-d320ecf4d3dc)

        terraform plan

 	![Screenshot 2024-10-02 at 12 55 27 PM](https://github.com/user-attachments/assets/747c5738-4173-4b42-abe1-6e1f8ea3b04e)

 	![Screenshot 2024-10-02 at 12 55 34 PM](https://github.com/user-attachments/assets/58b97de8-a192-4389-a9bf-5ce3bc7648b3)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 12 55 53 PM](https://github.com/user-attachments/assets/9ccbb46b-20b1-4bc5-bc2a-7391f2b72d5a)

### Step 6: Deploy the External DNS helm chart for the application to handle setting up apps within the DB Cluster with domain names/url for easy access on the internet and the Cert-Manager Helm Chart to use the cert-manager application to issue and manage Lets Encrypt certificates.

-	Enter the cert-dns/ directory
-	Execute the following commands:

        terraform init
 	![Screenshot 2024-10-02 at 1 05 40 PM](https://github.com/user-attachments/assets/aee0f1ef-58a6-428c-b359-86b6d04ce56e)

        terraform plan
 	
 	![Screenshot 2024-10-02 at 1 06 11 PM](https://github.com/user-attachments/assets/b32fa6f4-d643-458e-91f9-792b01f137d4)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 1 07 20 PM](https://github.com/user-attachments/assets/f262633e-def9-424d-9570-ab3269c15b1b)

  ![Screenshot 2024-10-02 at 1 07 23 PM](https://github.com/user-attachments/assets/554f0a31-1551-4b88-97d0-868474b52203)

##### Step 7: Issue Let’s Encrypt Certificates using Cert-Manager to securely expose our apps to the internet as websites with SSL encryption.

-	Enter the cert-issuer/ directory
-	Execute the following commands:

        Kubectl apply -f pipeline-issuer.yml

  ![Screenshot 2024-10-02 at 1 11 57 PM](https://github.com/user-attachments/assets/0daf6bfc-02f1-4987-bc70-6a37a7457bbe)

### Step 8: Deploy the Application LoadBalancer Helm Chart to handle the traffic in and out to applications running within the DB Cluster:

-	Enter the alb/ directory
-	Execute the following commands:

        terraform init

 	![Screenshot 2024-10-02 at 1 00 35 PM](https://github.com/user-attachments/assets/6522083b-ef49-4d15-8271-5fa44c80d88e)

        terraform plan

 	![Screenshot 2024-10-02 at 1 01 10 PM](https://github.com/user-attachments/assets/f2d91c41-cd4b-485c-bdeb-40168751c782)

  ![Screenshot 2024-10-02 at 1 01 33 PM](https://github.com/user-attachments/assets/b37ed353-1d49-4901-8cfc-1fbde6ad8943)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 1 01 57 PM](https://github.com/user-attachments/assets/0269d1a6-fe33-402b-ad4b-0785b912aa20)

  ![Screenshot 2024-10-02 at 1 03 18 PM](https://github.com/user-attachments/assets/5267a688-03ac-4213-b9b2-d974d3367d4c)


### Step 9: Deploy the Nginx-Ingress Helm Chart to handle the traffic in and out to applications running in pods within theDB Cluster:

-	Enter the nginx-ingress/ directory
-	Execute the following commands:

        terraform init
        terraform validate
        terraform plan

 	![Screenshot 2024-10-02 at 1 16 40 PM](https://github.com/user-attachments/assets/d4fef4bb-10c8-4be3-9b79-1eec0ef935f6)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 1 18 52 PM](https://github.com/user-attachments/assets/5076a149-3fa9-4509-9e31-09eed467e934)


### Step 10: Deploy the Jenkins Helm Chart to launch the CI/CD automation application:

-	Enter the pipeline/ directory
-	Execute the following commands:

        terraform init

 	![Screenshot 2024-10-02 at 1 23 23 PM](https://github.com/user-attachments/assets/f14f6aac-29f4-4ec5-bc67-2b59d0b16d3a)
 	
        terraform plan

 	![Screenshot 2024-10-02 at 1 24 21 PM](https://github.com/user-attachments/assets/bf0dc480-5ed8-4c1a-bb92-af6581475252)

        terraform apply --auto-approve

  ![Screenshot 2024-10-02 at 2 19 56 PM](https://github.com/user-attachments/assets/af08b427-6b4a-49e2-9d2b-70ab4cca1c4a)


## Configure Jenkins 

### Step 1: Login to Jenkins

![Screenshot 2024-06-24 at 11 34 42 AM](https://github.com/user-attachments/assets/3c7f64e9-15bb-4454-ab33-646fc2e20cd1)

![Screenshot 2024-06-24 at 11 35 03 AM](https://github.com/user-attachments/assets/cb6b7400-aed6-439d-bcc8-428922bcdfc0)

### Step 2: Go to “Manage Jenkins” and select “Plugins”, Update existing plugins, and install necessary plugins such as SSH server, SSH Build Agents, Publish Over SSH, Prometheus, AWS credentials, Maven, SonarQube Scanner, etc…

![Screenshot 2024-06-24 at 11 35 23 AM](https://github.com/user-attachments/assets/01446d08-8fd6-432f-b485-7a826f09f7c2)

![Screenshot 2024-10-02 at 6 07 00 PM](https://github.com/user-attachments/assets/9fd15d73-8ea1-4792-88c8-5fb24336f192)

![Screenshot 2024-10-02 at 6 07 12 PM](https://github.com/user-attachments/assets/ba73dc56-6095-473e-ac46-78ab03ce4aaa)

![Screenshot 2024-10-02 at 6 07 40 PM](https://github.com/user-attachments/assets/3357dc0b-faed-42bb-8601-b8bd64e39665)

![Screenshot 2024-10-02 at 6 07 57 PM](https://github.com/user-attachments/assets/a19ee1ad-eb0f-40e3-8866-715ea5781ae5)

![Screenshot 2024-10-02 at 6 08 14 PM](https://github.com/user-attachments/assets/1c00b275-0e72-4cda-a812-ab9d8ec50714)

![Screenshot 2024-06-24 at 11 45 23 AM](https://github.com/user-attachments/assets/c2b387fd-6023-4475-b682-82e553bd7172)

![Screenshot 2024-06-24 at 11 45 55 AM](https://github.com/user-attachments/assets/6c766c82-66a0-4eec-9a55-80354237e3a8)

### Step 3: Go to “Manage Jenkins”, select “System”, Edit the Jenkins URL, and adjust the Prometheus settings as needed.

![Screenshot 2024-06-24 at 11 46 35 AM](https://github.com/user-attachments/assets/68e29fe1-1076-4f80-af05-b54397ff3a10)

![Screenshot 2024-06-24 at 11 46 52 AM](https://github.com/user-attachments/assets/e0d00c80-d7a0-45ce-aa27-ca87411627ec)

### Step 4: Go to “Manage Jenkins”, Select “Tools”, and Install Git, SonarQube, and Maven

![Screenshot 2024-06-24 at 11 47 19 AM](https://github.com/user-attachments/assets/0ee9496c-5422-4fc7-a463-0a742ff8df82)

![Screenshot 2024-06-24 at 11 47 19 AM](https://github.com/user-attachments/assets/1ab8631e-f63a-4951-9c83-3f6822552cb8)

![Screenshot 2024-06-24 at 11 47 51 AM](https://github.com/user-attachments/assets/b1299dc7-6d93-4020-8142-c24bb3451867)


### Step 4: Go to “Manage Jenkins”, Select “Add Credentials”, and setup the SSH login details for your Host server to be set up as a Worker Node, Docker server, DockerHub, and GitHub.

![Screenshot 2024-06-24 at 11 53 18 AM](https://github.com/user-attachments/assets/944d8298-9943-41ab-8158-6918a6629e92)

![Screenshot 2024-06-24 at 11 53 24 AM](https://github.com/user-attachments/assets/18946fa8-4004-4df4-a39c-1f0ef3f8e35c)

![Screenshot 2024-06-24 at 12 07 33 PM](https://github.com/user-attachments/assets/50090c27-04bd-454a-86bd-2c3fae69a6ef)

### Step 5: Go to “Manage Jenkins”, Select “Nodes”, and connect your Jenkins controller to your host server.

![Screenshot 2024-06-25 at 3 59 07 PM](https://github.com/user-attachments/assets/e4a791b8-2414-4e8d-91a8-0b04d2e4e116)

![Screenshot 2024-06-24 at 1 48 55 PM](https://github.com/user-attachments/assets/4c340869-a73a-4ff2-8e28-bdb9ceb72fd8)

![Screenshot 2024-06-24 at 1 49 51 PM](https://github.com/user-attachments/assets/a4f84fb5-9741-43c7-b660-f05001c91ff7)

![Screenshot 2024-06-24 at 1 49 59 PM](https://github.com/user-attachments/assets/b4c0a1af-b1cc-457e-b1da-4d821f48ee74)

![Screenshot 2024-06-24 at 1 50 26 PM](https://github.com/user-attachments/assets/9aae8307-21bd-47d7-8da8-7dbd1dce54f1)


![Screenshot 2024-06-24 at 1 51 50 PM](https://github.com/user-attachments/assets/3bcdffbe-7e19-47fc-bf74-e71f840268b4)

![image](https://github.com/user-attachments/assets/e4e9c3c6-9daa-49af-99a0-a26ff645ebcf)

