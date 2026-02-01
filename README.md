# Lab Reportes: Next.js + PostgreSQL (UEFA Champions League)

**Proyecto:** Lab Reportes – Next.js Reports Dashboard  
**Matrícula:** 243790  
**Grupo:** 5° C  
**Carrera:** Ingeniería en Tecnologías de la Información y Desarrollo (ITIID)  
**Tema:** UEFA Champions League

---

## Descripción del proyecto

Este proyecto implementa un dashboard de reportes construido con Next.js que consume VIEWS analíticas desde PostgreSQL.  
La aplicación completa se ejecuta mediante Docker Compose y permite visualizar métricas relacionadas con equipos, jugadores, estadios y partidos de la UEFA Champions League.

La lógica de análisis se concentra en la base de datos mediante VIEWS, mientras que el frontend únicamente realiza consultas SELECT.  
Esto separa claramente responsabilidades entre la capa de datos y la interfaz.

---

## Objetivos

Demostrar el uso de:

- VIEWS con funciones agregadas (SUM, COUNT, AVG)
- GROUP BY y HAVING
- Campos calculados con CASE
- CTE y Window Functions
- Filtros con validación usando Zod
- Queries parametrizadas
- Paginación server-side
- Índices para optimización
- Roles con permisos mínimos
- Integración segura entre Next.js y PostgreSQL
- Orquestación completa con Docker Compose

---

## Estructura del proyecto

├── db/
│ ├── 01_schema.sql
│ ├── 02_seed.sql
│ ├── 03_reports_vw.sql
│ ├── 04_verify.sql
│ ├── indexes.sql
│ └── roles.sql
├── web/
│ └── src/app/reports
├── docker-compose.yml
└── README.md

 ---

 
Los scripts SQL usan prefijos numéricos para asegurar el orden correcto de ejecución al inicializar el contenedor.

---

## Reportes implementados

- Reporte 1: Rendimiento general por equipo
- Reporte 2: Partidos por fase (con filtros validados mediante Zod y queries parametrizadas)
- Reporte 3: Uso de estadios
- Reporte 4: Jugadores agrupados por posición
- Reporte 5: Ranking de goles con paginación server-side

Incluye un dashboard en `/reports` con enlaces a cada reporte.

---

## Ejecución del proyecto

Levantar todo con un solo comando:

```bash
docker compose up --build
