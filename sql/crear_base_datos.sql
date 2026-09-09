CREATE DATABASE IF NOT EXISTS cantera_db;
USE cantera_db;

-- CREACION DE TABLA DE JUGADORES
CREATE TABLE jugadores (
    id_jugador INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL UNIQUE,
    equipo VARCHAR(100) NOT NULL
);

-- CREACION DE TABLA DE PARTIDOS
CREATE TABLE partidos (
    id_partido INT AUTO_INCREMENT PRIMARY KEY,
    jornada INT,
    fecha_hora DATETIME,
    estadio VARCHAR(150),
    equipo_local VARCHAR(100),
    equipo_visitante VARCHAR(100),
    goles_local INT,
    goles_visitante INT,
    -- Llave única para evitar duplicar el mismo encuentro
    UNIQUE KEY partido_unico (fecha_hora, equipo_local, equipo_visitante)
);

-- CREACION DE TABLA DE EVENTOS_GOLES
CREATE TABLE eventos_goles (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    id_jugador INT NOT NULL, -- Relacion con Tabla JUGADORES
    id_partido INT NOT NULL, -- Relacion con Tabla PARTIDOS
    minuto INT,
    tipo_gol VARCHAR(50),
    condicion VARCHAR(50),
    FOREIGN KEY (id_jugador) REFERENCES jugadores(id_jugador),
    FOREIGN KEY (id_partido) REFERENCES partidos(id_partido)
);