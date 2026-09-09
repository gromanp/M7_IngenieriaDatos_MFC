-- Queries para observar los datos almacenados en las tablas
SELECT * FROM cantera_db.jugadores;
SELECT * FROM cantera_db.partidos;
SELECT * FROM cantera_db.eventos_goles;


-- ¿En qué estadios marca más goles la Academia MFC? 
SELECT p.estadio, COUNT(e.id_evento) as goles
FROM eventos_goles e
JOIN partidos p ON e.id_partido = p.id_partido
JOIN jugadores j ON e.id_jugador = j.id_jugador
WHERE j.equipo = 'ACADEMIA M.F.C'
GROUP BY p.estadio;


-- ¿Cómo es el rendimiento de los equipos del Grupo B, como locales y visitantes?
SELECT 
    j.equipo,
    e.condicion,
    COUNT(e.id_evento) AS total_goles,
    ROUND(AVG(e.minuto), 1) AS minuto_promedio_gol
FROM eventos_goles e
JOIN jugadores j ON e.id_jugador = j.id_jugador
GROUP BY j.equipo, e.condicion
ORDER BY j.equipo, total_goles DESC;


-- ¿En qué momento del partido los equipos son más letales?
WITH Tramos_Master AS (
    SELECT '0-10 min: Inicio' AS tramo, 0 AS limite_inf, 10 AS limite_sup
    UNION ALL SELECT '11-20 min: Mitad 1T', 11, 20
    UNION ALL SELECT '21-30 min: Cierre 1T', 31, 45
    UNION ALL SELECT '31-40 min: Inicio 2T', 46, 60
    UNION ALL SELECT '61-75 min: Mitad 2T', 61, 75
    UNION ALL SELECT '76+ min: Cierre Partido', 76, 200 -- Para cubrir tiempos de descuento
)
SELECT 
    tm.tramo AS tramo_partido,
    COUNT(e.id_evento) AS cantidad_goles
FROM Tramos_Master tm
LEFT JOIN eventos_goles e ON e.minuto BETWEEN tm.limite_inf AND tm.limite_sup
GROUP BY tm.tramo, tm.limite_inf
ORDER BY tm.limite_inf;


-- ¿Qué jugadores anotaron en partidos que terminaron en victoria o empate?
SELECT 
    jug.nombre_completo,
    jug.equipo,
    COUNT(e.id_evento) AS goles_clave
FROM eventos_goles e
JOIN jugadores jug ON e.id_jugador = jug.id_jugador
JOIN partidos p ON e.id_partido = p.id_partido
WHERE (p.goles_local > p.goles_visitante AND jug.equipo = p.equipo_local)
   OR (p.goles_visitante > p.goles_local AND jug.equipo = p.equipo_visitante)
   OR (p.goles_local = p.goles_visitante)
GROUP BY jug.id_jugador
ORDER BY goles_clave DESC
LIMIT 10;