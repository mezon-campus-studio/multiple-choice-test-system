--
-- PostgreSQL database dump
--

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-13 22:22:22

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;

COMMENT ON SCHEMA public IS 'standard public schema';

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 224 (class 1259 OID 16443)
-- Name: Answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Answers" (
    id bigint NOT NULL,
    desciption text NOT NULL,
    question_id bigint NOT NULL,
    valid boolean,
    "createdAt" bigint,
    "updateAt" bigint
);

--
-- TOC entry 226 (class 1259 OID 24592)
-- Name: Exam; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Exam" (
    id bigint NOT NULL,
    code bit varying(10) NOT NULL,
    active boolean DEFAULT true,
    subject_id bigint NOT NULL,
    creator_id bigint NOT NULL,
    "createdAt" bigint
);

--
-- TOC entry 223 (class 1259 OID 16434)
-- Name: Questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Questions" (
    id bigint NOT NULL,
    description text NOT NULL,
    content text,
    type character varying(50),
    "createdAt" bigint,
    "updatedAt" bigint,
    difficult integer,
    subject_id bigint NOT NULL
);

--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: Roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Roles" (
    id bigint NOT NULL,
    role_name character varying(50) NOT NULL,
    description character varying(50),
    "createdAt" bigint,
    "updatedAt" bigint
);

--
-- TOC entry 228 (class 1259 OID 24633)
-- Name: Score; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Score" (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    exam_id bigint NOT NULL,
    "time" bigint,
    score integer
);

--
-- TOC entry 227 (class 1259 OID 24612)
-- Name: Session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Session" (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    exam_id bigint NOT NULL,
    "time" bigint NOT NULL,
    status "char"[],
    answered boolean[]
);

--
-- TOC entry 225 (class 1259 OID 24576)
-- Name: Subject; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Subject" (
    id bigint NOT NULL,
    name character varying(50) NOT NULL,
    "createdAt" bigint
);

--
-- TOC entry 220 (class 1259 OID 16389)
-- Name: Users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users" (
    id bigint CONSTRAINT "User_id_not_null" NOT NULL,
    username character varying(100) CONSTRAINT "User_username_not_null" NOT NULL,
    avatar text,
    password text CONSTRAINT "User_password_not_null" NOT NULL,
    email character varying(200) CONSTRAINT "User_email_not_null" NOT NULL,
    "createdAt" bigint,
    "updatedAt" bigint
);

CREATE SEQUENCE public."User_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public."User_id_seq" OWNED BY public."Users".id;

--
-- TOC entry 222 (class 1259 OID 16416)
-- Name: Users_Roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."Users_Roles" (
    id bigint CONSTRAINT "User_Roles_id_not_null" NOT NULL,
    user_id bigint CONSTRAINT "User_Roles_user_id_not_null" NOT NULL,
    role_id bigint CONSTRAINT "User_Roles_role_id_not_null" NOT NULL,
    "createdAt" bigint
);

--
-- Constraints
--

ALTER TABLE ONLY public."Users" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);

ALTER TABLE ONLY public."Score" ADD CONSTRAINT "Score_pkey" PRIMARY KEY (id);
ALTER TABLE ONLY public."Answers" ADD CONSTRAINT answer_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Exam" ADD CONSTRAINT exam_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Questions" ADD CONSTRAINT question_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Roles" ADD CONSTRAINT role_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Session" ADD CONSTRAINT session_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Subject" ADD CONSTRAINT subject_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Users" ADD CONSTRAINT user_id PRIMARY KEY (id);
ALTER TABLE ONLY public."Users_Roles" ADD CONSTRAINT user_role_id PRIMARY KEY (id);

--
-- Foreign Keys
--

ALTER TABLE ONLY public."Exam" ADD CONSTRAINT creator_id FOREIGN KEY (creator_id) REFERENCES public."Users"(id);
ALTER TABLE ONLY public."Score" ADD CONSTRAINT exam_id FOREIGN KEY (exam_id) REFERENCES public."Exam"(id) NOT VALID;
ALTER TABLE ONLY public."Session" ADD CONSTRAINT exam_id FOREIGN KEY (exam_id) REFERENCES public."Exam"(id);
ALTER TABLE ONLY public."Users_Roles" ADD CONSTRAINT fk_role FOREIGN KEY (role_id) REFERENCES public."Roles"(id) NOT VALID;
ALTER TABLE ONLY public."Users_Roles" ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public."Users"(id);
ALTER TABLE ONLY public."Answers" ADD CONSTRAINT question_id FOREIGN KEY (question_id) REFERENCES public."Questions"(id);
ALTER TABLE ONLY public."Exam" ADD CONSTRAINT subject_id FOREIGN KEY (subject_id) REFERENCES public."Subject"(id);
ALTER TABLE ONLY public."Questions" ADD CONSTRAINT subject_id FOREIGN KEY (subject_id) REFERENCES public."Subject"(id) NOT VALID;
ALTER TABLE ONLY public."Score" ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(id) NOT VALID;
ALTER TABLE ONLY public."Session" ADD CONSTRAINT user_id FOREIGN KEY (user_id) REFERENCES public."Users"(id);

--
-- PostgreSQL database dump complete
--
