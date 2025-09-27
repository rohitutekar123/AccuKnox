# Wisecow Application – Containerisation & Deployment on Kubernetes

## 📖 Introduction

The Wisecow Application is a simple demo app that serves quotes and cow ASCII art.
This project focuses on taking that application and making it production-ready by containerizing it, deploying it to Kubernetes, and automating the workflow with CI/CD.

### 📂 Project Structure
```
.
├── .github/workflows/
│   └── ci-cd.yaml             # CI/CD pipeline for build and deployment
├── k8s/
│   ├── cluster-issuer.yaml    # Cert-manager ClusterIssuer for TLS
│   ├── deployment.yaml        # Kubernetes Deployment resource
│   ├── ingress.yaml           # Kubernetes Ingress with TLS
│   ├── namespace.yaml         # Kubernetes Namespace for the app
│   └── serives.yaml           # Kubernetes Service resource
├── Dockerfile                 # Defines the container image for the Wisecow app
├── wisecow.sh                 # The application source code
└── README.md                  # Project documentation
```

---

## 🚀 Full Execution Guide

Follow these steps to deploy the application on a local Minikube cluster.

### 1. Start Minikube and Enable Addons
```bash
minikube start
minikube addons enable ingress
```

### 2. Install cert-manager
`cert-manager` is required to automatically issue the TLS certificate.
```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.5/cert-manager.yaml

# Wait for cert-manager to be ready
kubectl wait --for=condition=Available deployment --timeout=300s -n cert-manager --all
```

### 3. Deploy the Wisecow Application
Apply all the Kubernetes manifests to create the application resources.
```bash
kubectl apply -f k8s/
```

### 4. Configure Local DNS
Add the application's domain to your local `/etc/hosts` file.
```bash
# Get the Minikube IP
MINIKUBE_IP=$(minikube ip)

# Add the entry to your hosts file (requires sudo)
echo "$MINIKUBE_IP wisecow.local" | sudo tee -a /etc/hosts
```

### 5. Access the Application
Open your browser and navigate to the application.

**URL**: https://wisecow.local/

> **Note**: Your browser will show a security warning because the TLS certificate is self-signed. You can safely proceed to view the application.

---

## 🐳 Step 1 – Dockerization

**Build the Docker image:**
```bash
docker build -t wisecow:latest .
```

**Run the container locally:**
```bash
docker run --rm -p 4499:4499 wisecow:latest
```

## ☸️ Step 2 – Kubernetes Deployment

Kubernetes manifests define the application's resources:
*   **Deployment**: Defines pods running Wisecow containers.
*   **Service**: Exposes the app internally.
*   **Ingress**: Routes external HTTP/HTTPS traffic to the service.

**Apply all manifests:**
```bash
kubectl apply -f k8s/
```

## 🔄 Step 3 – CI/CD Automation

A GitHub Actions workflow automates the build and deployment process on every push to the `main` branch.
*   **Build & Push**: A new Docker image is built and pushed to Docker Hub.
*   **Deploy**: The pipeline automatically applies the Kubernetes manifests to the cluster.

## 🔒 Step 4 – TLS Implementation

Secure communication is enabled using an Ingress with a TLS certificate automatically provisioned by `cert-manager` via a `ClusterIssuer`. The Ingress is configured to enforce HTTPS.
