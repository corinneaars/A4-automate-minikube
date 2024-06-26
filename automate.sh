#!/bin/bash

# Define repository URL and directory
REPO_URL="https://github.com/corinneaars/A3-minikube-proj.git"
LOCAL_DIR="Assignment04-Production"  # Local directory where the repository will be cloned/pulled

# Clone or pull the repository
if [ -d "$LOCAL_DIR" ]; then
    cd "$LOCAL_DIR"
    git pull
else
    git clone "$REPO_URL" "$LOCAL_DIR"
fi

#Build images and deploy application
cd "$LOCAL_DIR"
./deploy.sh
