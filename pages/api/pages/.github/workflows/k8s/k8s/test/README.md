# Wexa AI - DevOps Assessment
**Author:** ahsaan-uddin  
**Repo:** https://github.com/ahsaan-uddin/wexa-ai-devops-assessment

## Overview
Small Next.js demo app prepared for the Wexa AI DevOps internship assignment. Contains:
- Next.js app with `/api/health` endpoint
- Multi-stage Dockerfile
- GitHub Actions workflow to build & push to GHCR
- Kubernetes manifests for deployment + service
- Makefile & smoke test

## Quick local run
1. Install deps: `npm ci`
2. Build: `npm run build`
3. Start: `npm start` → open `http://localhost:3000`
4. Health: `curl http://localhost:3000/api/health`

## Docker
Build:
```bash
docker build -t ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local .
docker run --rm -p 3000:3000 ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local
