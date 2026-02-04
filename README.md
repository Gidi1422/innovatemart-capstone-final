# Project Bedrock - InnovateMart EKS Deployment

## Overview

This repository contains the automated infrastructure and deployment for the Retail Store Sample App on AWS EKS.

## Infrastructure

- **VPC:** project-bedrock-vpc
- **EKS:** project-bedrock-cluster
- **Serverless:** S3 Bucket triggering a Lambda for image processing.

## Deployment Guide

1. Configure GitHub Secrets: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`.
2. Push code to `main` branch to trigger the CI/CD pipeline.
3. The pipeline will provision AWS resources and deploy the app via Helm.

## Accessing the App

Run `kubectl get svc -n retail-app` to get the LoadBalancer URL.
