#!/usr/bin/env bash
set -euo pipefail

# Set default port if not passed by Render
: "${PORT:=8000}"

# Use env var DJANGO_WSGI_MODULE to avoid editing this file
WSGI_MODULE="${DJANGO_WSGI_MODULE:-YOUR_DJANGO_PROJECT.wsgi}"

echo "Starting gunicorn: ${WSGI_MODULE}:application on 0.0.0.0:${PORT}"
exec gunicorn "${WSGI_MODULE}:application" --bind 0.0.0.0:"${PORT}" --workers 3 --log-level info