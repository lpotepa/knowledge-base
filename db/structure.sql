SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: translation_status; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.translation_status AS ENUM (
    'pending',
    'completed',
    'error'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.answers (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    content text,
    article_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.articles (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.languages (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    name character varying,
    iso character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    content text,
    article_id uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: translations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.translations (
    id uuid DEFAULT public.gen_random_uuid() NOT NULL,
    content text,
    language_id uuid NOT NULL,
    translatable_id uuid,
    translatable_type uuid,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    status public.translation_status
);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translations
    ADD CONSTRAINT translations_pkey PRIMARY KEY (id);


--
-- Name: index_answers_on_article_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_answers_on_article_id ON public.answers USING btree (article_id);


--
-- Name: index_languages_on_iso; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_iso ON public.languages USING btree (iso);


--
-- Name: index_languages_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_languages_on_name ON public.languages USING btree (name);


--
-- Name: index_questions_on_article_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_questions_on_article_id ON public.questions USING btree (article_id);


--
-- Name: index_translations_on_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_translations_on_language_id ON public.translations USING btree (language_id);


--
-- Name: index_translations_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_translations_on_status ON public.translations USING btree (status);


--
-- Name: index_translations_on_translatable_id_and_language_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_translations_on_translatable_id_and_language_id ON public.translations USING btree (translatable_id, language_id);


--
-- Name: index_translations_on_translatable_id_and_translatable_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_translations_on_translatable_id_and_translatable_type ON public.translations USING btree (translatable_id, translatable_type);


--
-- Name: fk_rails_71a44fc54a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.translations
    ADD CONSTRAINT fk_rails_71a44fc54a FOREIGN KEY (language_id) REFERENCES public.languages(id);


--
-- Name: fk_rails_ae8065a073; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT fk_rails_ae8065a073 FOREIGN KEY (article_id) REFERENCES public.articles(id);


--
-- Name: fk_rails_b4ddd24649; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.answers
    ADD CONSTRAINT fk_rails_b4ddd24649 FOREIGN KEY (article_id) REFERENCES public.articles(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20191001174842'),
('20191001175108'),
('20191001180131'),
('20191001180139'),
('20191001192340'),
('20191001192423'),
('20191002190941');


