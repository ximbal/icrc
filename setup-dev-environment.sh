#!/bin/bash

# Exit if any command fails
set -e

# Step 1: Set up environment variables
echo "Setting up environment variables..."
export DB_HOST=localhost
export DB_PORT=5432
export POSTGRES_DB=demo
export POSTGRES_USER=demouser
export POSTGRES_PASSWORD=password
export LOG_LEVEL=debug

# Step 2: Run Docker Compose
echo "Starting Docker Compose services..."
docker-compose up -d

# Step 3: Run cURL command to interact with the Python service
echo "Running cURL command to insert data into the database..."
curl -X POST http://localhost:8000/stores -H "Content-Type: application/json" -d '{"store_name": "test_store"}'

echo "Setup complete!"
