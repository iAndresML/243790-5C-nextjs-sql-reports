-- ============================================================
-- VIEW 1: view_team_performance
-- Qué devuelve: Estadísticas agregadas por equipo en partidos
-- Grain: 1 fila por equipo
-- Métricas: partidos_jugados, goles_a_favor, goles_en_contra, diferencia_goles, promedio_goles_por_partido
-- Por qué usa GROUP BY: para consolidar estadísticas por equipo
-- VERIFY:
--   SELECT * FROM view_team_performance ORDER BY goles_a_favor DESC;
--   SELECT COUNT(*) FROM view_team_performance;
-- ============================================================
CREATE OR REPLACE VIEW view_team_performance AS
SELECT
    e.id_equipo,
    e.nombre AS equipo,
    COUNT(p.id_partido) AS partidos_jugados,
    SUM(
        CASE 
            WHEN p.id_equipo_local = e.id_equipo THEN p.goles_local
            ELSE p.goles_visitante
        END
    ) AS goles_a_favor,
    SUM(
        CASE 
            WHEN p.id_equipo_local = e.id_equipo THEN p.goles_visitante
            ELSE p.goles_local
        END
    ) AS goles_en_contra,
    SUM(
        CASE 
            WHEN p.id_equipo_local = e.id_equipo THEN p.goles_local - p.goles_visitante
            ELSE p.goles_visitante - p.goles_local
        END
    ) AS diferencia_goles,
    AVG(
        CASE 
            WHEN p.id_equipo_local = e.id_equipo THEN p.goles_local
            ELSE p.goles_visitante
        END
    ) AS promedio_goles_por_partido
FROM equipos e
JOIN partidos p
  ON e.id_equipo IN (p.id_equipo_local, p.id_equipo_visitante)
GROUP BY e.id_equipo, e.nombre
HAVING COUNT(p.id_partido) > 0;


-- ============================================================
-- VIEW 2: view_team_goal_ranking (usa Window Function)
-- Qué devuelve: Ranking de equipos por goles anotados
-- Grain: 1 fila por equipo
-- Métricas: total_goles, ranking_goles
-- Por qué usa GROUP BY: sumar goles por equipo
-- VERIFY:
--   SELECT * FROM view_team_goal_ranking ORDER BY ranking_goles;
--   SELECT MAX(ranking_goles) FROM view_team_goal_ranking;
-- ============================================================
CREATE OR REPLACE VIEW view_team_goal_ranking AS
WITH goles_por_equipo AS (
    SELECT
        e.id_equipo,
        e.nombre AS equipo,
        SUM(
            CASE 
                WHEN p.id_equipo_local = e.id_equipo THEN p.goles_local
                ELSE p.goles_visitante
            END
        ) AS total_goles
    FROM equipos e
    JOIN partidos p
      ON e.id_equipo IN (p.id_equipo_local, p.id_equipo_visitante)
    GROUP BY e.id_equipo, e.nombre
)
SELECT
    id_equipo,
    equipo,
    total_goles,
    RANK() OVER (ORDER BY total_goles DESC) AS ranking_goles
FROM goles_por_equipo;


-- ============================================================
-- VIEW 3: view_stadium_usage
-- Qué devuelve: Uso de estadios y promedio de goles por partido
-- Grain: 1 fila por estadio
-- Métricas: partidos_jugados, promedio_goles_por_partido
-- Por qué usa GROUP BY: consolidar por estadio
-- VERIFY:
--   SELECT * FROM view_stadium_usage ORDER BY partidos_jugados DESC;
--   SELECT COUNT(*) FROM view_stadium_usage;
-- ============================================================
CREATE OR REPLACE VIEW view_stadium_usage AS
SELECT
    s.id_estadio,
    s.nombre AS estadio,
    s.ciudad,
    COUNT(p.id_partido) AS partidos_jugados,
    AVG(p.goles_local + p.goles_visitante) AS promedio_goles_por_partido
FROM estadios s
JOIN partidos p ON p.id_estadio = s.id_estadio
GROUP BY s.id_estadio, s.nombre, s.ciudad
HAVING COUNT(p.id_partido) >= 1;


-- ============================================================
-- VIEW 4: view_players_by_position
-- Qué devuelve: Cantidad de jugadores por equipo y posición
-- Grain: 1 fila por equipo + posición
-- Métricas: total_jugadores
-- Por qué usa GROUP BY: agrupar jugadores por equipo y tipo de posición
-- VERIFY:
--   SELECT * FROM view_players_by_position ORDER BY equipo, total_jugadores DESC;
--   SELECT COUNT(*) FROM view_players_by_position;
-- ============================================================
CREATE OR REPLACE VIEW view_players_by_position AS
SELECT
    e.nombre AS equipo,
    CASE 
        WHEN j.posicion ILIKE '%Delantero%' THEN 'Delantero'
        WHEN j.posicion ILIKE '%Defensa%' THEN 'Defensa'
        WHEN j.posicion ILIKE '%Portero%' THEN 'Portero'
        ELSE 'Centrocampista'
    END AS tipo_posicion,
    COUNT(j.id_jugador) AS total_jugadores
FROM jugadores j
JOIN equipos e ON j.id_equipo = e.id_equipo
GROUP BY e.nombre,
         CASE 
            WHEN j.posicion ILIKE '%Delantero%' THEN 'Delantero'
            WHEN j.posicion ILIKE '%Defensa%' THEN 'Defensa'
            WHEN j.posicion ILIKE '%Portero%' THEN 'Portero'
            ELSE 'Centrocampista'
         END;


-- ============================================================
-- VIEW 5: view_high_scoring_matches_by_phase (usa HAVING)
-- Qué devuelve: Fases con promedio alto de goles por partido
-- Grain: 1 fila por fase
-- Métricas: partidos, promedio_goles
-- Por qué usa GROUP BY/HAVING: agrupar por fase y filtrar fases con partidos más intensos
-- VERIFY:
--   SELECT * FROM view_high_scoring_matches_by_phase;
--   SELECT COUNT(*) FROM view_high_scoring_matches_by_phase;
-- ============================================================
CREATE OR REPLACE VIEW view_high_scoring_matches_by_phase AS
SELECT
    fase,
    COUNT(id_partido) AS partidos,
    AVG(goles_local + goles_visitante) AS promedio_goles
FROM partidos
GROUP BY fase
HAVING AVG(goles_local + goles_visitante) >= 2;
