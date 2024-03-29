#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Environment variables
DB_HOST=db
DB_PORT=5432
POSTGRES_DB=demo
POSTGRES_USER=demouser
POSTGRES_PASSWORD=password


# Create the 'store' table
PGPASSWORD=$POSTGRES_PASSWORD psql -h "$DB_HOST" -U "$POSTGRES_USER" -d "$POSTGRES_DB" -p "$DB_PORT" <<-EOSQL
    CREATE TABLE IF NOT EXISTS store (
        id SERIAL PRIMARY KEY,
        name TEXT NOT NULL
    );
EOSQL

echo "Table 'store' created successfully."