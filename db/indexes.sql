-- ============================================
-- INDEXES.SQL
-- Índices para mejorar rendimiento de reportes
-- ============================================

-- Ayuda a joins entre partidos y equipos (local / visitante)
CREATE INDEX idx_partidos_equipo_local
ON partidos(id_equipo_local);

CREATE INDEX idx_partidos_equipo_visitante
ON partidos(id_equipo_visitante);

-- Ayuda a agrupaciones por fase
CREATE INDEX idx_partidos_fase
ON partidos(fase);

-- Ayuda a joins jugadores -> equipos
CREATE INDEX idx_jugadores_equipo
ON jugadores(id_equipo);
