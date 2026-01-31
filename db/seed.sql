-- ============================================
-- SEED.SQL - Inserción de datos
-- Base de datos: UEFA Champions League
-- Autor: Estudiante 243790 - Grupo 5°C
-- ============================================

-- ============================================
-- INSERTAR ESTADIOS
-- ============================================
INSERT INTO estadios (nombre, ciudad, pais, capacidad) VALUES
('Santiago Bernabéu', 'Madrid', 'España', 81044),
('Camp Nou', 'Barcelona', 'España', 99354),
('Allianz Arena', 'Múnich', 'Alemania', 75024),
('Old Trafford', 'Mánchester', 'Inglaterra', 74879),
('Anfield', 'Liverpool', 'Inglaterra', 53394),
('San Siro', 'Milán', 'Italia', 80018);

-- ============================================
-- INSERTAR EQUIPOS
-- ============================================
INSERT INTO equipos (nombre, pais, id_estadio, fundacion) VALUES
('Real Madrid', 'España', 1, 1902),
('FC Barcelona', 'España', 2, 1899),
('Bayern Múnich', 'Alemania', 3, 1900),
('Manchester United', 'Inglaterra', 4, 1878),
('Liverpool FC', 'Inglaterra', 5, 1892),
('AC Milan', 'Italia', 6, 1899);

-- ============================================
-- INSERTAR JUGADORES
-- ============================================
-- Jugadores del Real Madrid
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Vinícius', 'Júnior', '2000-07-12', 'Delantero', 7, 1),
('Jude', 'Bellingham', '2003-06-29', 'Centrocampista', 5, 1),
('Thibaut', 'Courtois', '1992-05-11', 'Portero', 1, 1),
('Federico', 'Valverde', '1998-07-22', 'Centrocampista', 15, 1),
('Antonio', 'Rüdiger', '1993-03-03', 'Defensa', 22, 1);

-- Jugadores del FC Barcelona
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Robert', 'Lewandowski', '1988-08-21', 'Delantero', 9, 2),
('Marc-André', 'ter Stegen', '1992-04-30', 'Portero', 1, 2),
('Pedri', 'González', '2002-11-25', 'Centrocampista', 8, 2),
('Gavi', 'Páez', '2004-08-05', 'Centrocampista', 6, 2),
('Ronald', 'Araújo', '1999-03-07', 'Defensa', 4, 2);

-- Jugadores del Bayern Múnich
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Harry', 'Kane', '1993-07-28', 'Delantero', 9, 3),
('Manuel', 'Neuer', '1986-03-27', 'Portero', 1, 3),
('Joshua', 'Kimmich', '1995-02-08', 'Centrocampista', 6, 3),
('Alphonso', 'Davies', '2000-11-02', 'Defensa', 19, 3),
('Jamal', 'Musiala', '2003-02-26', 'Centrocampista', 42, 3);

-- Jugadores del Manchester United
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Marcus', 'Rashford', '1997-10-31', 'Delantero', 10, 4),
('Bruno', 'Fernandes', '1994-09-08', 'Centrocampista', 8, 4),
('André', 'Onana', '1996-04-02', 'Portero', 24, 4),
('Lisandro', 'Martínez', '1998-01-18', 'Defensa', 6, 4),
('Casemiro', 'Santos', '1992-02-23', 'Centrocampista', 18, 4);

-- Jugadores del Liverpool FC
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Mohamed', 'Salah', '1992-06-15', 'Delantero', 11, 5),
('Alisson', 'Becker', '1992-10-02', 'Portero', 1, 5),
('Virgil', 'van Dijk', '1991-07-08', 'Defensa', 4, 5),
('Trent', 'Alexander-Arnold', '1998-10-07', 'Defensa', 66, 5),
('Dominik', 'Szoboszlai', '2000-10-25', 'Centrocampista', 8, 5);

-- Jugadores del AC Milan
INSERT INTO jugadores (nombre, apellido, fecha_nacimiento, posicion, numero_camiseta, id_equipo) VALUES
('Rafael', 'Leão', '1999-06-10', 'Delantero', 10, 6),
('Mike', 'Maignan', '1995-07-03', 'Portero', 16, 6),
('Theo', 'Hernández', '1997-10-06', 'Defensa', 19, 6),
('Tijjani', 'Reijnders', '1998-07-29', 'Centrocampista', 14, 6),
('Fikayo', 'Tomori', '1997-12-19', 'Defensa', 23, 6);

-- ============================================
-- INSERTAR PARTIDOS
-- ============================================
INSERT INTO partidos (id_equipo_local, id_equipo_visitante, id_estadio, fecha, goles_local, goles_visitante, fase) VALUES
(1, 2, 1, '2024-10-26', 3, 2, 'Fase de Grupos'),
(3, 4, 3, '2024-10-27', 4, 3, 'Fase de Grupos'),
(5, 6, 5, '2024-10-28', 2, 1, 'Fase de Grupos'),
(2, 3, 2, '2024-11-05', 1, 1, 'Fase de Grupos'),
(4, 5, 4, '2024-11-06', 0, 2, 'Fase de Grupos'),
(6, 1, 6, '2024-11-07', 1, 3, 'Fase de Grupos');