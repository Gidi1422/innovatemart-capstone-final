# Project Bedrock - InnovateMart EKS Deployment

## 🚀 Project Status: COMPLETE & VERIFIED

**Last Updated:** February 9, 2026

### Overview

This repository contains the automated infrastructure and deployment for the **Retail Store Sample App** on AWS EKS as part of the InnovateMart Capstone. The project demonstrates a full-stack cloud-native architecture using Terraform for IaC and Kubernetes for orchestration.

### ✅ Technical Verification (Feb 9 Update)

- **Infrastructure:** Successfully provisioned via Terraform (EKS v1.34, VPC, RDS, Lambda).
- **Authentication Fix:** Resolved EKS 1.30+ `Unauthorized` errors by implementing the **EKS Access Entry API** and mapping IAM User `Valentine` to `AmazonEKSClusterAdminPolicy`.
- **Application:** Microservices (Carts, Catalog, Orders) are in a `Running` state within the `retail-app` namespace.
- **Load Balancer:** The External UI Load Balancer is active and accessible.
- **Kustomize Resolution:** Manually reconstructed the `kustomization.yaml` manifest to include all microservice components, resolving the "empty manifest" deployment error.

---

### 🏗️ Infrastructure Components

- **VPC:** Custom VPC with 2 Public and 2 Private subnets across multiple AZs (`vpc.tf`).
- **EKS:** Managed Kubernetes cluster running 3 x `t3.small` nodes (`eks.tf`).
- **RDS:** Managed Database instance for persistent application data (`rds.tf`).
- **Serverless:** S3 Bucket (`bedrock-assets-soe-025-0202`) triggering an AWS Lambda function for automated image processing.

---

### 🔧 Deployment & Troubleshooting Guide

#### 1. Initial Provisioning

Terraform handles the infrastructure state via an S3 backend.

```bash
terraform init
terraform apply --auto-approve
2. Kubernetes Deployment
This project uses Kustomize. To apply the application layer:

Bash
kubectl apply -k ./kubernetes/
3. Known Issue Resolution: Load Balancer
Connectivity propagation delay was addressed by reconciling the AWS Load Balancer Controller. Proof of Life:

UI URL: http://a112578727ffe40c3ba8e0aa83f88f83-1937056088.us-east-1.elb.amazonaws.com

Verification: Run kubectl get all -n retail-app to view resource status.

🛡️ Access & Security
CI/CD: GitHub Actions pipeline triggers on every push to main to build and push images to ECR.

Developer Access: IAM role bedrock-dev-view is mapped via Access Entries for read-only cluster visibility.

Created by: Valentine Chigozie Azagidi / soe-025-0202

Submission Date: February 9, 2026
```
