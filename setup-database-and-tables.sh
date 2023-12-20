#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Environment variables
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-5432}
DB_NAME=${POSTGRES_DB:-demo}
DB_USER=${POSTGRES_USER:-demouser}
DB_PASSWORD=${POSTGRES_PASSWORD:-password}

# Wait for PostgreSQL to become available
echo "Waiting for PostgreSQL to start..."
until PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" -c '\q'; do
  >&2 echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done
>&2 echo "PostgreSQL is up - executing command"

# Create the 'store' table
PGPASSWORD=$DB_PASSWORD psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -p "$DB_PORT" <<-EOSQL
    CREATE TABLE IF NOT EXISTS store (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );
EOSQL

echo "Table 'store' created successfully."
