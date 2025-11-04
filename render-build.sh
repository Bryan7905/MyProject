#!/usr/bin/env bash
set -euo pipefail

echo "Upgrading pip..."
python -m pip install --upgrade pip

# If using Poetry locally, export requirements to ensure correct pinned versions on Render.
if [ -f pyproject.toml ] && command -v poetry >/dev/null 2>&1; then
  echo "Exporting requirements.txt from Poetry..."
  poetry export -f requirements.txt --output requirements.txt --without-hashes
fi

if [ ! -f requirements.txt ]; then
  echo "ERROR: requirements.txt not found. Create one or ensure pyproject.toml + poetry are present." >&2
  exit 1
fi

echo "Installing Python dependencies with pip..."
python -m pip install -r requirements.txt

echo "Build step finished."