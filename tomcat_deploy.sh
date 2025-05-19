#!/bin/bash

ENVIRONMENT=${1:-DEV}

# Build the Docker image
docker build -t tomcat-ansible-test ./deploy

# Run the Docker container
docker run --rm -it \
  --privileged=true \
  -v "$(pwd)/deploy:/data" \
  tomcat-ansible-test \
  bash -c "cd /data && ./tomcat_test.sh --extra-vars='env=${ENVIRONMENT}'"
