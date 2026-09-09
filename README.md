# Sistema de Analítica de Datos - Academia MFC

Este proyecto forma parte de la infraestructura de datos para el análisis del **Torneo Apertura 2025 (Grupo B)**. Su objetivo es transformar reportes administrativos dispersos en una base de datos relacional robusta para la toma de decisiones técnicas.


## 🚀 Arquitectura del Proyecto

El sistema sigue un flujo de **ETL (Extracción, Transformación y Carga)**:
1. **Extracción:** Captura de datos desde actas arbitrales (PDF) y reportes de liga (CSV).
2. **Transformación:** Limpieza de strings, normalización de resultados y manejo de valores nulos con Python/Pandas.
3. **Carga:** Inserción de datos en un modelo relacional MySQL (Esquema en Estrella).
4. **Visualizaciones:** Gráficos que proporcionan insights valiosos, para entrenadores y directivos.


## 📊 Modelo de Datos
El proyecto implementa tres entidades principales interconectadas:
- **Dimension Jugadores:** Catálogo maestro de atletas.
- **Dimension Partidos:** Contexto temporal y espacial de los encuentros.
- **Tabla de Hechos (Eventos Goles):** Registro atómico de cada anotación vinculado a jugador y partido.


## 🛠️ Instalación y Configuración

### Requisitos Previos
- Python 3.8+
- MySQL Server 8.0+
