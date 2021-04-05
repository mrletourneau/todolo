#!/bin/sh

if ! command -v sqlite3 &> /dev/null
then
    echo "sqlite3 could not be found. Exiting..."
    exit
fi

DATABASE_NAME=todolo
DATABASE_DEFAULT_LOCATION="$HOME/.todolo"
DATABASE_FULL_PATH="$DATABASE_DEFAULT_LOCATION/$DATABASE_NAME.db"

if [ -f $DATABASE_FULL_PATH ]; then
    echo "Database \"$DATABASE_NAME\" exists. Overwrite? (y/N): "
    read overwrite
    if [ $overwrite != "y" ]; then
        echo "Exiting..."
        exit 0;
    fi
    rm -rf $DATABASE_FULL_PATH
fi

set -e

mkdir -p $DATABASE_DEFAULT_LOCATION 
cat "sql/create_db.sql" | sqlite3 "$DATABASE_FULL_PATH"

echo "Created todolo database!"

