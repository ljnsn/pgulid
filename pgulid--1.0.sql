-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pgulid" to load this file. \quit

CREATE OR REPLACE FUNCTION public.generate_ulid() RETURNS uuid AS
$$
SELECT (lpad(to_hex(floor(extract(epoch FROM clock_timestamp()) * 1000)::bigint), 12,
             '0') || encode(gen_random_bytes(10), 'hex'))::uuid;
$$ LANGUAGE SQL;
