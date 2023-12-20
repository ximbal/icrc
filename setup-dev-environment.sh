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

# Step 3: Wait for PostgreSQL to be ready (optional but recommended)
echo "Waiting for PostgreSQL to be ready..."
sleep 10 # Adjust the sleep time as necessary

# Step 4: Execute DB Initialization Script
echo "Initializing the database..."
./setup-database-and-tables.sh

# Step 5: Run cURL command to interact with the Python service
echo "Running cURL command to insert data into the database..."
curl -X POST http://localhost:8000/path/to/your/api -H "Content-Type: application/json" -d '{"name": "test_store"}'

echo "Setup complete!"
