.PHONY: build docker run minikube-load deploy logs smoke

build:
	npm ci
	npm run build

docker:
	docker build -t ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local .

run: docker
	docker run --rm -p 3000:3000 ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local

minikube-load: docker
	minikube image load ghcr.io/ahsaan-uddin/wexa-ai-devops-assessment:local

deploy:
	kubectl apply -f k8s/

logs:
	kubectl logs -l app=wexa-app -c wexa-app --tail=200

smoke:
	curl -fsS http://localhost:3000/api/health | jq .
