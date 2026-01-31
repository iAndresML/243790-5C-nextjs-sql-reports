# ⚽ Base de Datos UEFA Champions League

**Proyecto:** Actividad Grupal - Bases de Datos  
**Matrícula:** 243790  
**Grupo:** 5° C  
**Carrera:** ITIID  
**Tema:** UEFA Champions League

---

## 📖 Descripción del Proyecto

Este proyecto consiste en el diseño e implementación de una base de datos relacional para gestionar información de la UEFA Champions League, incluyendo equipos, estadios, jugadores y partidos.

La base de datos fue desarrollada en **PostgreSQL** y se ejecuta en un contenedor **Docker** para facilitar su portabilidad y configuración.

---

## 🗂️ Estructura del Proyecto
```
.
├── db/
│   ├── schema.sql       # Creación de tablas
│   ├── seed.sql         # Inserción de datos
│   └── verify.sql       # Consultas de verificación
├── docs/
│   └── data_dictionary.md  # Diccionario de datos
├── docker-compose.yml   # Configuración de Docker
└── README.md           # Este archivo
```

---

## 🚀 Instrucciones de Uso

### **Paso 1: Levantar el contenedor de Docker**

Abre una terminal en la carpeta del proyecto y ejecuta:
```bash
docker-compose up -d
```

Esto creará y ejecutará el contenedor con PostgreSQL.

### **Paso 2: Verificar que el contenedor esté corriendo**
```bash
docker ps
```

Deberías ver un contenedor llamado `champions_league_db` con estado `Up`.

### **Paso 3: Conectarse a PostgreSQL**
```bash
docker exec -it champions_league_db psql -U admin -d champions_league
```

### **Paso 4: Verificar las tablas creadas**

Dentro de `psql`, ejecuta:
```sql
\dt
```

Deberías ver las tablas: `estadios`, `equipos`, `jugadores`, `partidos`.

### **Paso 5: Ejecutar el script de verificación**

Dentro de `psql`:
```sql
\i /docker-entrypoint-initdb.d/verify.sql
```

O desde la terminal:
```bash
docker exec -it champions_league_db psql -U admin -d champions_league -f /docker-entrypoint-initdb.d/verify.sql
```

---

## 📊 Modelo de Datos

### Tablas principales:

1. **estadios** - Información de los estadios
2. **equipos** - Equipos participantes
3. **jugadores** - Jugadores de cada equipo
4. **partidos** - Partidos jugados

### Relaciones:

- Un **estadio** puede albergar varios **equipos** (1:N)
- Un **equipo** tiene varios **jugadores** (1:N)
- Un **partido** se juega en un **estadio** (N:1)
- Un **partido** involucra dos **equipos** (N:1 para local y visitante)

---

## 🛠️ Tecnologías Utilizadas

- **PostgreSQL 15** - Sistema de gestión de bases de datos
- **Docker** - Contenedorización
- **Docker Compose** - Orquestación de contenedores

---

## 👤 Autor

**Matrícula:** 243790  
**Grupo:** 5° C  
**Carrera:** Ingeniería en Tecnologías de la Información y Desarrollo (ITIID)

---

## 📝 Notas

- Los scripts SQL están documentados y organizados de forma didáctica
- Se implementaron restricciones de integridad referencial (FK, CHECK)
- Los datos son coherentes con equipos reales de la Champions League
- El proyecto cumple con las buenas prácticas de modelado de bases de datos