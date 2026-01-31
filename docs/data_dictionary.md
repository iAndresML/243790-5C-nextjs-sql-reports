# 📖 Diccionario de Datos - UEFA Champions League

**Autor:** Estudiante 243790 - Grupo 5°C  
**Fecha:** Enero 2026  
**Base de datos:** champions_league

---

## 📋 Tabla: estadios

Almacena información sobre los estadios donde se juegan los partidos.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_estadio | SERIAL | PRIMARY KEY | Identificador único del estadio |
| nombre | VARCHAR(100) | NOT NULL | Nombre del estadio |
| ciudad | VARCHAR(100) | NOT NULL | Ciudad donde se ubica |
| pais | VARCHAR(100) | NOT NULL | País donde se ubica |
| capacidad | INT | NOT NULL, CHECK > 0 | Cantidad de espectadores que puede albergar |

**Ejemplo de registro:**
```
id_estadio: 1
nombre: Santiago Bernabéu
ciudad: Madrid
pais: España
capacidad: 81044
```

---

## 📋 Tabla: equipos

Almacena información sobre los equipos que participan en la Champions League.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_equipo | SERIAL | PRIMARY KEY | Identificador único del equipo |
| nombre | VARCHAR(100) | NOT NULL, UNIQUE | Nombre del equipo |
| pais | VARCHAR(100) | NOT NULL | País de origen del equipo |
| id_estadio | INT | NOT NULL, FK → estadios | Estadio donde juega de local |
| fundacion | INT | CHECK (1800-2025) | Año de fundación del club |

**Relaciones:**
- `id_estadio` → Referencia a `estadios(id_estadio)` con `ON DELETE RESTRICT`

**Ejemplo de registro:**
```
id_equipo: 1
nombre: Real Madrid
pais: España
id_estadio: 1
fundacion: 1902
```

---

## 📋 Tabla: jugadores

Almacena información sobre los jugadores de cada equipo.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_jugador | SERIAL | PRIMARY KEY | Identificador único del jugador |
| nombre | VARCHAR(100) | NOT NULL | Nombre del jugador |
| apellido | VARCHAR(100) | NOT NULL | Apellido del jugador |
| fecha_nacimiento | DATE | NOT NULL | Fecha de nacimiento |
| posicion | VARCHAR(50) | NOT NULL | Posición en la que juega |
| numero_camiseta | INT | CHECK (1-99) | Número de camiseta |
| id_equipo | INT | NOT NULL, FK → equipos | Equipo al que pertenece |

**Relaciones:**
- `id_equipo` → Referencia a `equipos(id_equipo)` con `ON DELETE CASCADE`

**Ejemplo de registro:**
```
id_jugador: 1
nombre: Vinícius
apellido: Júnior
fecha_nacimiento: 2000-07-12
posicion: Delantero
numero_camiseta: 7
id_equipo: 1
```

---

## 📋 Tabla: partidos

Almacena información sobre los partidos jugados.

| Campo | Tipo | Restricciones | Descripción |
|-------|------|---------------|-------------|
| id_partido | SERIAL | PRIMARY KEY | Identificador único del partido |
| id_equipo_local | INT | NOT NULL, FK → equipos | Equipo que juega de local |
| id_equipo_visitante | INT | NOT NULL, FK → equipos | Equipo que juega de visitante |
| id_estadio | INT | NOT NULL, FK → estadios | Estadio donde se juega |
| fecha | DATE | NOT NULL | Fecha del partido |
| goles_local | INT | DEFAULT 0, CHECK >= 0 | Goles del equipo local |
| goles_visitante | INT | DEFAULT 0, CHECK >= 0 | Goles del equipo visitante |
| fase | VARCHAR(50) | NOT NULL | Fase del torneo |

**Relaciones:**
- `id_equipo_local` → Referencia a `equipos(id_equipo)` con `ON DELETE RESTRICT`
- `id_equipo_visitante` → Referencia a `equipos(id_equipo)` con `ON DELETE RESTRICT`
- `id_estadio` → Referencia a `estadios(id_estadio)` con `ON DELETE RESTRICT`

**Restricciones adicionales:**
- `CHECK (id_equipo_local != id_equipo_visitante)` → Un equipo no puede jugar contra sí mismo

**Ejemplo de registro:**
```
id_partido: 1
id_equipo_local: 1 (Real Madrid)
id_equipo_visitante: 2 (FC Barcelona)
id_estadio: 1 (Santiago Bernabéu)
fecha: 2024-10-26
goles_local: 3
goles_visitante: 2
fase: Fase de Grupos
```

---

## 🔗 Diagrama de Relaciones
```
estadios (1) ----< (N) equipos (1) ----< (N) jugadores
    |                    |
    |                    |
    +--------------------+
             |
             v
          partidos
```

- Un estadio puede tener varios equipos
- Un equipo tiene varios jugadores
- Un partido se juega en un estadio
- Un partido involucra dos equipos (local y visitante)