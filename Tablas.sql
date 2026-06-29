-- ==========================================================
-- CREACIÓN DE TABLAS DEL DATA WAREHOUSE
-- Proyecto: Análisis de la Criminalidad en Colombia
-- Esquema: Modelo Estrella
-- ==========================================================

-- ==========================================================
-- DIMENSIÓN TIEMPO
-- ==========================================================

CREATE TABLE dim_tiempo (
    id_tiempo SERIAL PRIMARY KEY,
    fecha DATE NOT NULL UNIQUE,
    dia SMALLINT NOT NULL,
    mes SMALLINT NOT NULL,
    nombre_mes VARCHAR(20) NOT NULL,
    trimestre SMALLINT NOT NULL,
    anio SMALLINT NOT NULL,
    dia_semana SMALLINT NOT NULL,
    nombre_dia VARCHAR(15) NOT NULL,
    es_fin_semana BOOLEAN NOT NULL
);

-- ==========================================================
-- DIMENSIÓN UBICACIÓN
-- ==========================================================

CREATE TABLE dim_ubicacion (
    id_ubicacion SERIAL PRIMARY KEY,
    departamento VARCHAR(100) NOT NULL,
    municipio VARCHAR(100) NOT NULL,

    CONSTRAINT uq_departamento_municipio
        UNIQUE (departamento, municipio)
);

-- ==========================================================
-- DIMENSIÓN DELITO
-- ==========================================================

CREATE TABLE dim_delito (
    id_delito SERIAL PRIMARY KEY,
    tipo_delito VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================================
-- DIMENSIÓN ARMA
-- ==========================================================

CREATE TABLE dim_arma (
    id_arma SERIAL PRIMARY KEY,
    nombre_arma VARCHAR(100) NOT NULL UNIQUE
);

-- ==========================================================
-- DIMENSIÓN VÍCTIMA
-- ==========================================================

CREATE TABLE dim_victima (
    id_victima SERIAL PRIMARY KEY,
    genero VARCHAR(20) NOT NULL,
    grupo_etario VARCHAR(50) NOT NULL,

    CONSTRAINT uq_victima
        UNIQUE (genero, grupo_etario)
);

-- ==========================================================
-- TABLA DE HECHOS
-- ==========================================================

CREATE TABLE fact_delitos (

    id_fact_delito BIGSERIAL PRIMARY KEY,

    id_tiempo INT NOT NULL,
    id_ubicacion INT NOT NULL,
    id_delito INT NOT NULL,
    id_victima INT NOT NULL,
    id_arma INT NOT NULL,

    cantidad_delitos INT NOT NULL DEFAULT 1,

    CONSTRAINT fk_fact_tiempo
        FOREIGN KEY (id_tiempo)
        REFERENCES dim_tiempo(id_tiempo),

    CONSTRAINT fk_fact_ubicacion
        FOREIGN KEY (id_ubicacion)
        REFERENCES dim_ubicacion(id_ubicacion),

    CONSTRAINT fk_fact_delito
        FOREIGN KEY (id_delito)
        REFERENCES dim_delito(id_delito),

    CONSTRAINT fk_fact_victima
        FOREIGN KEY (id_victima)
        REFERENCES dim_victima(id_victima),

    CONSTRAINT fk_fact_arma
        FOREIGN KEY (id_arma)
        REFERENCES dim_arma(id_arma)
);