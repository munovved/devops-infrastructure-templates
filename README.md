# DevOps Infrastructure Templates & Automation Sandbox

Welcome to my personal repository of production-ready infrastructure templates, CI/CD configurations, and automation utilities. This repository serves as a boilerplate library and a sandbox for testing GitOps, IaC, and SRE methodologies across various cloud environments.

## 📁 Repository Structure

* **terraform/**: Infrastructure as Code (IaC) configuration for deploying networking (VPC, Subnets) and a Managed Service for Kubernetes cluster with specialized GPU worker nodes in Yandex Cloud.
* **helm/**: A parameterized Helm v3 chart for microservice deployment, complete with pre-configured resource limits, horizontal pod autoscaling (HPA), and Nginx Ingress routes.
* **gitlab-ci/**: A complete enterprise-grade DevSecOps pipeline definition (`.gitlab-ci.yml`) including chart linting, secure Docker builds, automated vulnerability scanning with Trivy, and automated GitOps image tag updates.
* **automation/**: A set of internal automation scripts featuring a Bash utility for backup retention, a Python script for microservice endpoint observability, and a custom Golang CLI tool simulating container registry cleanup logic.

## 🛠️ Stack & Technologies

* **Cloud & Orchestration**: Yandex Cloud, Kubernetes (Managed Service), Helm v3, ArgoCD (GitOps).
* **Infrastructure as Code**: Terraform.
* **CI/CD & Security**: GitLab CI/CD, Docker, Trivy.
* **Automation**: Golang, Python, Bash.

## 🚀 Key Implementation Details

1.  **Infrastructure as Code**: The Terraform manifests leverage the official Yandex Cloud provider to provision a highly available environment, abstracting cloud IDs via variables and using native resource blocks for isolated network design.
2.  **GPU Compute Provisioning**: The K8s node group is configured using the `gpu-standard-v3` platform to demonstrate automated hardware acceleration attachment for compute-intensive and ML tasks, paired with specific container runtime limit injections (`nvidia.com/gpu`).
3.  **DevSecOps & GitOps Workflow**: The continuous integration pipeline shifts security left by gating production deployments with `trivy` container scanning. Upon passing security checks, it executes automated value injection back into the Git repository to trigger continuous deployment sync loops.

---
*Maintained by Nikolai Munov. Feel free to use these templates as a baseline for your cloud-native deployments.*
