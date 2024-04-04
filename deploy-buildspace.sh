#!/bin/bash

docker login
minikube start --driver docker

# Re-evaluate Docker environment variables
eval $(minikube docker-env)
eval $(minikube -p minikube docker-env)
minikube addons enable metrics-server
echo "Minikube started, metrics-server enabled"

# Creating buildspace image
docker rmi build-image
docker build -t build-image .
sleep 30
docker tag build-image corinneaarsbaylor/minikube-automation:build-image
sleep 30
docker push corinneaarsbaylor/minikube-automation:build-image
echo "Images built and pushed to Minikube's Docker daemon"

sleep 20
kubectl config set-context --current --namespace minikube-automation
echo "kubectl configured to use minikube-automation namespace"

# Applying the Kubernetes deployment in dev-deploy.yaml
echo "Applying the Kubernetes deployment in dev-deploy.yaml"
kubectl apply -f ./dev-deploy.yaml --namespace=minikube-automation
echo "Deployment applied"

# # Get Minikube IP
# minikube_ip=$(minikube ip)
# echo "Minikube IP: $minikube_ip"

# echo "Sleeping 45 seconds..."
# sleep 45
# minikube service nextjs-service -n minikube-automation