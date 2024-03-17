# 1. Terraform Infrastructure Setup (DEV)
- [1. Terraform Infrastructure Setup (DEV)](#1-terraform-infrastructure-setup-dev)
  - [1.1. Prerequisites](#11-prerequisites)
- [2. Useful Commands](#2-useful-commands)
  - [2.1. First-Time Setup](#21-first-time-setup)
    - [2.1.1. To Create](#211-to-create)
    - [2.1.2. To Destroy](#212-to-destroy)
  - [2.2. Things to do after EKS created](#22-things-to-do-after-eks-created)
  - [2.3. Customization](#23-customization)

>**Note:** This repository contains the Terraform code to create the infrastructure for the following services
> `VPC, Subnets(Private and Public), ECR, S3, EKS`

## 1.1. Prerequisites
Before you can use this Terraform code, you must have the following setup:

- An AWS account
- AWS CLI installed and [configured](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html) with your profile
- Terraform installed on your machine

# 2. Useful Commands
1. Clone this repository to your local machine.
2. Navigate to the cloned directory using the command line.
3. Run `terraform init` to initialize the working directory.
4. Run `terraform plan -var-file=dev-variables.tfvars` to see the changes that Terraform will make.
5. If the plan looks good, run `terraform apply -var-file=dev-variables.tfvars` to create the infrastructure.
6. Once you're done, you can run `terraform destroy -var-file=dev-variables.tfvars` to destroy the infrastructure.

## 2.1. First-Time Setup
Implemented state file management using the Terraform [backend S3](https://developer.hashicorp.com/terraform/language/settings/backends/configuration), as well as a locking mechanism using a DynamoDB table. [ref](https://youtu.be/q5-zsBY90j8)

>**Note:** These steps are for one-time setup during creation and destruction.

### 2.1.1. To Create

1. Comment out the backend block in [provider.tf](provider.tf) and execute `terraform apply`. Terraform will create all the necessary resources, including an S3 bucket for state file storage and DynamoDB for state locking. However, it will store the state file locally.
   
2. To migrate the state file to the previously created S3 bucket, uncomment the backend block in [provider.tf] and run `terraform init`. Terraform will prompt you to migrate the local state file to the S3 bucket; respond with "yes."

3. You have now successfully set up S3 state management and state locking.

### 2.1.2. To Destroy

1. Comment out the backend block in [provider.tf](provider.tf) and run `terraform init -migrate-state`. Terraform will ask if you want to migrate the state from the S3 bucket to a local state file; respond with "yes."

2. Access the AWS S3 console and empty the contents of the S3 bucket by clicking the round button to the left of the bucket name and selecting the "Empty" option from the top-right menu.

3. Finally, execute `terraform destroy` to completely clean up the infrastructure.

## 2.2. Things to do after EKS created
- Update your kube-config file with newly created EKS configs
  ```
  aws eks --profile <PROFILE_NAME> update-kubeconfig --region <REGION> --name <CLUSTER_NAME>
  ```
- Add your user permission to view nodes in EKS, run the below command to edit the `aws-auth`configMap

  ```bash
  kubectl edit configmap aws-auth -n kube-system
  ```

  Then go down to mapUsers and add the following (replace [account_id] with your Account ID)

    ```yaml
    mapUsers: |
      - userarn: <arn of your IAM user>
        groups:
        - system:masters
  ```
## 2.3. Customization
You can customize the Terraform code to your needs. For example, you can change the name of S3 bucket or ECR repository through the variable file called [`dev-variables.tfvars`](dev-variables.tfvars)

> **Note:**
This Terraform code is intended for demo purposes only. It is not suitable for production use as it does not include all the necessary security configurations.
