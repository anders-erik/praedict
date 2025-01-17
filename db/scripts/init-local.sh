#!/bin/bash

# DB_FILE="database.sqlite"
DB_FILE=$SQLITE_PATH
SCHEMA_FILE="schema.sql"
DATA_FILE="init-data.sql"

# Remove existing database if it exists
if [ -f "$DB_FILE" ]; then
    rm "$DB_FILE"
    echo "Removed existing database: $DB_FILE"
fi

# Create new database and initialize schema
sqlite3 "$DB_FILE" < "$SCHEMA_FILE"
echo "Database initialized with schema: $SCHEMA_FILE"
sqlite3 "$DB_FILE" < "$DATA_FILE"
echo "Database initialized with data : $DATA_FILE."
