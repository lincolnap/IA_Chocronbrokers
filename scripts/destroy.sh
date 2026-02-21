#!/usr/bin/env bash
# Destruye todo: para N8N y Supabase (contenedores + volúmenes).
# Uso: ./scripts/destroy.sh [--yes]
#   --yes, -y   Borrar también supabase-docker/ sin preguntar

set -e
cd "$(dirname "$0")/.."

REMOVE_SUPABASE_DIR=false
for arg in "$@"; do
  case $arg in
    -y|--yes) REMOVE_SUPABASE_DIR=true ;;
  esac
done

echo "Deteniendo y eliminando N8N (contenedores + volúmenes)..."
docker compose down -v --remove-orphans

if [[ -d supabase-docker ]]; then
  echo ""
  echo "Deteniendo y eliminando Supabase (contenedores + volúmenes)..."
  (cd supabase-docker && docker compose down -v --remove-orphans)
  if [[ "$REMOVE_SUPABASE_DIR" == true ]]; then
    rm -rf supabase-docker
    echo "supabase-docker/ eliminada."
  else
    echo ""
    read -p "¿Borrar carpeta supabase-docker/? (s/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[SsYy]$ ]]; then
      rm -rf supabase-docker
      echo "supabase-docker/ eliminada."
    fi
  fi
else
  echo "No existe supabase-docker/ (Supabase no estaba desplegado)."
fi

echo ""
echo "Listo. Todo destruido."
