/* contrib/unaccent/unaccent--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION unaccent" to load this file. \quit

CREATE FUNCTION unaccent(regdictionary, text)
	RETURNS text
	AS 'MODULE_PATHNAME', 'unaccent_dict'
	LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION unaccent(text)
	RETURNS text
	AS 'MODULE_PATHNAME', 'unaccent_dict'
	LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION unaccent_init(internal)
	RETURNS internal
	AS 'MODULE_PATHNAME', 'unaccent_init'
	LANGUAGE C;

CREATE FUNCTION unaccent_lexize(internal,internal,internal,internal)
	RETURNS internal
	AS 'MODULE_PATHNAME', 'unaccent_lexize'
	LANGUAGE C;

CREATE TEXT SEARCH TEMPLATE unaccent (
	INIT = unaccent_init,
	LEXIZE = unaccent_lexize
);

CREATE TEXT SEARCH DICTIONARY unaccent (
	TEMPLATE = unaccent,
	RULES    = 'unaccent'
);
