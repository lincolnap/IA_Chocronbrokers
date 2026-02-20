# N8N + Supabase + Redis — Docker Compose

Proyecto para levantar **N8N**, **Supabase** y **Redis** con Docker Compose.

## Servicios incluidos

| Servicio | Descripción | Puerto por defecto |
|----------|-------------|--------------------|
| **N8N** | Automatización de flujos de trabajo | 5678 |
| **PostgreSQL** | Base de datos para N8N | interno (no expuesto) |
| **Redis** | Colas, caché y sesiones (recomendado para N8N en modo queue) | 6379 |
| **Supabase** | BaaS (Auth, DB, Storage, Realtime). Se integra según [supabase/README.md](supabase/README.md) | 8000 (API) |

### Por qué Redis

- **N8N**: modo `queue` con varios workers y mejor escalado.
- **Caché y rate limiting** si añades más servicios.
- **Sesiones** para aplicaciones web.

## Requisitos

- Docker y Docker Compose v2
- (Opcional) Supabase CLI si usas la opción recomendada para Supabase

## Inicio rápido (solo N8N + Redis)

1. Clona o entra en el proyecto y crea el archivo de entorno:
   ```bash
   cp .env.example .env
   ```
2. **Obligatorio:** edita `.env` y asigna una contraseña segura a `N8N_DB_PASSWORD`.
3. Levanta los servicios:
   ```bash
   docker compose up -d
   ```
4. Abre N8N en: **http://localhost:5678**

## Variables de entorno principales

| Variable | Descripción |
|----------|-------------|
| `N8N_DB_PASSWORD` | Contraseña de PostgreSQL de N8N (obligatoria) |
| `N8N_PORT` | Puerto de N8N en el host (por defecto 5678) |
| `N8N_EXECUTIONS_MODE` | `regular` o `queue` (queue usa Redis) |
| `N8N_ENCRYPTION_KEY` | Clave de cifrado (recomendada en producción) |
| `REDIS_PORT` | Puerto de Redis en el host (por defecto 6379) |

Ver [.env.example](.env.example) para el resto.

## Desplegar Supabase

1. Asegúrate de tener **Docker en ejecución** (Docker Desktop o daemon).
2. El archivo **`supabase/.env`** ya está creado con las variables necesarias (secretos por defecto para desarrollo; cámbialos en producción).
3. Ejecuta el script de despliegue:
   ```bash
   ./scripts/deploy-supabase.sh
   ```
   La primera vez clona el stack oficial de Supabase en `supabase-docker/`, copia `supabase/.env` y levanta todos los servicios.
4. Tras el despliegue:
   - **API (Kong):** http://localhost:8000  
   - **PostgreSQL:** localhost:5432  
   - **Pooler:** localhost:6543  

Para más opciones (Supabase CLI, etc.): **[supabase/README.md](supabase/README.md)**.

## Comandos útiles

```bash
# Levantar
docker compose up -d

# Ver logs
docker compose logs -f n8n

# Parar
docker compose down

# Parar y eliminar volúmenes
docker compose down -v
```

## Licencia

Uso libre según los proyectos upstream (N8N, Supabase, Redis).
