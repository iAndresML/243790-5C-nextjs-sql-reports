-- ============================================
-- SCHEMA.SQL - Creación de tablas
-- Base de datos: UEFA Champions League
-- Autor: Estudiante 243790 - Grupo 5°C
-- ============================================

-- Eliminamos las tablas si ya existen (para poder correr el script varias veces)
DROP TABLE IF EXISTS partidos CASCADE;
DROP TABLE IF EXISTS jugadores CASCADE;
DROP TABLE IF EXISTS equipos CASCADE;
DROP TABLE IF EXISTS estadios CASCADE;

-- ============================================
-- TABLA 1: ESTADIOS
-- Aquí guardamos información de los estadios
-- ============================================
CREATE TABLE estadios (
    id_estadio SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL CHECK (capacidad > 0)
);

-- ============================================
-- TABLA 2: EQUIPOS
-- Aquí guardamos los equipos que participan
-- ============================================
CREATE TABLE equipos (
    id_equipo SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    pais VARCHAR(100) NOT NULL,
    id_estadio INT NOT NULL,
    fundacion INT CHECK (fundacion > 1800 AND fundacion <= 2025),
    FOREIGN KEY (id_estadio) REFERENCES estadios(id_estadio) ON DELETE RESTRICT
);

-- ============================================
-- TABLA 3: JUGADORES
-- Aquí guardamos los jugadores de cada equipo
-- ============================================
CREATE TABLE jugadores (
    id_jugador SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    posicion VARCHAR(50) NOT NULL,
    numero_camiseta INT CHECK (numero_camiseta > 0 AND numero_camiseta <= 99),
    id_equipo INT NOT NULL,
    FOREIGN KEY (id_equipo) REFERENCES equipos(id_equipo) ON DELETE CASCADE
);

-- ============================================
-- TABLA 4: PARTIDOS
-- Aquí guardamos los partidos jugados
-- ============================================
CREATE TABLE partidos (
    id_partido SERIAL PRIMARY KEY,
    id_equipo_local INT NOT NULL,
    id_equipo_visitante INT NOT NULL,
    id_estadio INT NOT NULL,
    fecha DATE NOT NULL,
    goles_local INT DEFAULT 0 CHECK (goles_local >= 0),
    goles_visitante INT DEFAULT 0 CHECK (goles_visitante >= 0),
    fase VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_equipo_local) REFERENCES equipos(id_equipo) ON DELETE RESTRICT,
    FOREIGN KEY (id_equipo_visitante) REFERENCES equipos(id_equipo) ON DELETE RESTRICT,
    FOREIGN KEY (id_estadio) REFERENCES estadios(id_estadio) ON DELETE RESTRICT,
    CHECK (id_equipo_local != id_equipo_visitante)
);