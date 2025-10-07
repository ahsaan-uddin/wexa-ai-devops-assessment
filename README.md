# Wexa AI - DevOps Internship Assessment

## 📋 Project Overview

This project demonstrates a complete DevOps pipeline for containerizing and deploying a Next.js application using modern cloud-native technologies. The implementation includes Docker containerization, CI/CD with GitHub Actions, and Kubernetes deployment configurations.

**Author:** Ahsaan Uddin  
**Repository:** [https://github.com/ahsaan-uddin/wexa-ai-devops-assessment](https://github.com/ahsaan-uddin/wexa-ai-devops-assessment)  
**Container Registry:** [GHCR - wexa-ai-devops-assessment](https://github.com/ahsaan-uddin/wexa-ai-devops-assessment/pkgs/container/wexa-ai-devops-assessment)

---

## 🚀 Application Architecture

### Tech Stack
- **Frontend Framework:** Next.js 15.5.4
- **Runtime:** Node.js 20
- **Containerization:** Docker with multi-stage builds
- **CI/CD:** GitHub Actions
- **Container Registry:** GitHub Container Registry (GHCR)
- **Orchestration:** Kubernetes (Minikube for local development)
- **Health Monitoring:** Built-in health checks and readiness probes

### Application Features
- Static homepage with Next.js optimization
- Health check API endpoint (`/api/health`)
- Production-optimized builds
- Multi-stage Docker builds for minimal image size
- Comprehensive monitoring and health checks

---

## 📁 Project Structure

```
wexa-ai-devops-assessment/
├── .github/
│   └── workflows/
│       └── build-and-push.yml  # CI/CD pipeline
├── k8s/
│   ├── deployment.yaml   # Kubernetes deployment
│   └── service.yaml      # Kubernetes service
├── pages/
│   ├── api/
│   │   └── health.js     # Health check endpoint
│   ├── index.js          # Main application page
├── public/                                
├── Dockerfile        # Multi-stage Docker build
├── Makefile              # Development utilities
├── package.json
├── package-lock.json
└── README.md
```

---

## 🛠️ Local Development

### Prerequisites
- Node.js 18+ 
- npm 8+
- Docker (optional, for containerized development)

### Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/ahsaan-uddin/wexa-ai-devops-assessment.git
   cd wexa-ai-devops-assessment
   ```

2. **Install dependencies**
   ```bash
   npm ci
   ```

3. **Build the application**
   ```bash
   npm run build
   ```

4. **Start the development server**
   ```bash
   npm run dev
   ```
   Application will be available at `http://localhost:3000`

5. **Run in production mode**
   ```bash
   npm run build
   npm start
   ```

### Health Check
Verify the application is running correctly:
```bash
curl http://localhost:3000/api/health
```
Expected response: `{"status":"healthy","timestamp":"2024-01-01T00:00:00.000Z"}`

---

## 🐳 Docker Containerization

### Multi-Stage Docker Build

The project uses a multi-stage Docker build for optimized production images:

- **Stage 1 (deps):** Dependency installation with layer caching
- **Stage 2 (builder):** Application build and optimization
- **Stage 3 (runner):** Minimal production runtime

### Build and Run Locally

1. **Build the Docker image**
   ```bash
   docker build -t ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local .
   ```

2. **Run the container**
   ```bash
   docker run --rm -p 3000:3000 ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local
   ```

3. **Test the containerized application**
   ```bash
   curl http://localhost:3000/api/health
   ```

### Docker Optimizations
- Multi-stage builds reduce final image size
- Alpine Linux base image for minimal footprint
- Non-root user execution for security
- Layer caching for faster builds
- Production-optimized Node.js runtime

---

## 🔄 CI/CD Pipeline

### GitHub Actions Workflow

The CI/CD pipeline automatically builds, tests, and deploys the application on every push to the main branch.

#### Workflow Features
- **Trigger:** On push to main branch
- **Build Environment:** Ubuntu 24.04 with Node.js 20
- **Steps:**
  1. Code checkout
  2. Node.js environment setup with caching
  3. Dependency installation (`npm ci`)
  4. Application build (`npm run build`)
  5. Docker image build and push to GHCR
  6. Image tagging with both commit SHA and `latest`

#### Image Tagging Strategy
- `ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:[commit-sha]` - Immutable version
- `ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:latest` - Latest stable

#### Workflow File
Located at: `.github/workflows/docker-build-push.yml`

---

## ☸️ Kubernetes Deployment

### Kubernetes Manifests

All Kubernetes configuration files are located in the `k8s/` directory.

#### Deployment (`k8s/deployment.yaml`)
- **Replicas:** 3 for high availability
- **Resource Limits:** CPU and memory constraints
- **Health Checks:**
  - Liveness probe: `/api/health`
  - Readiness probe: `/api/health`
  - Startup probe: `/api/health`
- **Rolling Update Strategy:** 25% max unavailable, 25% max surge
- **Security:** Non-root user execution

#### Service (`k8s/service.yaml`)
- **Type:** ClusterIP (for internal access)
- **Port:** 3000
- **Selector:** Matches deployment labels

---

## 🚀 Minikube Deployment

### Prerequisites
- Minikube installed and running
- kubectl configured

### Deployment Steps

1. **Start Minikube**
   ```bash
   minikube start
   ```

2. **Apply Kubernetes manifests**
   ```bash
   kubectl apply -f k8s/
   ```

3. **Verify deployment**
   ```bash
   kubectl get all -l app=wexa-ai-devops-assessment
   ```

4. **Access the application**
   ```bash
   minikube service wexa-ai-devops-assessment-service --url
   ```

5. **Check application health**
   ```bash
   curl $(minikube service wexa-ai-devops-assessment-service --url)/api/health
   ```

### Monitoring and Management

1. **View deployment status**
   ```bash
   kubectl get deployments
   kubectl get pods -l app=wexa-ai-devops-assessment
   ```

2. **Check service details**
   ```bash
   kubectl get services
   kubectl describe service wexa-ai-devops-assessment-service
   ```

3. **View application logs**
   ```bash
   kubectl logs -l app=wexa-ai-devops-assessment
   ```

4. **Scale the deployment**
   ```bash
   kubectl scale deployment wexa-ai-devops-assessment --replicas=5
   ```

---

## 🔧 Development Utilities

### Makefile Commands

The project includes a Makefile for common development tasks:

```bash
make help              # Show all available commands
make test              # Run smoke tests
make build             # Build the application
make docker-build      # Build Docker image locally
make docker-run        # Run Docker container locally
make k8s-apply         # Apply Kubernetes manifests
make k8s-delete        # Delete Kubernetes resources
```

### Smoke Testing

Run comprehensive smoke tests to verify the deployment:

```bash
make test
```

Tests include:
- Application health check
- Container health verification
- Kubernetes resource validation

---

## 📊 Monitoring & Health Checks

### Application Health Endpoint
- **Endpoint:** `GET /api/health`
- **Response:** JSON with status and timestamp
- **Use:** Kubernetes liveness and readiness probes

### Kubernetes Health Monitoring
- **Liveness Probe:** Restarts container if unhealthy
- **Readiness Probe:** Controls traffic to pod
- **Startup Probe:** Allows slow-starting containers

### Logging
- Structured logging for easy debugging
- JSON format for log aggregation
- Error tracking and monitoring

---

## 🔒 Security Considerations

### Container Security
- Non-root user execution
- Minimal base image (Alpine Linux)
- Regular security updates
- No sensitive data in images

### Kubernetes Security
- Resource limits to prevent resource exhaustion
- Read-only root filesystem where possible
- Security context constraints

### Network Security
- Internal service communication only
- No external database dependencies
- Minimal exposed ports

---

## 📈 Performance Optimizations

### Next.js Optimizations
- Static generation where possible
- Image optimization
- Code splitting and tree shaking
- Build caching

### Docker Optimizations
- Multi-stage builds
- Layer caching
- Minimal base images
- Efficient dependency management

### Kubernetes Optimizations
- Resource limits and requests
- Horizontal pod autoscaling readiness
- Efficient health check intervals
- Rolling update strategies

---

## 🐛 Troubleshooting

### Common Issues

1. **Build Failures**
   - Check Node.js version compatibility
   - Verify dependency installation
   - Check Docker build context

2. **Kubernetes Deployment Issues**
   - Verify Minikube is running
   - Check resource availability
   - Inspect pod logs for errors

3. **Health Check Failures**
   - Verify application is running
   - Check network connectivity
   - Validate probe configurations

### Debugging Commands

```bash
# Check pod status
kubectl get pods

# View detailed pod information
kubectl describe pod <pod-name>

# Check application logs
kubectl logs <pod-name>

# Debug service connectivity
kubectl port-forward service/wexa-ai-devops-assessment-service 3000:3000
```

---

## 🔮 Future Enhancements

### Potential Improvements
- Horizontal Pod Autoscaler configuration
- Ingress controller setup
- SSL/TLS termination
- Monitoring with Prometheus and Grafana
- Log aggregation with ELK stack
- Database integration
- Custom domain configuration
- Blue-green deployment strategies

---



