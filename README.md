# N8N + Supabase

Proyecto Docker para **N8N** y **Supabase** (más Redis y PostgreSQL para N8N).

## Cómo ejecutar

1. **Variables de entorno**
   ```bash
   cp .env.example .env
   ```
   Edita `.env` y asigna `N8N_DB_PASSWORD` (obligatorio).

2. **Levantar todo (N8N + Supabase)**
   ```bash
   ./scripts/start.sh
   ```
   O por separado: `docker compose up -d` (N8N) y `./scripts/deploy-supabase.sh` (Supabase). La primera vez Supabase se clona en `supabase-docker/`. Variables de Supabase en `supabase/.env`.

## URLs

| Servicio   | URL                    |
|-----------|-------------------------|
| **N8N**   | http://localhost:5678   |
| **Supabase API** | http://localhost:8000 |
| **PostgreSQL (Supabase)** | localhost:5432 |
| **Redis** | localhost:6379          |

Desde N8N (contenedor) usa `http://host.docker.internal:8000` para la API de Supabase.

## Comandos

```bash
# Parar N8N
docker compose down

# Parar Supabase
cd supabase-docker && docker compose down

# Destruir todo (contenedores + volúmenes; opcionalmente borra supabase-docker/)
./scripts/destroy.sh
./scripts/destroy.sh --yes   # borra también supabase-docker sin preguntar
```
