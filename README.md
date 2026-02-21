# N8N + Supabase

Proyecto Docker para **N8N** y **Supabase** (más Redis y PostgreSQL para N8N).

## Cómo ejecutar

1. **Variables de entorno**  
   Crea o edita `.env` en la raíz del proyecto (Docker Compose lo usa para N8N y Caddy). Mínimo necesario:
   ```env
   N8N_DB_PASSWORD=tu_password_seguro
   N8N_WEBHOOK_URL=https://n8n.iarealtor/
   N8N_HOST=n8n.iarealtor
   ```
   Opcionales: `N8N_PORT`, `N8N_TIMEZONE`, `N8N_EXECUTIONS_MODE`, `N8N_DB_NAME`, `N8N_DB_USER`, `REDIS_PORT`, `HTTPS_PORT`.

2. **Levantar todo (N8N + Supabase)**
   ```bash
   ./scripts/start.sh
   ```
   O por separado: `docker compose up -d` (N8N) y `./scripts/deploy-supabase.sh` (Supabase). La primera vez Supabase se clona en `supabase-docker/`. Variables de Supabase en `supabase/.env`.

## Probar HTTPS

1. Levanta el stack: `./scripts/start.sh` (o `docker compose up -d` y luego `./scripts/deploy-supabase.sh`).
2. En el navegador:
   - **N8N:** https://n8n.iarealtor (acepta el certificado auto-firmado si el navegador lo pide).
   - **Supabase (Studio/API):** https://supabase.iarealtor (mismo certificado).
3. Si ya tenías Supabase levantado, copia de nuevo el `.env` y reinicia para que use las URLs HTTPS:
   ```bash
   cp supabase/.env supabase-docker/.env && cd supabase-docker && docker compose up -d --force-recreate
   ```

## URLs

| Servicio   | HTTP | HTTPS |
|-----------|------|--------|
| **N8N**   | http://localhost:5678 | **https://n8n.iarealtor** |
| **Supabase** | http://localhost:8000 | **https://supabase.iarealtor** |
| **PostgreSQL (Supabase)** | localhost:5432 | — |
| **Redis** | localhost:6379 | — |

HTTPS usa Caddy con certificado auto-firmado (el navegador pedirá aceptar una vez). En `.env`: `N8N_WEBHOOK_URL=https://n8n.iarealtor/` y `N8N_HOST=n8n.iarealtor`.

**Dominios `*.iarealtor`:** para que el navegador resuelva los nombres, añade en `/etc/hosts` (Mac/Linux) o `C:\Windows\System32\drivers\etc\hosts` (Windows):
```
127.0.0.1 n8n.iarealtor supabase.iarealtor
```

**Supabase:** en `supabase/.env` están `SUPABASE_PUBLIC_URL`, `API_EXTERNAL_URL` y `SITE_URL` con `https://supabase.iarealtor`.

Desde N8N (contenedor) usa `https://supabase.iarealtor` o `https://host.docker.internal` para llamar a la API de Supabase.

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
