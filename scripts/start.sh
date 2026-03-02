#!/usr/bin/env bash
# Levanta Caddy (proxy HTTPS) y Supabase. Requiere Docker en ejecución.

set -e
cd "$(dirname "$0")/.."

echo "Levantando Caddy (proxy HTTPS)..."
docker compose up -d

echo ""
echo "Levantando Supabase..."
./scripts/deploy-supabase.sh

echo ""
echo "Listo."
echo "  Supabase:  https://supabase2.chocronbrokers.com"
echo "  API Kong:  http://localhost:8000"
