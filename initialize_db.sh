#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Run the psql commands to initialize the database
PGPASSWORD=$POSTGRES_PASSWORD psql -h "$DB_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -p "$DB_PORT" <<-EOSQL
    CREATE TABLE IF NOT EXISTS store (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );
EOSQL

echo "Database initialized successfully."
