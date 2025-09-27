# Wisecow Application – Containerisation & Deployment on Kubernetes

## 📖 Introduction

The Wisecow Application is a simple demo app that serves quotes and cow ASCII art.
This project focuses on taking that application and making it production-ready by:


```
📂 Project Structure
├── Dockerfile                 # Defines container image for Wisecow app
├── k8s/                       # Kubernetes manifests
│   ├── deployment.yaml        # Deployment resource
│   ├── service.yaml           # Service resource
│   ├── ingress.yaml           # Ingress with TLS
│   └── clusterissuer.yaml     # Cert-manager ClusterIssuer
├── .github/workflows/         # GitHub Actions workflows
│   └── ci-cd.yaml             # CI/CD pipeline
├── src/                       # Wisecow application code
└── README.md                  # Project documentation

```
# 🐳 Step 1 – Dockerization
**Build image**  
```docker build -t wisecow:latest .```

**Run container**  
```docker run -p 8080:8080 wisecow:latest```

# ☸️ Step 2 – Kubernetes Deployment
**We create Kubernetes manifests:** 
Deployment → Defines pods running Wisecow containers 

Service → Exposes the app internally/externally

Ingress → Routes external HTTP/HTTPS traffic  

**Apply manifests:  **  
```kubectl apply -f k8s/```

**Check deployment status:**  
```
kubectl get pods
kubectl get svc
kubectl get ingress
```
# 🔄 Step 3 – CI/CD Automation
**A GitHub Actions workflow is configured:**  
On push to main branch → The pipeline triggers  

Build & Push → Docker image is built and pushed to Docker Hub (or another registry)  

Deploy (Challenge Goal) → The pipeline applies Kubernetes manifests automatically  

This ensures continuous integration (build/test on every commit) and continuous deploym  

# 🔒 Step 4 – TLS Implementation  
By default, Kubernetes Ingress exposes apps over HTTP. For security, HTTPS with TLS certificates is required.  

Create a ClusterIssuer (self-signed or Let’s Encrypt)  
or create it manually by  
```kubectl create secret tls```
Update Ingress to request a TLS certificate  

The certificate is stored as a Kubernetes secret and used by Ingress  

#Add domain in /etc/hosts this file  

```minikube ip```  

**Access via**  
```https://wisecow.local/```



