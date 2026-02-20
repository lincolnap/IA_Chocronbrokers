# Integración de Supabase con este proyecto

Supabase se ejecuta con su **stack oficial de Docker**. Para tener N8N y Supabase en la misma red y manejarlos desde este repo, sigue estos pasos.

## Opción A: Supabase con el CLI (recomendado para desarrollo)

1. Instala [Supabase CLI](https://supabase.com/docs/guides/cli):
   ```bash
   brew install supabase/tap/supabase
   ```
2. Inicializa y arranca Supabase (usa Docker por debajo):
   ```bash
   supabase init
   supabase start
   ```
3. La API de Supabase quedará en `http://localhost:54321` (Kong en 8000 por defecto puede variar). Para que N8N pueda llamar a Supabase desde los contenedores, usa la URL que te indique `supabase status` (por ejemplo `http://host.docker.internal:54321` si N8N corre en Docker).

## Opción B: Docker Compose oficial de Supabase (misma red que N8N)

1. Clona el repositorio oficial de Supabase (solo la carpeta docker):
   ```bash
   git clone --depth 1 --filter=blob:none --sparse https://github.com/supabase/supabase
   cd supabase && git sparse-checkout set docker
   ```
2. Copia los archivos de Docker al directorio `supabase` de este proyecto:
   ```bash
   cp -r docker/* ./supabase-docker
   ```
   (Desde la raíz del repo N8N, crea `supabase-docker` y copia ahí el contenido de `supabase/docker`.)
3. Configura las variables de entorno de Supabase:
   ```bash
   cp supabase-docker/.env.example supabase-docker/.env
   # Edita supabase-docker/.env y cambia POSTGRES_PASSWORD, JWT_SECRET, etc.
   ```
4. En la raíz de este proyecto, levanta todo (N8N + Redis + Supabase) usando ambos composes y la misma red:
   ```bash
   docker compose -f docker-compose.yml -f supabase-docker/docker-compose.yml --project-name n8n-stack up -d
   ```
   Para que Supabase use la red `app_network`, añade en `supabase-docker/docker-compose.yml` bajo cada servicio que necesite hablar con N8N:
   `networks: [app_network]` y al final:
   `networks: app_network: external: true`.
   Crea la red antes: `docker network create n8n-stack_app_network` (o la que genere tu compose).

## URLs típicas (Supabase)

- **API (Kong):** `http://localhost:8000`
- **Studio:** según el compose (puerto del servicio `studio`)
- **PostgreSQL:** puerto 5432 (Supavisor) o 6543 (pooler)

Configura en N8N la URL de la API de Supabase según cómo la expongas (localhost o `host.docker.internal`).
