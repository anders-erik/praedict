#!/bin/bash


TMP_DB_DIR=$REPO_ROOT_DIR/.localdev/tmp
TMP_DB_FILE=$REPO_ROOT_DIR/.localdev/tmp/database.sqlite
SCHEMA_FILE="schema.sql"
DATA_FILE="init-data.sql"

mkdir -p $TMP_DB_DIR
# Remove existing database if it exists
if [ -f "$TMP_DB_FILE" ]; then
    rm "$TMP_DB_FILE"
    echo "Removed existing database: $TMP_DB_FILE"
fi

# Create new database and initialize schema
sqlite3 "$TMP_DB_FILE" < "$SCHEMA_FILE"
echo "Database initialized with schema: $SCHEMA_FILE"
sqlite3 "$TMP_DB_FILE" < "$DATA_FILE"
echo "Database initialized with data : $DATA_FILE."


docker run --rm \
  -v $TMP_DB_FILE:/db/database.sqlite \
  -v sqlite-data_init:/db \
  alpine 