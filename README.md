# Supabase + Caddy

Proyecto Docker para **Supabase** con proxy HTTPS via Caddy.

## Cómo ejecutar

1. **Variables de entorno de Supabase**
   Edita `supabase/.env` con tus valores. Variables clave:
   ```env
   POSTGRES_PASSWORD=...
   JWT_SECRET=...
   ANON_KEY=...
   SERVICE_ROLE_KEY=...
   SUPABASE_PUBLIC_URL=https://supabase2.chocronbrokers.com
   API_EXTERNAL_URL=https://supabase2.chocronbrokers.com
   SITE_URL=https://supabase2.chocronbrokers.com
   ```

2. **Levantar todo**
   ```bash
   ./scripts/start.sh
   ```
   Esto levanta Caddy (proxy HTTPS) y luego Supabase. La primera vez se clona `supabase-docker/` automáticamente.

## URLs

| Servicio              | URL                                        |
|-----------------------|--------------------------------------------|
| **Supabase (HTTPS)**  | https://supabase2.chocronbrokers.com       |
| **Supabase API/Kong** | http://localhost:8000                      |
| **Supabase Studio**   | ver `docker compose ps` en supabase-docker |
| **PostgreSQL**        | localhost:5432                             |
| **Pooler**            | localhost:6543                             |

## Comandos

```bash
# Levantar
./scripts/start.sh

# Solo Supabase
./scripts/deploy-supabase.sh

# Solo Caddy
docker compose up -d

# Parar Caddy
docker compose down

# Parar Supabase
cd supabase-docker && docker compose down

# Destruir todo (contenedores + volúmenes)
./scripts/destroy.sh
./scripts/destroy.sh --yes   # borra también supabase-docker/ sin preguntar

# Ver logs de Supabase
cd supabase-docker && docker compose logs -f
```
