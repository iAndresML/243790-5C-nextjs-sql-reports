
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
