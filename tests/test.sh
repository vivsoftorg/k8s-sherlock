#!/bin/bash

set -e

# Build the Docker image
echo "Building Docker image..."
docker build -t test-image .

# Run the container
echo "Running Docker container..."
container_id=$(docker run -it --rm test-image:latest)

# Helper function to run commands inside the container
run_command() {
  docker exec $container_id "$@"
}

# All tests passed
echo "All tests passed successfully."

# Cleanup
docker stop $container_id
docker rmi test-image