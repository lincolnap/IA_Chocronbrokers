#!/usr/bin/env bash
# Levanta N8N y Supabase. Requiere Docker en ejecución.

set -e
cd "$(dirname "$0")/.."

echo "Levantando N8N (PostgreSQL + Redis)..."
docker compose up -d

echo ""
echo "Levantando Supabase..."
./scripts/deploy-supabase.sh

echo ""
echo "Listo."
echo "  N8N:       http://localhost:5678"
echo "  Supabase:  http://localhost:8000"
