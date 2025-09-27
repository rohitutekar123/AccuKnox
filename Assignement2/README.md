# Health Monitoring Scripts

This repo has **two Bash scripts**:

1. **System Health Monitoring** – checks CPU, memory, disk, and running processes.
2. **Application Health Checker** – checks if an app (e.g., Wisecow) is running in Kubernetes.

---

## 1. System Health Monitoring

**What it does:**

* Monitors CPU, Memory, Disk, and Processes.
* Shows **ALERT** if any usage is too high.
* Shows **System is healthy ✅** if everything is fine.

**Usage:**

```bash
chmod +x system_health.sh
./system_health.sh
```

**Default thresholds:**

* CPU > 80%
* Memory > 80%
* Disk > 80%
* Processes > 300

---

## 2. Application Health Checker

**What it does:**

* Checks if the app endpoint returns **HTTP 200 OK**.
* Prints **Application is UP ✅** or **Application is DOWN ❌**.

**Prerequisites:**

* Kubernetes cluster with the app deployed
* `kubectl` and `curl` installed

**Usage:**

```bash
kubectl port-forward svc/wisecow-service 8080:80
./app_health_checker.sh
```
