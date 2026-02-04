# Project Bedrock - InnovateMart EKS Deployment

## Project Status

![Build Status](https://github.com/Gidi1422/innovatemart-capstone-final/actions/workflows/terraform.yml/badge.svg)

## Overview

This repository contains the automated infrastructure and deployment for the Retail Store Sample App on AWS EKS as part of the InnovateMart Capstone.

## Infrastructure Components

- **VPC:** Custom VPC with public and private subnets (`vpc.tf`).
- **EKS:** Managed Kubernetes cluster for the Retail Store application (`eks.tf`).
- **RDS:** Managed PostgreSQL database for application data (`rds.tf`).
- **Serverless:** S3 Bucket (`bedrock-assets-soe-025-0202`) triggering a Lambda for image processing.

## Deployment Guide

1. **GitHub Secrets:** Ensure `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are added to the repository secrets.
2. **CI/CD:** The pipeline is triggered on every push to the `main` branch.
3. **Provisioning:** Terraform handles the state via S3 and applies changes automatically.

## Post-Deployment Access

- **Application URL:** Run `kubectl get svc -n retail-app` to retrieve the LoadBalancer DNS.
- **Developer Access:** Credentials for the `bedrock-dev-view` user can be found in the **Outputs** section of the successful GitHub Actions run.

---

_Created by: [Valentine Chigozie Azagidi/soe-025-0202]_
\*Date: February 4, 2026
Wed, Feb  4, 2026  4:14:39 PM
