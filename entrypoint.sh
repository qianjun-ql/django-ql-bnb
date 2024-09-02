#!/bin/sh

if [ "$DATABASE" = "postgres" ]; then
    echo "Check if the database is running..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        echo "Waiting for PostgreSQL at $SQL_HOST:$SQL_PORT..."
        sleep 0.1
    done

    echo "The database is running..."
fi

# Apply database migrations
python manage.py migrate

# Execute the command passed as arguments to the script
exec "$@"