# DevOps Infrastructure Templates and Automation Sandbox

My personal collection of infrastructure templates, CI/CD configs, and automation scripts. I use this repository as a baseline library for setting up environments and testing GitOps, IaC, and SRE practices.

## Repository Structure

* **terraform/**: Terraform manifests to spin up a VPC, subnets, and a Managed Kubernetes cluster with GPU-enabled worker nodes in Yandex Cloud.
* **helm/**: A basic Helm v3 chart for microservices with pre-configured resource limits (including GPU), HPA, and Nginx Ingress routes.
* **gitlab-ci/**: GitLab CI pipeline configuration (`.gitlab-ci.yml`) that includes Helm linting, Docker build, security scanning via Trivy, and automated GitOps image tag updates.
* **automation/**: Practical automation scripts: Bash script for backup rotation, Python script for endpoint health checks, and a custom Go CLI utility for container registry cleanup simulation.

## Stack

* **Cloud and Orchestration**: Yandex Cloud, Kubernetes, Helm v3, ArgoCD.
* **Infrastructure as Code**: Terraform.
* **CI/CD and Security**: GitLab CI/CD, Docker, Trivy.
* **Languages**: Golang, Python, Bash.

## Implementation Notes

1. **Infrastructure**: The Terraform code uses variables for Cloud IDs and provisions a standard production-ready network layout along with the K8s master and node groups.
2. **GPU Support**: The Kubernetes node group uses the `gpu-standard-v3` platform. Container resource limits (`nvidia.com/gpu`) are configured in the Helm values to demonstrate hardware acceleration handling.
3. **CI/CD Workflow**: The pipeline builds the Docker image, runs a security check using Trivy, and then uses a service script to update the image tag directly in the Helm values to trigger an ArgoCD sync.

---
Maintained by Nikolai Munov.
