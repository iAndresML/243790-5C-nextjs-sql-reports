-- ============================================
-- VERIFY.SQL - Verificación de datos
-- Base de datos: UEFA Champions League
-- Autor: Estudiante 243790 - Grupo 5°C
-- ============================================

-- Verificar cantidad de registros en cada tabla
SELECT 'Estadios' AS tabla, COUNT(*) AS total FROM estadios
UNION ALL
SELECT 'Equipos', COUNT(*) FROM equipos
UNION ALL
SELECT 'Jugadores', COUNT(*) FROM jugadores
UNION ALL
SELECT 'Partidos', COUNT(*) FROM partidos;

-- Ver todos los estadios
SELECT * FROM estadios ORDER BY capacidad DESC;

-- Ver equipos con su estadio
SELECT 
    e.nombre AS equipo,
    e.pais,
    est.nombre AS estadio,
    est.ciudad
FROM equipos e
JOIN estadios est ON e.id_estadio = est.id_estadio
ORDER BY e.nombre;

-- Ver jugadores con su equipo
SELECT 
    j.nombre || ' ' || j.apellido AS jugador,
    j.posicion,
    j.numero_camiseta AS numero,
    e.nombre AS equipo
FROM jugadores j
JOIN equipos e ON j.id_equipo = e.id_equipo
ORDER BY e.nombre, j.numero_camiseta;

-- Ver partidos con nombres de equipos
SELECT 
    p.fecha,
    el.nombre AS equipo_local,
    p.goles_local,
    p.goles_visitante,
    ev.nombre AS equipo_visitante,
    p.fase,
    est.nombre AS estadio
FROM partidos p
JOIN equipos el ON p.id_equipo_local = el.id_equipo
JOIN equipos ev ON p.id_equipo_visitante = ev.id_equipo
JOIN estadios est ON p.id_estadio = est.id_estadio
ORDER BY p.fecha;

-- Verificar integridad referencial
-- (Esta consulta muestra que NO existen jugadores sin equipo)
SELECT 
    'Jugadores sin equipo' AS verificacion,
    COUNT(*) AS total
FROM jugadores j
LEFT JOIN equipos e ON j.id_equipo = e.id_equipo
WHERE e.id_equipo IS NULL;