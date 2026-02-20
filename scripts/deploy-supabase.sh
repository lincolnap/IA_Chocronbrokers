#!/usr/bin/env bash
# Despliega Supabase usando el stack oficial de Docker.
# Usa supabase/.env y deja el stack en supabase-docker/

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
SUPABASE_ENV="$REPO_ROOT/supabase/.env"
SUPABASE_DOCKER="$REPO_ROOT/supabase-docker"

if [[ ! -f "$SUPABASE_ENV" ]]; then
  echo "Error: No existe supabase/.env. Cópialo desde supabase/.env.example o créalo con las variables de Supabase."
  exit 1
fi

if [[ ! -d "$SUPABASE_DOCKER" ]]; then
  echo "Clonando repositorio oficial de Supabase (solo carpeta docker)..."
  mkdir -p "$REPO_ROOT"
  cd "$REPO_ROOT"
  git clone --depth 1 --filter=blob:none --sparse https://github.com/supabase/supabase.git supabase-repo
  cd supabase-repo
  git sparse-checkout set docker
  cp -r docker "$SUPABASE_DOCKER"
  cd "$REPO_ROOT"
  rm -rf supabase-repo
  echo "Carpeta supabase-docker creada."
fi

echo "Copiando supabase/.env a supabase-docker/.env"
cp "$SUPABASE_ENV" "$SUPABASE_DOCKER/.env"

echo "Levantando Supabase (docker compose up -d)..."
cd "$SUPABASE_DOCKER"
docker compose up -d

echo ""
echo "Supabase desplegado."
echo "  API (Kong):     http://localhost:8000"
echo "  Studio:         revisar 'docker compose ps' para el puerto de studio"
echo "  PostgreSQL:     localhost:5432 (Supavisor)"
echo "  Pooler:         localhost:6543"
echo ""
echo "Para ver logs: cd supabase-docker && docker compose logs -f"
