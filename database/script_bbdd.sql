--
-- PostgreSQL database dump
--

\restrict vorctdzsGmFsfgmdMyKR4mSL5MLrz61RshS2Nwnr5OUHhXXAkg9Ogfl2cjJsjeP

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-06-02 23:07:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 5040 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16945)
-- Name: bitacora_accesos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bitacora_accesos (
    bitacora_id integer NOT NULL,
    usuario_id integer NOT NULL,
    bitacora_fecha_hora timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.bitacora_accesos OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16944)
-- Name: bitacora_accesos_bitacora_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bitacora_accesos_bitacora_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bitacora_accesos_bitacora_id_seq OWNER TO postgres;

--
-- TOC entry 5041 (class 0 OID 0)
-- Dependencies: 223
-- Name: bitacora_accesos_bitacora_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bitacora_accesos_bitacora_id_seq OWNED BY public.bitacora_accesos.bitacora_id;


--
-- TOC entry 222 (class 1259 OID 16928)
-- Name: perfiles_hijos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perfiles_hijos (
    hijo_id integer NOT NULL,
    usuario_id_padre integer NOT NULL,
    hijo_nombre character varying(50) NOT NULL,
    hijo_fecha_nacimiento date NOT NULL,
    hijo_numero_avatar integer NOT NULL,
    hijo_instrumento_favorito integer
);


ALTER TABLE public.perfiles_hijos OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16927)
-- Name: perfiles_hijos_hijo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perfiles_hijos_hijo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perfiles_hijos_hijo_id_seq OWNER TO postgres;

--
-- TOC entry 5042 (class 0 OID 0)
-- Dependencies: 221
-- Name: perfiles_hijos_hijo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perfiles_hijos_hijo_id_seq OWNED BY public.perfiles_hijos.hijo_id;


--
-- TOC entry 220 (class 1259 OID 16914)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    usuario_id integer NOT NULL,
    usuario_correo character varying(150) NOT NULL,
    usuario_clave character varying(255) NOT NULL,
    usuario_rol integer DEFAULT 2,
    usuario_estado_activo boolean DEFAULT true
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16913)
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_usuario_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 5043 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_usuario_id_seq OWNED BY public.usuarios.usuario_id;


--
-- TOC entry 4870 (class 2604 OID 16948)
-- Name: bitacora_accesos bitacora_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_accesos ALTER COLUMN bitacora_id SET DEFAULT nextval('public.bitacora_accesos_bitacora_id_seq'::regclass);


--
-- TOC entry 4869 (class 2604 OID 16931)
-- Name: perfiles_hijos hijo_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfiles_hijos ALTER COLUMN hijo_id SET DEFAULT nextval('public.perfiles_hijos_hijo_id_seq'::regclass);


--
-- TOC entry 4866 (class 2604 OID 16917)
-- Name: usuarios usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('public.usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 5034 (class 0 OID 16945)
-- Dependencies: 224
-- Data for Name: bitacora_accesos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bitacora_accesos (bitacora_id, usuario_id, bitacora_fecha_hora) FROM stdin;
\.


--
-- TOC entry 5032 (class 0 OID 16928)
-- Dependencies: 222
-- Data for Name: perfiles_hijos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perfiles_hijos (hijo_id, usuario_id_padre, hijo_nombre, hijo_fecha_nacimiento, hijo_numero_avatar, hijo_instrumento_favorito) FROM stdin;
1	2	hijo	2021-07-21	1	2
\.


--
-- TOC entry 5030 (class 0 OID 16914)
-- Dependencies: 220
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (usuario_id, usuario_correo, usuario_clave, usuario_rol, usuario_estado_activo) FROM stdin;
1	admin@correo.com	123	1	t
2	padre@correo.com	456	2	t
\.


--
-- TOC entry 5044 (class 0 OID 0)
-- Dependencies: 223
-- Name: bitacora_accesos_bitacora_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bitacora_accesos_bitacora_id_seq', 1, false);


--
-- TOC entry 5045 (class 0 OID 0)
-- Dependencies: 221
-- Name: perfiles_hijos_hijo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perfiles_hijos_hijo_id_seq', 1, true);


--
-- TOC entry 5046 (class 0 OID 0)
-- Dependencies: 219
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_usuario_id_seq', 2, true);


--
-- TOC entry 4879 (class 2606 OID 16953)
-- Name: bitacora_accesos bitacora_accesos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_accesos
    ADD CONSTRAINT bitacora_accesos_pkey PRIMARY KEY (bitacora_id);


--
-- TOC entry 4877 (class 2606 OID 16938)
-- Name: perfiles_hijos perfiles_hijos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfiles_hijos
    ADD CONSTRAINT perfiles_hijos_pkey PRIMARY KEY (hijo_id);


--
-- TOC entry 4873 (class 2606 OID 16924)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 4875 (class 2606 OID 16926)
-- Name: usuarios usuarios_usuario_correo_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_usuario_correo_key UNIQUE (usuario_correo);


--
-- TOC entry 4881 (class 2606 OID 16954)
-- Name: bitacora_accesos fk_usuario_bitacora; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bitacora_accesos
    ADD CONSTRAINT fk_usuario_bitacora FOREIGN KEY (usuario_id) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;


--
-- TOC entry 4880 (class 2606 OID 16939)
-- Name: perfiles_hijos fk_usuario_padre; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perfiles_hijos
    ADD CONSTRAINT fk_usuario_padre FOREIGN KEY (usuario_id_padre) REFERENCES public.usuarios(usuario_id) ON DELETE CASCADE;


-- Completed on 2026-06-02 23:07:16

--
-- PostgreSQL database dump complete
--

\unrestrict vorctdzsGmFsfgmdMyKR4mSL5MLrz61RshS2Nwnr5OUHhXXAkg9Ogfl2cjJsjeP

