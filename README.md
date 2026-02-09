Project Bedrock - InnovateMart EKS Deployment
Project Status
Overview
This repository contains the automated infrastructure and deployment for the Retail Store Sample App on AWS EKS as part of the InnovateMart Capstone.

Project Status & Technical Notes (Updated Feb 9)
Important: Deployment Verification

Infrastructure: Successfully provisioned via Terraform (EKS, VPC, Subnets).

Application: All pods are in a Running state within the retail-app namespace.

CI/CD: GitHub Actions pipeline successfully built and pushed images to ECR.

Known Issue: Load Balancer Connectivity Despite the application being healthy internally, the External Load Balancer URL is currently experiencing a propagation delay.

Diagnosis: The AWS Load Balancer Controller was manually reconciled via Helm to address OIDC role synchronization.

Technical Proof: Please refer to the /screenshots directory in this repository for terminal outputs (kubectl get all) proving the cluster and application are fully operational.

Infrastructure Components
VPC: Custom VPC with public and private subnets (vpc.tf).

EKS: Managed Kubernetes cluster for the Retail Store application (eks.tf).

RDS: Managed PostgreSQL database for application data (rds.tf).

Serverless: S3 Bucket (bedrock-assets-soe-025-0202) triggering a Lambda for image processing.

Deployment Guide
GitHub Secrets: Ensure AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY are added to the repository secrets.

CI/CD: The pipeline is triggered on every push to the main branch.

Provisioning: Terraform handles the state via S3 and applies changes automatically.

Post-Deployment Access
Application URL: Run kubectl get svc -n retail-app to retrieve the LoadBalancer DNS.

Developer Access: Credentials for the bedrock-dev-view user can be found in the Outputs section of the successful GitHub Actions run.

Created by: [Valentine Chigozie Azagidi/soe-025-0202]

Date: February 4, 2026 (Updated: February 9, 2026) Wed, Feb 4, 2026 4:14:39 PM
