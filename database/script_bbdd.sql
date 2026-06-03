-- PostgreSQL database dump - Melodías Mágicas
-- Versión compatible universal (ANSI SQL)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- 1. ESTRUCTURA DE LA TABLA: USUARIOS
CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    usuario_correo character varying(150) NOT NULL,
    usuario_clave character varying(255) NOT NULL,
    usuario_rol integer DEFAULT 2,
    usuario_estado_activo boolean DEFAULT true
);

CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;
ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);

-- 2. ESTRUCTURA DE LA TABLA: PERFILES_HIJOS
CREATE TABLE public.perfiles_hijos (
    hijo_id integer NOT NULL,
    usuario_id_padre integer NOT NULL,
    hijo_nombre character varying(50) NOT NULL,
    hijo_fecha_nacimiento date NOT NULL,
    hijo_numero_avatar integer NOT NULL,
    hijo_instrumento_favorito integer
);

CREATE SEQUENCE public.perfiles_hijos_hijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.perfiles_hijos_hijo_id_seq OWNED BY public.perfiles_hijos.hijo_id;
ALTER TABLE ONLY public.perfiles_hijos ALTER COLUMN hijo_id SET DEFAULT nextval('public.perfiles_hijos_hijo_id_seq'::regclass);

-- 3. ESTRUCTURA DE LA TABLA: BITACORA_ACCESOS
CREATE TABLE public.bitacora_accesos (
    bitacora_id integer NOT NULL,
    usuario_id integer NOT NULL,
    bitacora_fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

CREATE SEQUENCE public.bitacora_accesos_bitacora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.bitacora_accesos_bitacora_id_seq OWNED BY public.bitacora_accesos.bitacora_id;
ALTER TABLE ONLY public.bitacora_accesos ALTER COLUMN bitacora_id SET DEFAULT nextval('public.bitacora_accesos_bitacora_id_seq'::regclass);

-- 4. RESTRICCIONES DE LLAVES PRIMARIAS Y ÚNICAS (CONSTRAINTS)
ALTER TABLE ONLY public.usuarios ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);
ALTER TABLE ONLY public.usuarios ADD CONSTRAINT usuarios_usuario_correo_key UNIQUE (usuario_correo);
ALTER TABLE ONLY public.perfiles_hijos ADD CONSTRAINT perfiles_hijos_pkey PRIMARY KEY (hijo_id);
ALTER TABLE ONLY public.bitacora_accesos ADD CONSTRAINT bitacora_accesos_pkey PRIMARY KEY (bitacora_id);

-- 5. RESTRICCIONES DE LLAVES FORÁNEAS (RELACIONES CON ON DELETE CASCADE)
ALTER TABLE ONLY public.perfiles_hijos 
    ADD CONSTRAINT fk_usuario_padre FOREIGN KEY (usuario_id_padre) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;

ALTER TABLE ONLY public.bitacora_accesos 
    ADD CONSTRAINT fk_usuario_bitacora FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;

-- 6. INSERCIÓN DE DATOS INICIALES (SEMILLAS DE PRUEBA)
INSERT INTO public.usuarios (usuario_id, usuario_correo, usuario_clave, usuario_rol, usuario_estado_activo) VALUES
(1, 'admin@correo.com', '123', 1, true),
(2, 'padre@correo.com', '456', 2, true);

INSERT INTO public.perfiles_hijos (hijo_id, usuario_id_padre, hijo_nombre, hijo_fecha_nacimiento, hijo_numero_avatar, hijo_instrumento_favorito) VALUES
(1, 2, 'hijo', '2021-07-21', 1, 2);

-- Sincronizar los contadores de las secuencias
SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 2, true);
SELECT pg_catalog.setval('public.perfiles_hijos_hijo_id_seq', 1, true);
SELECT pg_catalog.setval('public.bitacora_accesos_bitacora_id_seq', 1, false);