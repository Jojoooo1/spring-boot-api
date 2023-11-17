--
-- PostgreSQL database dump
--

-- Dumped from database version 15.5
-- Dumped by pg_dump version 16.0 (Ubuntu 16.0-1.pgdg22.04+1)

-- Started on 2023-11-17 15:49:28 -03

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

--
-- TOC entry 5 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 5
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 16386)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


--
-- TOC entry 215 (class 1259 OID 16391)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


--
-- TOC entry 216 (class 1259 OID 16394)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


--
-- TOC entry 217 (class 1259 OID 16398)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


--
-- TOC entry 218 (class 1259 OID 16406)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 219 (class 1259 OID 16409)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 220 (class 1259 OID 16414)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 16419)
-- Name: client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


--
-- TOC entry 222 (class 1259 OID 16437)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 223 (class 1259 OID 16442)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


--
-- TOC entry 224 (class 1259 OID 16445)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


--
-- TOC entry 225 (class 1259 OID 16448)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16451)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


--
-- TOC entry 227 (class 1259 OID 16456)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


--
-- TOC entry 228 (class 1259 OID 16461)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 229 (class 1259 OID 16467)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16470)
-- Name: client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


--
-- TOC entry 231 (class 1259 OID 16475)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16478)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 16483)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16486)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 235 (class 1259 OID 16489)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16494)
-- Name: component; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


--
-- TOC entry 237 (class 1259 OID 16499)
-- Name: component_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


--
-- TOC entry 238 (class 1259 OID 16504)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 16507)
-- Name: credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 240 (class 1259 OID 16512)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


--
-- TOC entry 241 (class 1259 OID 16517)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


--
-- TOC entry 242 (class 1259 OID 16520)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 16524)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


--
-- TOC entry 244 (class 1259 OID 16529)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


--
-- TOC entry 245 (class 1259 OID 16534)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 246 (class 1259 OID 16539)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 247 (class 1259 OID 16542)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


--
-- TOC entry 248 (class 1259 OID 16547)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 249 (class 1259 OID 16550)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 250 (class 1259 OID 16556)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


--
-- TOC entry 251 (class 1259 OID 16559)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 252 (class 1259 OID 16564)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 253 (class 1259 OID 16569)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 254 (class 1259 OID 16575)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 255 (class 1259 OID 16578)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


--
-- TOC entry 256 (class 1259 OID 16589)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 257 (class 1259 OID 16594)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 258 (class 1259 OID 16599)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 259 (class 1259 OID 16604)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


--
-- TOC entry 260 (class 1259 OID 16607)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


--
-- TOC entry 261 (class 1259 OID 16613)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


--
-- TOC entry 262 (class 1259 OID 16617)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


--
-- TOC entry 263 (class 1259 OID 16624)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 264 (class 1259 OID 16630)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


--
-- TOC entry 265 (class 1259 OID 16635)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


--
-- TOC entry 266 (class 1259 OID 16640)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 267 (class 1259 OID 16645)
-- Name: realm; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


--
-- TOC entry 268 (class 1259 OID 16678)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


--
-- TOC entry 269 (class 1259 OID 16683)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


--
-- TOC entry 270 (class 1259 OID 16686)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 271 (class 1259 OID 16689)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 272 (class 1259 OID 16692)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 16697)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 274 (class 1259 OID 16704)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 275 (class 1259 OID 16709)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 276 (class 1259 OID 16712)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 16715)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


--
-- TOC entry 278 (class 1259 OID 16720)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


--
-- TOC entry 279 (class 1259 OID 16727)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


--
-- TOC entry 280 (class 1259 OID 16733)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 281 (class 1259 OID 16736)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 282 (class 1259 OID 16739)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


--
-- TOC entry 283 (class 1259 OID 16744)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


--
-- TOC entry 284 (class 1259 OID 16749)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


--
-- TOC entry 285 (class 1259 OID 16754)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 286 (class 1259 OID 16760)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


--
-- TOC entry 287 (class 1259 OID 16765)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 288 (class 1259 OID 16768)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


--
-- TOC entry 289 (class 1259 OID 16773)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


--
-- TOC entry 290 (class 1259 OID 16776)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


--
-- TOC entry 291 (class 1259 OID 16779)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


--
-- TOC entry 292 (class 1259 OID 16785)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


--
-- TOC entry 293 (class 1259 OID 16790)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


--
-- TOC entry 294 (class 1259 OID 16793)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


--
-- TOC entry 295 (class 1259 OID 16801)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 296 (class 1259 OID 16806)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


--
-- TOC entry 297 (class 1259 OID 16811)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


--
-- TOC entry 298 (class 1259 OID 16816)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


--
-- TOC entry 299 (class 1259 OID 16821)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 300 (class 1259 OID 16824)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


--
-- TOC entry 301 (class 1259 OID 16828)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


--
-- TOC entry 302 (class 1259 OID 16831)
-- Name: user_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


--
-- TOC entry 303 (class 1259 OID 16837)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


--
-- TOC entry 304 (class 1259 OID 16842)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


--
-- TOC entry 305 (class 1259 OID 16847)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


--
-- TOC entry 4124 (class 0 OID 16386)
-- Dependencies: 214
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 4125 (class 0 OID 16391)
-- Dependencies: 215
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 4126 (class 0 OID 16394)
-- Dependencies: 216
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
982f5bb4-bdeb-479f-abbe-9741d8a387c8	\N	auth-cookie	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	507f64f1-fbf8-46ad-b58a-9a8e30ab195d	2	10	f	\N	\N
126ef148-6856-4395-b4fe-655481e54394	\N	auth-spnego	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	507f64f1-fbf8-46ad-b58a-9a8e30ab195d	3	20	f	\N	\N
9223ba3e-ec16-47cd-a847-73b85731b0b0	\N	identity-provider-redirector	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	507f64f1-fbf8-46ad-b58a-9a8e30ab195d	2	25	f	\N	\N
6a7a10d3-f823-43b6-aa47-2b57c4de1170	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	507f64f1-fbf8-46ad-b58a-9a8e30ab195d	2	30	t	12b3e0c2-3449-4b72-82bd-c78fb5cc07e5	\N
67f73b74-f7a8-4a64-8d94-9cc8594dbbd2	\N	auth-username-password-form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	12b3e0c2-3449-4b72-82bd-c78fb5cc07e5	0	10	f	\N	\N
cbb087d5-ac40-4481-a6a8-e3945dc21fb0	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	12b3e0c2-3449-4b72-82bd-c78fb5cc07e5	1	20	t	8c5d3df4-42cf-4414-b940-d87f11379f78	\N
b541a115-36fd-4674-84a9-b45db063089a	\N	conditional-user-configured	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	8c5d3df4-42cf-4414-b940-d87f11379f78	0	10	f	\N	\N
adc44dcd-5506-4537-9dfb-c2d7a44b32b0	\N	auth-otp-form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	8c5d3df4-42cf-4414-b940-d87f11379f78	0	20	f	\N	\N
138bfb98-a4a1-4428-9da1-2d948ca1a9c4	\N	direct-grant-validate-username	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2c7169e5-8b4e-42d0-8528-98a607b766e8	0	10	f	\N	\N
cbe81dc8-e5dc-4be9-a839-8a71b0ff34ab	\N	direct-grant-validate-password	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2c7169e5-8b4e-42d0-8528-98a607b766e8	0	20	f	\N	\N
7b5b2f15-3a26-4af1-ae04-4f111da3fc58	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2c7169e5-8b4e-42d0-8528-98a607b766e8	1	30	t	784719ca-199b-480a-9d51-35f074dbec2c	\N
88df7176-c229-4d22-9f02-62b3135dc535	\N	conditional-user-configured	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	784719ca-199b-480a-9d51-35f074dbec2c	0	10	f	\N	\N
51096de9-8744-426d-9620-93148e640652	\N	direct-grant-validate-otp	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	784719ca-199b-480a-9d51-35f074dbec2c	0	20	f	\N	\N
a7d7d7e5-b756-4be0-8726-94a4927d2635	\N	registration-page-form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	596eacd4-8a8e-46f7-b8e9-65fb90619f1e	0	10	t	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	\N
ef00c9c3-9d2c-4cc9-8976-ccfb81ab6123	\N	registration-user-creation	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	0	20	f	\N	\N
8b334ba4-7953-4563-8272-57e6c412e731	\N	registration-profile-action	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	0	40	f	\N	\N
4a10fc65-f26d-454b-adf6-ecf2d3365a03	\N	registration-password-action	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	0	50	f	\N	\N
0d7299a1-31df-4150-8cee-ab3a470d2f51	\N	registration-recaptcha-action	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	3	60	f	\N	\N
562b2c52-0879-4512-85fe-07d56558a73d	\N	registration-terms-and-conditions	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	3	70	f	\N	\N
f449cbe8-dcde-4f11-89ce-663877c18af8	\N	reset-credentials-choose-user	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	0	10	f	\N	\N
8fa22967-6ad6-409c-a91c-819ad7d857ce	\N	reset-credential-email	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	0	20	f	\N	\N
a47ed177-a92d-4caa-af35-b1722a42e494	\N	reset-password	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	0	30	f	\N	\N
7a083fb6-bf31-4ca9-818e-708176aee805	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	1	40	t	d75b6bf5-42cd-499f-81bc-74ca5446d8e6	\N
b631e026-77a3-4bbe-9284-235f292b7bfd	\N	conditional-user-configured	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d75b6bf5-42cd-499f-81bc-74ca5446d8e6	0	10	f	\N	\N
e2de6d57-7fac-46f2-b321-75b08f0a53e5	\N	reset-otp	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d75b6bf5-42cd-499f-81bc-74ca5446d8e6	0	20	f	\N	\N
096a7788-458e-442c-98bc-9ab306f7c859	\N	client-secret	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	74e36e0a-27ab-4ab9-be8e-df34337e18da	2	10	f	\N	\N
09f3928b-871a-4a9b-a9bd-6412f99f60dd	\N	client-jwt	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	74e36e0a-27ab-4ab9-be8e-df34337e18da	2	20	f	\N	\N
6785ccc2-e743-47a9-b067-8343ce76816f	\N	client-secret-jwt	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	74e36e0a-27ab-4ab9-be8e-df34337e18da	2	30	f	\N	\N
ca8c1686-c466-4ac3-9855-bcd5ebc7392a	\N	client-x509	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	74e36e0a-27ab-4ab9-be8e-df34337e18da	2	40	f	\N	\N
31176d01-0a19-4903-8e0c-51445416b3dc	\N	idp-review-profile	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d1b790e1-c9c4-470b-9777-48f45f4f5d92	0	10	f	\N	cf16e950-a233-4e92-9dee-6d41b06683de
a507262d-b37a-48f2-a7db-697f0b82453d	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	d1b790e1-c9c4-470b-9777-48f45f4f5d92	0	20	t	4b018c9e-9968-41dc-8fc3-737432364c16	\N
6627a4bf-88ab-4e9d-a7c9-4a127a3f8e50	\N	idp-create-user-if-unique	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	4b018c9e-9968-41dc-8fc3-737432364c16	2	10	f	\N	0076c669-9207-4022-9211-f43397e9feed
9ef87ac7-32e8-46d3-a9a1-f1db187efab4	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	4b018c9e-9968-41dc-8fc3-737432364c16	2	20	t	38f5cbe8-9a3c-4a96-99e5-40ee981197df	\N
21a40133-dadc-4892-ac70-df6d87cb6467	\N	idp-confirm-link	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	38f5cbe8-9a3c-4a96-99e5-40ee981197df	0	10	f	\N	\N
14d55e1c-a485-4c88-b1cd-b9d144ca89e7	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	38f5cbe8-9a3c-4a96-99e5-40ee981197df	0	20	t	bd3725c3-94d4-4e05-bb43-c7c3392b355c	\N
20e93eba-64d3-4344-93b9-671704895712	\N	idp-email-verification	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	bd3725c3-94d4-4e05-bb43-c7c3392b355c	2	10	f	\N	\N
7bf22221-0b7c-4e10-bb21-af4c7ddb3b4b	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	bd3725c3-94d4-4e05-bb43-c7c3392b355c	2	20	t	7040e409-e412-49fd-aa3f-f4475f12e769	\N
ead5bc41-e070-45e2-9dad-2e0e4d708e84	\N	idp-username-password-form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7040e409-e412-49fd-aa3f-f4475f12e769	0	10	f	\N	\N
06bd528c-fef9-4858-b037-1544c4d78609	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7040e409-e412-49fd-aa3f-f4475f12e769	1	20	t	3773c66d-d83c-4089-b82f-27e1eb692da1	\N
871d4fd0-fe06-433f-bb8a-1720524540a0	\N	conditional-user-configured	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	3773c66d-d83c-4089-b82f-27e1eb692da1	0	10	f	\N	\N
1a0938d4-45a1-432b-a8fc-d9bdff86ef49	\N	auth-otp-form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	3773c66d-d83c-4089-b82f-27e1eb692da1	0	20	f	\N	\N
34bfba36-eae3-4c37-a8c9-308c91b19829	\N	http-basic-authenticator	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	3379b3f7-63c0-4247-84b1-11d0df301ff1	0	10	f	\N	\N
0e811058-9efa-4ca7-94e7-2993c3fa1cbf	\N	docker-http-basic-authenticator	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	92709a50-37bf-492f-beef-6c42d5604eb5	0	10	f	\N	\N
ed814c2e-6536-4370-a633-bcdd44878d1c	\N	auth-cookie	f22bc560-708c-401c-ad05-2dbb1cda77dd	bab30669-6c44-49d5-95c0-c6ab266d3f87	2	10	f	\N	\N
95b42a3d-76c4-41d8-b7a8-7b36e7ba05db	\N	auth-spnego	f22bc560-708c-401c-ad05-2dbb1cda77dd	bab30669-6c44-49d5-95c0-c6ab266d3f87	3	20	f	\N	\N
3cdde19f-8a9e-4ee8-9205-a07023df0003	\N	identity-provider-redirector	f22bc560-708c-401c-ad05-2dbb1cda77dd	bab30669-6c44-49d5-95c0-c6ab266d3f87	2	25	f	\N	\N
a7788567-8d3d-4b54-afd1-c5fc9c3d0ea0	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	bab30669-6c44-49d5-95c0-c6ab266d3f87	2	30	t	7ff87858-5a5a-40dc-9e34-853f71be0203	\N
699e496d-b45a-42c9-9086-ff7fa2e95dc8	\N	auth-username-password-form	f22bc560-708c-401c-ad05-2dbb1cda77dd	7ff87858-5a5a-40dc-9e34-853f71be0203	0	10	f	\N	\N
6ec2dbf4-9174-4400-be28-62c1f0cfe1e0	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	7ff87858-5a5a-40dc-9e34-853f71be0203	1	20	t	ce5ba4cb-a562-4b23-8195-a0631f721b75	\N
20cdad0a-d033-47e9-bbd3-0633c3450a52	\N	conditional-user-configured	f22bc560-708c-401c-ad05-2dbb1cda77dd	ce5ba4cb-a562-4b23-8195-a0631f721b75	0	10	f	\N	\N
e0c5f19c-cac1-4e96-afe3-60aedc69b6d9	\N	auth-otp-form	f22bc560-708c-401c-ad05-2dbb1cda77dd	ce5ba4cb-a562-4b23-8195-a0631f721b75	0	20	f	\N	\N
82f9cf0b-6b22-485d-ba2e-e80ddd39bfcc	\N	direct-grant-validate-username	f22bc560-708c-401c-ad05-2dbb1cda77dd	2d2ba200-7a62-4c71-a80f-e360ad8a0402	0	10	f	\N	\N
175e9309-fad4-4ebc-84c5-3f4996edc2d5	\N	direct-grant-validate-password	f22bc560-708c-401c-ad05-2dbb1cda77dd	2d2ba200-7a62-4c71-a80f-e360ad8a0402	0	20	f	\N	\N
a15803d1-0f73-4b41-96b3-027ae9bcad47	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	2d2ba200-7a62-4c71-a80f-e360ad8a0402	1	30	t	09b7146b-2397-435c-805a-ba08d802a44d	\N
d1f57b51-7d3e-4666-bd93-9cc33f4ff6dc	\N	conditional-user-configured	f22bc560-708c-401c-ad05-2dbb1cda77dd	09b7146b-2397-435c-805a-ba08d802a44d	0	10	f	\N	\N
5002ac6c-c4e6-4446-abfa-e9988a8c912f	\N	direct-grant-validate-otp	f22bc560-708c-401c-ad05-2dbb1cda77dd	09b7146b-2397-435c-805a-ba08d802a44d	0	20	f	\N	\N
879de9e2-5653-4005-a2b1-00d2aea29838	\N	registration-page-form	f22bc560-708c-401c-ad05-2dbb1cda77dd	db1ad190-2a35-46f7-9a9b-b8c95fee3ca0	0	10	t	8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	\N
94e299f0-3c30-4992-9856-d2cc307f168b	\N	registration-user-creation	f22bc560-708c-401c-ad05-2dbb1cda77dd	8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	0	20	f	\N	\N
279f1eef-2ddb-4f6d-885d-6979fcff6d73	\N	registration-profile-action	f22bc560-708c-401c-ad05-2dbb1cda77dd	8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	0	40	f	\N	\N
811446cb-5d78-409b-8363-fda8e862a9e9	\N	registration-password-action	f22bc560-708c-401c-ad05-2dbb1cda77dd	8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	0	50	f	\N	\N
767545af-021e-45ad-a3e3-f23fc380f377	\N	registration-recaptcha-action	f22bc560-708c-401c-ad05-2dbb1cda77dd	8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	3	60	f	\N	\N
defb3f0d-8405-4d71-92be-1497405099d8	\N	reset-credentials-choose-user	f22bc560-708c-401c-ad05-2dbb1cda77dd	68da3da3-118a-417a-9392-0f8237ffe2f9	0	10	f	\N	\N
4722facf-7761-4215-be42-1f6c94f471f2	\N	reset-credential-email	f22bc560-708c-401c-ad05-2dbb1cda77dd	68da3da3-118a-417a-9392-0f8237ffe2f9	0	20	f	\N	\N
c572034e-46a1-49e1-ab9d-6ccf866149a2	\N	reset-password	f22bc560-708c-401c-ad05-2dbb1cda77dd	68da3da3-118a-417a-9392-0f8237ffe2f9	0	30	f	\N	\N
40c201a4-9bea-4f6d-ac06-439b70f6283f	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	68da3da3-118a-417a-9392-0f8237ffe2f9	1	40	t	fd2bcccb-3b65-47f4-8db9-407a9a9b6b87	\N
510c925f-1510-4f91-be52-766afc4a6038	\N	conditional-user-configured	f22bc560-708c-401c-ad05-2dbb1cda77dd	fd2bcccb-3b65-47f4-8db9-407a9a9b6b87	0	10	f	\N	\N
8a3bc877-214b-4863-b21c-35abc95f63f6	\N	reset-otp	f22bc560-708c-401c-ad05-2dbb1cda77dd	fd2bcccb-3b65-47f4-8db9-407a9a9b6b87	0	20	f	\N	\N
c14a803f-e976-4669-a2d6-97fb042655ce	\N	client-secret	f22bc560-708c-401c-ad05-2dbb1cda77dd	155576ad-86b2-40ed-9d53-761c460a13bc	2	10	f	\N	\N
3a338101-bda9-4101-8482-3c8e3c33918e	\N	client-jwt	f22bc560-708c-401c-ad05-2dbb1cda77dd	155576ad-86b2-40ed-9d53-761c460a13bc	2	20	f	\N	\N
542eac3e-dfeb-460c-ac93-70d1c41da5cd	\N	client-secret-jwt	f22bc560-708c-401c-ad05-2dbb1cda77dd	155576ad-86b2-40ed-9d53-761c460a13bc	2	30	f	\N	\N
6e7f53f5-5c48-4dbb-bd10-e851c1c87dc0	\N	client-x509	f22bc560-708c-401c-ad05-2dbb1cda77dd	155576ad-86b2-40ed-9d53-761c460a13bc	2	40	f	\N	\N
695c63d2-ec3f-4cc4-b2f5-38d18e051884	\N	idp-review-profile	f22bc560-708c-401c-ad05-2dbb1cda77dd	e7ec0f78-c23a-4d20-991c-3c530266b30d	0	10	f	\N	c4ecc6c9-abd1-44cf-a3e8-1e5340baea34
775ec883-1757-4bca-bf83-7dd58c9f3706	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	e7ec0f78-c23a-4d20-991c-3c530266b30d	0	20	t	c7f870d8-ac0d-40a1-99c2-56c56ccde886	\N
c2fc41b8-6a89-43f9-93b6-1fbb157380db	\N	idp-create-user-if-unique	f22bc560-708c-401c-ad05-2dbb1cda77dd	c7f870d8-ac0d-40a1-99c2-56c56ccde886	2	10	f	\N	53ab0a72-b790-4c26-a44b-c85a37921508
e0273fc2-cc20-4892-88bd-015ebca37e8d	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	c7f870d8-ac0d-40a1-99c2-56c56ccde886	2	20	t	1e6d6d33-acf4-4cd6-919d-355e48c557e4	\N
68ca167c-283d-4aff-a3cd-8a95b07ae10f	\N	idp-confirm-link	f22bc560-708c-401c-ad05-2dbb1cda77dd	1e6d6d33-acf4-4cd6-919d-355e48c557e4	0	10	f	\N	\N
a800ff96-ca80-454d-9d8e-5921ddf64575	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	1e6d6d33-acf4-4cd6-919d-355e48c557e4	0	20	t	c37cef77-4790-43b4-b2ef-3607cab11af0	\N
18dab846-5dac-46c0-a390-500a5a00fff0	\N	idp-email-verification	f22bc560-708c-401c-ad05-2dbb1cda77dd	c37cef77-4790-43b4-b2ef-3607cab11af0	2	10	f	\N	\N
566d3ee0-0010-4de5-bd8f-1ddd34c66296	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	c37cef77-4790-43b4-b2ef-3607cab11af0	2	20	t	1641996b-abc5-45ce-a1c9-1054e7c8f752	\N
63d42b16-5826-402c-92c1-a53f4d822d2a	\N	idp-username-password-form	f22bc560-708c-401c-ad05-2dbb1cda77dd	1641996b-abc5-45ce-a1c9-1054e7c8f752	0	10	f	\N	\N
bb2cd551-2c29-4589-a604-2af32ee7004a	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	1641996b-abc5-45ce-a1c9-1054e7c8f752	1	20	t	a42252e3-2c9d-4f9c-98c4-aa214f66b78e	\N
c32f8fc1-c77f-4104-b3ed-93a8d4990646	\N	conditional-user-configured	f22bc560-708c-401c-ad05-2dbb1cda77dd	a42252e3-2c9d-4f9c-98c4-aa214f66b78e	0	10	f	\N	\N
bbe76980-de58-407a-b2f2-79442cca2eae	\N	auth-otp-form	f22bc560-708c-401c-ad05-2dbb1cda77dd	a42252e3-2c9d-4f9c-98c4-aa214f66b78e	0	20	f	\N	\N
c80a2faa-72fd-44c0-b124-ab8ac891d8fd	\N	http-basic-authenticator	f22bc560-708c-401c-ad05-2dbb1cda77dd	7177212e-59fb-4546-8b34-256b8021ef77	0	10	f	\N	\N
d4145051-6e22-4d62-8595-5352619a8327	\N	docker-http-basic-authenticator	f22bc560-708c-401c-ad05-2dbb1cda77dd	1d3daad3-a767-4c69-9bc0-669f96814ece	0	10	f	\N	\N
\.


--
-- TOC entry 4127 (class 0 OID 16398)
-- Dependencies: 217
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
507f64f1-fbf8-46ad-b58a-9a8e30ab195d	browser	browser based authentication	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
12b3e0c2-3449-4b72-82bd-c78fb5cc07e5	forms	Username, password, otp and other auth forms.	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
8c5d3df4-42cf-4414-b940-d87f11379f78	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
2c7169e5-8b4e-42d0-8528-98a607b766e8	direct grant	OpenID Connect Resource Owner Grant	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
784719ca-199b-480a-9d51-35f074dbec2c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
596eacd4-8a8e-46f7-b8e9-65fb90619f1e	registration	registration flow	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
c7a4dfd0-3c3c-4fd6-bf65-f000c97f7d47	registration form	registration form	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	form-flow	f	t
d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	reset credentials	Reset credentials for a user if they forgot their password or something	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
d75b6bf5-42cd-499f-81bc-74ca5446d8e6	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
74e36e0a-27ab-4ab9-be8e-df34337e18da	clients	Base authentication for clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	client-flow	t	t
d1b790e1-c9c4-470b-9777-48f45f4f5d92	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
4b018c9e-9968-41dc-8fc3-737432364c16	User creation or linking	Flow for the existing/non-existing user alternatives	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
38f5cbe8-9a3c-4a96-99e5-40ee981197df	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
bd3725c3-94d4-4e05-bb43-c7c3392b355c	Account verification options	Method with which to verity the existing account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
7040e409-e412-49fd-aa3f-f4475f12e769	Verify Existing Account by Re-authentication	Reauthentication of existing account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
3773c66d-d83c-4089-b82f-27e1eb692da1	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	f	t
3379b3f7-63c0-4247-84b1-11d0df301ff1	saml ecp	SAML ECP Profile Authentication Flow	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
92709a50-37bf-492f-beef-6c42d5604eb5	docker auth	Used by Docker clients to authenticate against the IDP	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	basic-flow	t	t
bab30669-6c44-49d5-95c0-c6ab266d3f87	browser	browser based authentication	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
7ff87858-5a5a-40dc-9e34-853f71be0203	forms	Username, password, otp and other auth forms.	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
ce5ba4cb-a562-4b23-8195-a0631f721b75	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
2d2ba200-7a62-4c71-a80f-e360ad8a0402	direct grant	OpenID Connect Resource Owner Grant	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
09b7146b-2397-435c-805a-ba08d802a44d	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
db1ad190-2a35-46f7-9a9b-b8c95fee3ca0	registration	registration flow	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
8c0f49b6-ee25-4c06-a7ba-c82eedc3cf1b	registration form	registration form	f22bc560-708c-401c-ad05-2dbb1cda77dd	form-flow	f	t
68da3da3-118a-417a-9392-0f8237ffe2f9	reset credentials	Reset credentials for a user if they forgot their password or something	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
fd2bcccb-3b65-47f4-8db9-407a9a9b6b87	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
155576ad-86b2-40ed-9d53-761c460a13bc	clients	Base authentication for clients	f22bc560-708c-401c-ad05-2dbb1cda77dd	client-flow	t	t
e7ec0f78-c23a-4d20-991c-3c530266b30d	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
c7f870d8-ac0d-40a1-99c2-56c56ccde886	User creation or linking	Flow for the existing/non-existing user alternatives	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
1e6d6d33-acf4-4cd6-919d-355e48c557e4	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
c37cef77-4790-43b4-b2ef-3607cab11af0	Account verification options	Method with which to verity the existing account	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
1641996b-abc5-45ce-a1c9-1054e7c8f752	Verify Existing Account by Re-authentication	Reauthentication of existing account	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
a42252e3-2c9d-4f9c-98c4-aa214f66b78e	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	f	t
7177212e-59fb-4546-8b34-256b8021ef77	saml ecp	SAML ECP Profile Authentication Flow	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
1d3daad3-a767-4c69-9bc0-669f96814ece	docker auth	Used by Docker clients to authenticate against the IDP	f22bc560-708c-401c-ad05-2dbb1cda77dd	basic-flow	t	t
\.


--
-- TOC entry 4128 (class 0 OID 16406)
-- Dependencies: 218
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
cf16e950-a233-4e92-9dee-6d41b06683de	review profile config	e57cceb5-7637-45fa-b2ba-ebbba563f9c9
0076c669-9207-4022-9211-f43397e9feed	create unique user config	e57cceb5-7637-45fa-b2ba-ebbba563f9c9
c4ecc6c9-abd1-44cf-a3e8-1e5340baea34	review profile config	f22bc560-708c-401c-ad05-2dbb1cda77dd
53ab0a72-b790-4c26-a44b-c85a37921508	create unique user config	f22bc560-708c-401c-ad05-2dbb1cda77dd
\.


--
-- TOC entry 4129 (class 0 OID 16409)
-- Dependencies: 219
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
0076c669-9207-4022-9211-f43397e9feed	false	require.password.update.after.registration
cf16e950-a233-4e92-9dee-6d41b06683de	missing	update.profile.on.first.login
53ab0a72-b790-4c26-a44b-c85a37921508	false	require.password.update.after.registration
c4ecc6c9-abd1-44cf-a3e8-1e5340baea34	missing	update.profile.on.first.login
\.


--
-- TOC entry 4130 (class 0 OID 16414)
-- Dependencies: 220
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4131 (class 0 OID 16419)
-- Dependencies: 221
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	f	master-realm	0	f	\N	\N	t	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
d67b2d04-0a42-4877-ad42-fb7ac325e66d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	t	f	broker	0	f	\N	\N	t	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
3f12da87-c610-479c-a8b8-e17bd2941cdc	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
60de7067-1945-4c12-9242-6393e17cc14f	t	f	admin-cli	0	t	\N	\N	f	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	f	api-realm	0	f	\N	\N	t	\N	f	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	0	f	f	api Realm	f	client-secret	\N	\N	\N	t	f	f	f
1f8f4c4b-515d-4cae-ad55-371f83967386	t	f	realm-management	0	f	\N	\N	t	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	f	account	0	t	\N	/realms/api/account/	f	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	t	f	account-console	0	t	\N	/realms/api/account/	f	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	t	f	broker	0	f	\N	\N	t	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	t	f	security-admin-console	0	t	\N	/admin/api/console/	f	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
da400e9b-9d34-4754-bba8-475c01bc8769	t	f	admin-cli	0	t	\N	\N	f	\N	f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
daa819c5-ca52-4936-8800-7116fdfe0d54	t	t	api-cli	0	f	lpbLD2EboyHXU4wlx1qULsxt69Xo0ybz		f		f	f22bc560-708c-401c-ad05-2dbb1cda77dd	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- TOC entry 4132 (class 0 OID 16437)
-- Dependencies: 222
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
e154faf5-b5d2-4799-9bd6-8bdaa349601b	post.logout.redirect.uris	+
d67b2d04-0a42-4877-ad42-fb7ac325e66d	post.logout.redirect.uris	+
d67b2d04-0a42-4877-ad42-fb7ac325e66d	pkce.code.challenge.method	S256
3f12da87-c610-479c-a8b8-e17bd2941cdc	post.logout.redirect.uris	+
3f12da87-c610-479c-a8b8-e17bd2941cdc	pkce.code.challenge.method	S256
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	post.logout.redirect.uris	+
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	post.logout.redirect.uris	+
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	pkce.code.challenge.method	S256
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	post.logout.redirect.uris	+
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	pkce.code.challenge.method	S256
daa819c5-ca52-4936-8800-7116fdfe0d54	client.secret.creation.time	1694112470
daa819c5-ca52-4936-8800-7116fdfe0d54	oauth2.device.authorization.grant.enabled	false
daa819c5-ca52-4936-8800-7116fdfe0d54	oidc.ciba.grant.enabled	false
daa819c5-ca52-4936-8800-7116fdfe0d54	post.logout.redirect.uris	*
daa819c5-ca52-4936-8800-7116fdfe0d54	backchannel.logout.session.required	true
daa819c5-ca52-4936-8800-7116fdfe0d54	backchannel.logout.revoke.offline.tokens	false
daa819c5-ca52-4936-8800-7116fdfe0d54	display.on.consent.screen	false
daa819c5-ca52-4936-8800-7116fdfe0d54	use.refresh.tokens	true
daa819c5-ca52-4936-8800-7116fdfe0d54	client_credentials.use_refresh_token	false
daa819c5-ca52-4936-8800-7116fdfe0d54	token.response.type.bearer.lower-case	false
daa819c5-ca52-4936-8800-7116fdfe0d54	access.token.lifespan	3600
daa819c5-ca52-4936-8800-7116fdfe0d54	tls.client.certificate.bound.access.tokens	false
daa819c5-ca52-4936-8800-7116fdfe0d54	require.pushed.authorization.requests	false
daa819c5-ca52-4936-8800-7116fdfe0d54	acr.loa.map	{}
\.


--
-- TOC entry 4133 (class 0 OID 16442)
-- Dependencies: 223
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 4134 (class 0 OID 16445)
-- Dependencies: 224
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 4135 (class 0 OID 16448)
-- Dependencies: 225
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 4136 (class 0 OID 16451)
-- Dependencies: 226
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
2a6978d8-2996-40c2-b70f-f491584d8f90	offline_access	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect built-in scope: offline_access	openid-connect
051e8be0-fc52-4c1e-a184-bffdd192d8ed	role_list	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SAML role list	saml
4c237789-5d12-452b-ac37-419172627623	profile	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect built-in scope: profile	openid-connect
bc544bb7-a832-41f7-b4cc-775206c29ce2	email	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect built-in scope: email	openid-connect
25af5016-8247-4abe-90c3-bfd4e0297c45	address	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect built-in scope: address	openid-connect
10aad80e-f081-4c44-adbe-9f7e99a8b925	phone	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect built-in scope: phone	openid-connect
21e15ba2-6475-4e24-ae73-ed0e2b224b11	roles	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect scope for add user roles to the access token	openid-connect
2d5410a2-a71d-43b0-857c-111eed14c53e	web-origins	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect scope for add allowed web origins to the access token	openid-connect
791c532f-6203-4ea0-901a-043acab9bbcd	microprofile-jwt	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	Microprofile - JWT built-in scope	openid-connect
407b0d8f-3acb-4f85-b6a6-4013c43b718c	acr	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
8a1bc266-1016-45ac-baf1-aaf2a72b33a4	offline_access	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect built-in scope: offline_access	openid-connect
d9e489ee-6687-468b-bd43-82c773795734	role_list	f22bc560-708c-401c-ad05-2dbb1cda77dd	SAML role list	saml
3333893c-e45f-4d79-aba1-7588d8664b70	profile	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect built-in scope: profile	openid-connect
39b22340-8ec4-4352-85c9-ca4c87c2b35e	email	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect built-in scope: email	openid-connect
2c73bcba-f990-4d3e-9800-10255453a27b	address	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect built-in scope: address	openid-connect
46f28b59-b9cc-4472-9211-92ea9121335c	phone	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect built-in scope: phone	openid-connect
8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	roles	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect scope for add user roles to the access token	openid-connect
50baaf2f-a7f0-4c34-9705-6b60d974d9bc	web-origins	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3caf37ff-603b-45aa-8f68-7a6d1b8ce255	microprofile-jwt	f22bc560-708c-401c-ad05-2dbb1cda77dd	Microprofile - JWT built-in scope	openid-connect
3b522a3b-ed69-4e6f-b3e5-78067a0fd314	acr	f22bc560-708c-401c-ad05-2dbb1cda77dd	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1	company	f22bc560-708c-401c-ad05-2dbb1cda77dd	Company of the user	openid-connect
\.


--
-- TOC entry 4137 (class 0 OID 16456)
-- Dependencies: 227
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
2a6978d8-2996-40c2-b70f-f491584d8f90	true	display.on.consent.screen
2a6978d8-2996-40c2-b70f-f491584d8f90	${offlineAccessScopeConsentText}	consent.screen.text
051e8be0-fc52-4c1e-a184-bffdd192d8ed	true	display.on.consent.screen
051e8be0-fc52-4c1e-a184-bffdd192d8ed	${samlRoleListScopeConsentText}	consent.screen.text
4c237789-5d12-452b-ac37-419172627623	true	display.on.consent.screen
4c237789-5d12-452b-ac37-419172627623	${profileScopeConsentText}	consent.screen.text
4c237789-5d12-452b-ac37-419172627623	true	include.in.token.scope
bc544bb7-a832-41f7-b4cc-775206c29ce2	true	display.on.consent.screen
bc544bb7-a832-41f7-b4cc-775206c29ce2	${emailScopeConsentText}	consent.screen.text
bc544bb7-a832-41f7-b4cc-775206c29ce2	true	include.in.token.scope
25af5016-8247-4abe-90c3-bfd4e0297c45	true	display.on.consent.screen
25af5016-8247-4abe-90c3-bfd4e0297c45	${addressScopeConsentText}	consent.screen.text
25af5016-8247-4abe-90c3-bfd4e0297c45	true	include.in.token.scope
10aad80e-f081-4c44-adbe-9f7e99a8b925	true	display.on.consent.screen
10aad80e-f081-4c44-adbe-9f7e99a8b925	${phoneScopeConsentText}	consent.screen.text
10aad80e-f081-4c44-adbe-9f7e99a8b925	true	include.in.token.scope
21e15ba2-6475-4e24-ae73-ed0e2b224b11	true	display.on.consent.screen
21e15ba2-6475-4e24-ae73-ed0e2b224b11	${rolesScopeConsentText}	consent.screen.text
21e15ba2-6475-4e24-ae73-ed0e2b224b11	false	include.in.token.scope
2d5410a2-a71d-43b0-857c-111eed14c53e	false	display.on.consent.screen
2d5410a2-a71d-43b0-857c-111eed14c53e		consent.screen.text
2d5410a2-a71d-43b0-857c-111eed14c53e	false	include.in.token.scope
791c532f-6203-4ea0-901a-043acab9bbcd	false	display.on.consent.screen
791c532f-6203-4ea0-901a-043acab9bbcd	true	include.in.token.scope
407b0d8f-3acb-4f85-b6a6-4013c43b718c	false	display.on.consent.screen
407b0d8f-3acb-4f85-b6a6-4013c43b718c	false	include.in.token.scope
8a1bc266-1016-45ac-baf1-aaf2a72b33a4	true	display.on.consent.screen
8a1bc266-1016-45ac-baf1-aaf2a72b33a4	${offlineAccessScopeConsentText}	consent.screen.text
d9e489ee-6687-468b-bd43-82c773795734	true	display.on.consent.screen
d9e489ee-6687-468b-bd43-82c773795734	${samlRoleListScopeConsentText}	consent.screen.text
3333893c-e45f-4d79-aba1-7588d8664b70	true	display.on.consent.screen
3333893c-e45f-4d79-aba1-7588d8664b70	${profileScopeConsentText}	consent.screen.text
3333893c-e45f-4d79-aba1-7588d8664b70	true	include.in.token.scope
39b22340-8ec4-4352-85c9-ca4c87c2b35e	true	display.on.consent.screen
39b22340-8ec4-4352-85c9-ca4c87c2b35e	${emailScopeConsentText}	consent.screen.text
39b22340-8ec4-4352-85c9-ca4c87c2b35e	true	include.in.token.scope
2c73bcba-f990-4d3e-9800-10255453a27b	true	display.on.consent.screen
2c73bcba-f990-4d3e-9800-10255453a27b	${addressScopeConsentText}	consent.screen.text
2c73bcba-f990-4d3e-9800-10255453a27b	true	include.in.token.scope
46f28b59-b9cc-4472-9211-92ea9121335c	true	display.on.consent.screen
46f28b59-b9cc-4472-9211-92ea9121335c	${phoneScopeConsentText}	consent.screen.text
46f28b59-b9cc-4472-9211-92ea9121335c	true	include.in.token.scope
8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	true	display.on.consent.screen
8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	${rolesScopeConsentText}	consent.screen.text
8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	false	include.in.token.scope
50baaf2f-a7f0-4c34-9705-6b60d974d9bc	false	display.on.consent.screen
50baaf2f-a7f0-4c34-9705-6b60d974d9bc		consent.screen.text
50baaf2f-a7f0-4c34-9705-6b60d974d9bc	false	include.in.token.scope
3caf37ff-603b-45aa-8f68-7a6d1b8ce255	false	display.on.consent.screen
3caf37ff-603b-45aa-8f68-7a6d1b8ce255	true	include.in.token.scope
3b522a3b-ed69-4e6f-b3e5-78067a0fd314	false	display.on.consent.screen
3b522a3b-ed69-4e6f-b3e5-78067a0fd314	false	include.in.token.scope
d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1		consent.screen.text
d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1	false	display.on.consent.screen
d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1	false	include.in.token.scope
d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1		gui.order
\.


--
-- TOC entry 4138 (class 0 OID 16461)
-- Dependencies: 228
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
e154faf5-b5d2-4799-9bd6-8bdaa349601b	4c237789-5d12-452b-ac37-419172627623	t
e154faf5-b5d2-4799-9bd6-8bdaa349601b	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
e154faf5-b5d2-4799-9bd6-8bdaa349601b	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
e154faf5-b5d2-4799-9bd6-8bdaa349601b	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
e154faf5-b5d2-4799-9bd6-8bdaa349601b	2d5410a2-a71d-43b0-857c-111eed14c53e	t
e154faf5-b5d2-4799-9bd6-8bdaa349601b	2a6978d8-2996-40c2-b70f-f491584d8f90	f
e154faf5-b5d2-4799-9bd6-8bdaa349601b	25af5016-8247-4abe-90c3-bfd4e0297c45	f
e154faf5-b5d2-4799-9bd6-8bdaa349601b	791c532f-6203-4ea0-901a-043acab9bbcd	f
e154faf5-b5d2-4799-9bd6-8bdaa349601b	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
d67b2d04-0a42-4877-ad42-fb7ac325e66d	4c237789-5d12-452b-ac37-419172627623	t
d67b2d04-0a42-4877-ad42-fb7ac325e66d	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
d67b2d04-0a42-4877-ad42-fb7ac325e66d	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
d67b2d04-0a42-4877-ad42-fb7ac325e66d	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
d67b2d04-0a42-4877-ad42-fb7ac325e66d	2d5410a2-a71d-43b0-857c-111eed14c53e	t
d67b2d04-0a42-4877-ad42-fb7ac325e66d	2a6978d8-2996-40c2-b70f-f491584d8f90	f
d67b2d04-0a42-4877-ad42-fb7ac325e66d	25af5016-8247-4abe-90c3-bfd4e0297c45	f
d67b2d04-0a42-4877-ad42-fb7ac325e66d	791c532f-6203-4ea0-901a-043acab9bbcd	f
d67b2d04-0a42-4877-ad42-fb7ac325e66d	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
60de7067-1945-4c12-9242-6393e17cc14f	4c237789-5d12-452b-ac37-419172627623	t
60de7067-1945-4c12-9242-6393e17cc14f	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
60de7067-1945-4c12-9242-6393e17cc14f	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
60de7067-1945-4c12-9242-6393e17cc14f	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
60de7067-1945-4c12-9242-6393e17cc14f	2d5410a2-a71d-43b0-857c-111eed14c53e	t
60de7067-1945-4c12-9242-6393e17cc14f	2a6978d8-2996-40c2-b70f-f491584d8f90	f
60de7067-1945-4c12-9242-6393e17cc14f	25af5016-8247-4abe-90c3-bfd4e0297c45	f
60de7067-1945-4c12-9242-6393e17cc14f	791c532f-6203-4ea0-901a-043acab9bbcd	f
60de7067-1945-4c12-9242-6393e17cc14f	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	4c237789-5d12-452b-ac37-419172627623	t
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	2d5410a2-a71d-43b0-857c-111eed14c53e	t
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	2a6978d8-2996-40c2-b70f-f491584d8f90	f
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	25af5016-8247-4abe-90c3-bfd4e0297c45	f
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	791c532f-6203-4ea0-901a-043acab9bbcd	f
e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
2e527d92-7ea4-4944-ae26-b5a34aec87cb	4c237789-5d12-452b-ac37-419172627623	t
2e527d92-7ea4-4944-ae26-b5a34aec87cb	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
2e527d92-7ea4-4944-ae26-b5a34aec87cb	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
2e527d92-7ea4-4944-ae26-b5a34aec87cb	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
2e527d92-7ea4-4944-ae26-b5a34aec87cb	2d5410a2-a71d-43b0-857c-111eed14c53e	t
2e527d92-7ea4-4944-ae26-b5a34aec87cb	2a6978d8-2996-40c2-b70f-f491584d8f90	f
2e527d92-7ea4-4944-ae26-b5a34aec87cb	25af5016-8247-4abe-90c3-bfd4e0297c45	f
2e527d92-7ea4-4944-ae26-b5a34aec87cb	791c532f-6203-4ea0-901a-043acab9bbcd	f
2e527d92-7ea4-4944-ae26-b5a34aec87cb	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
3f12da87-c610-479c-a8b8-e17bd2941cdc	4c237789-5d12-452b-ac37-419172627623	t
3f12da87-c610-479c-a8b8-e17bd2941cdc	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
3f12da87-c610-479c-a8b8-e17bd2941cdc	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
3f12da87-c610-479c-a8b8-e17bd2941cdc	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
3f12da87-c610-479c-a8b8-e17bd2941cdc	2d5410a2-a71d-43b0-857c-111eed14c53e	t
3f12da87-c610-479c-a8b8-e17bd2941cdc	2a6978d8-2996-40c2-b70f-f491584d8f90	f
3f12da87-c610-479c-a8b8-e17bd2941cdc	25af5016-8247-4abe-90c3-bfd4e0297c45	f
3f12da87-c610-479c-a8b8-e17bd2941cdc	791c532f-6203-4ea0-901a-043acab9bbcd	f
3f12da87-c610-479c-a8b8-e17bd2941cdc	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	3333893c-e45f-4d79-aba1-7588d8664b70	t
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	46f28b59-b9cc-4472-9211-92ea9121335c	f
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	2c73bcba-f990-4d3e-9800-10255453a27b	f
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	3333893c-e45f-4d79-aba1-7588d8664b70	t
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	46f28b59-b9cc-4472-9211-92ea9121335c	f
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	2c73bcba-f990-4d3e-9800-10255453a27b	f
da400e9b-9d34-4754-bba8-475c01bc8769	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
da400e9b-9d34-4754-bba8-475c01bc8769	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
da400e9b-9d34-4754-bba8-475c01bc8769	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
da400e9b-9d34-4754-bba8-475c01bc8769	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
da400e9b-9d34-4754-bba8-475c01bc8769	3333893c-e45f-4d79-aba1-7588d8664b70	t
da400e9b-9d34-4754-bba8-475c01bc8769	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
da400e9b-9d34-4754-bba8-475c01bc8769	46f28b59-b9cc-4472-9211-92ea9121335c	f
da400e9b-9d34-4754-bba8-475c01bc8769	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
da400e9b-9d34-4754-bba8-475c01bc8769	2c73bcba-f990-4d3e-9800-10255453a27b	f
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	3333893c-e45f-4d79-aba1-7588d8664b70	t
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	46f28b59-b9cc-4472-9211-92ea9121335c	f
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	2c73bcba-f990-4d3e-9800-10255453a27b	f
1f8f4c4b-515d-4cae-ad55-371f83967386	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
1f8f4c4b-515d-4cae-ad55-371f83967386	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
1f8f4c4b-515d-4cae-ad55-371f83967386	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
1f8f4c4b-515d-4cae-ad55-371f83967386	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
1f8f4c4b-515d-4cae-ad55-371f83967386	3333893c-e45f-4d79-aba1-7588d8664b70	t
1f8f4c4b-515d-4cae-ad55-371f83967386	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
1f8f4c4b-515d-4cae-ad55-371f83967386	46f28b59-b9cc-4472-9211-92ea9121335c	f
1f8f4c4b-515d-4cae-ad55-371f83967386	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
1f8f4c4b-515d-4cae-ad55-371f83967386	2c73bcba-f990-4d3e-9800-10255453a27b	f
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	3333893c-e45f-4d79-aba1-7588d8664b70	t
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	46f28b59-b9cc-4472-9211-92ea9121335c	f
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	2c73bcba-f990-4d3e-9800-10255453a27b	f
daa819c5-ca52-4936-8800-7116fdfe0d54	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
daa819c5-ca52-4936-8800-7116fdfe0d54	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
daa819c5-ca52-4936-8800-7116fdfe0d54	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
daa819c5-ca52-4936-8800-7116fdfe0d54	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
daa819c5-ca52-4936-8800-7116fdfe0d54	3333893c-e45f-4d79-aba1-7588d8664b70	t
daa819c5-ca52-4936-8800-7116fdfe0d54	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
daa819c5-ca52-4936-8800-7116fdfe0d54	46f28b59-b9cc-4472-9211-92ea9121335c	f
daa819c5-ca52-4936-8800-7116fdfe0d54	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
daa819c5-ca52-4936-8800-7116fdfe0d54	2c73bcba-f990-4d3e-9800-10255453a27b	f
daa819c5-ca52-4936-8800-7116fdfe0d54	d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1	t
\.


--
-- TOC entry 4139 (class 0 OID 16467)
-- Dependencies: 229
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
2a6978d8-2996-40c2-b70f-f491584d8f90	bb6bacfa-ce21-46df-9407-a26791973e02
8a1bc266-1016-45ac-baf1-aaf2a72b33a4	13cf3361-0704-4115-b5ea-bd3059e120d2
\.


--
-- TOC entry 4140 (class 0 OID 16470)
-- Dependencies: 230
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 4141 (class 0 OID 16475)
-- Dependencies: 231
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 4142 (class 0 OID 16478)
-- Dependencies: 232
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4143 (class 0 OID 16483)
-- Dependencies: 233
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 4144 (class 0 OID 16486)
-- Dependencies: 234
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 4145 (class 0 OID 16489)
-- Dependencies: 235
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4146 (class 0 OID 16494)
-- Dependencies: 236
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
bfa18352-d46c-460b-b7d4-4f7796d4c865	Trusted Hosts	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
d348092c-cd20-4790-abe8-ad914b58a74f	Consent Required	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
baf85cf8-34b1-413c-ba01-83bc7b81da64	Full Scope Disabled	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
393c8b74-47de-4df4-8498-0b0e2c39b2e0	Max Clients Limit	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
1e14436d-d113-4a4c-a839-db774fd634f0	Allowed Protocol Mapper Types	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
e335f9a5-ec6e-4aae-aaa8-7df9d493e22b	Allowed Client Scopes	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	anonymous
c4c50f4f-22d7-4704-819b-e0615294a0da	Allowed Protocol Mapper Types	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	authenticated
d002a83a-87c2-42bb-877f-c4503895ba77	Allowed Client Scopes	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	authenticated
833210ce-f3e3-49c3-9755-03ee5c10377e	rsa-generated	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	rsa-generated	org.keycloak.keys.KeyProvider	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N
f1016501-6504-4949-b3f9-ba679c60ddba	rsa-enc-generated	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	rsa-enc-generated	org.keycloak.keys.KeyProvider	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N
a33a85b6-35a4-4906-890d-150df1d05881	hmac-generated	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	hmac-generated	org.keycloak.keys.KeyProvider	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N
f62ff7d5-395d-4c9c-8259-d0a90e30cb69	aes-generated	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	aes-generated	org.keycloak.keys.KeyProvider	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N
6733870f-f006-4cc3-8b24-ac2636be8c89	rsa-generated	f22bc560-708c-401c-ad05-2dbb1cda77dd	rsa-generated	org.keycloak.keys.KeyProvider	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N
268b7d89-5fc3-4562-ad9b-41337728390d	rsa-enc-generated	f22bc560-708c-401c-ad05-2dbb1cda77dd	rsa-enc-generated	org.keycloak.keys.KeyProvider	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N
d81bfe7f-9b4e-43f1-9820-36e6604a51b5	hmac-generated	f22bc560-708c-401c-ad05-2dbb1cda77dd	hmac-generated	org.keycloak.keys.KeyProvider	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N
3e1b48b5-dffb-48fc-bfca-7d6dbd7d5b48	aes-generated	f22bc560-708c-401c-ad05-2dbb1cda77dd	aes-generated	org.keycloak.keys.KeyProvider	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N
a51270f9-c91d-4227-b71c-b9643177a88a	Trusted Hosts	f22bc560-708c-401c-ad05-2dbb1cda77dd	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
bf932ca6-0107-401e-8665-1565df38c4c7	Consent Required	f22bc560-708c-401c-ad05-2dbb1cda77dd	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
bebd69f1-b2c7-454c-9857-4377b0df0fc5	Full Scope Disabled	f22bc560-708c-401c-ad05-2dbb1cda77dd	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
3c0b019d-e495-4eea-96f6-339d6cd71d93	Max Clients Limit	f22bc560-708c-401c-ad05-2dbb1cda77dd	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
5c010e9f-92de-480b-a618-04ce3161fd33	Allowed Protocol Mapper Types	f22bc560-708c-401c-ad05-2dbb1cda77dd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
b948d442-c066-46a4-8f7a-57c9c2525134	Allowed Client Scopes	f22bc560-708c-401c-ad05-2dbb1cda77dd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	anonymous
f9fe4f60-8fc1-4b49-91f6-822b1f000325	Allowed Protocol Mapper Types	f22bc560-708c-401c-ad05-2dbb1cda77dd	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	authenticated
1669db8d-c7a0-4ca9-80bb-cd4a002beeb6	Allowed Client Scopes	f22bc560-708c-401c-ad05-2dbb1cda77dd	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	authenticated
\.


--
-- TOC entry 4147 (class 0 OID 16499)
-- Dependencies: 237
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
e355a4ce-e4c4-46f9-9219-1e2b24e4302b	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
eb162347-de04-41d4-affe-939f30a954c2	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	oidc-full-name-mapper
3b2aa89a-09b3-4a7e-b311-b081b6431bb3	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	oidc-address-mapper
299d1b85-54d6-4192-9732-0e4bc8ed120b	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	saml-user-property-mapper
d9a624a8-33dc-4300-9d42-0a71cca1e6df	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	saml-user-attribute-mapper
c1405275-d8ee-4ba4-8f2c-5a8fd61f2257	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
d24f3e05-4fc7-4b14-8289-1133d9ee0769	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	saml-role-list-mapper
2c573012-92c1-4cc7-bc7a-112539bad4ed	1e14436d-d113-4a4c-a839-db774fd634f0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
9734149b-bbb1-401b-84fc-fccf25f6818e	393c8b74-47de-4df4-8498-0b0e2c39b2e0	max-clients	200
ee5a3ebb-8f49-4a78-9705-3904395d3e53	e335f9a5-ec6e-4aae-aaa8-7df9d493e22b	allow-default-scopes	true
c78eaa63-3521-4340-b92f-5c6cee3c5b10	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	saml-user-attribute-mapper
9f55dddb-121a-497f-9d80-e49a9223ae7e	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
a89eb956-5b41-4cf2-a119-a092522553ea	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	oidc-full-name-mapper
cee18b01-88c4-43e3-bc2b-0ff607a55f23	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	oidc-address-mapper
7bcb841b-027d-4127-afe8-99dd121fca49	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	saml-role-list-mapper
c2a70039-6038-4692-bcb7-38a58a8375fe	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
50bb8f96-fdd5-44b6-aa99-d8d028466446	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	saml-user-property-mapper
d13ead58-a542-4250-a154-3ef693b8874e	c4c50f4f-22d7-4704-819b-e0615294a0da	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
da7a7f5f-c527-4fa4-9dbc-92ed6bcfefc9	d002a83a-87c2-42bb-877f-c4503895ba77	allow-default-scopes	true
07577028-d15d-4065-b858-546834330488	bfa18352-d46c-460b-b7d4-4f7796d4c865	host-sending-registration-request-must-match	true
189c6766-8c86-4ec9-aaea-0a812adbd387	bfa18352-d46c-460b-b7d4-4f7796d4c865	client-uris-must-match	true
c18ee8d7-7ae3-4120-a53b-bf86cdffc98d	833210ce-f3e3-49c3-9755-03ee5c10377e	certificate	MIICmzCCAYMCBgGKcPGGYzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTA3MTgzODExWhcNMzMwOTA3MTgzOTUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCpI2dNqIIKmoR80gERVodXVc4wFJVOHOXouoj2jAhWRB4mtpN805wauKvsrfXidO3mNSGpD7X6xz802mhk+uA3LyA4ZIafZCfAWH8jvU2xE5a5wzylmFLa7Kw48XaFzqzw2X369eiu9zjanMXGmPsV1cKX2HTSevQmgrhj3Xq6h25t6bOpxhyfAt3smunLct5uz0Jqq6yr+o/5KUMCIBkuFWPcOsHp5COYkRXbKYOfjYmDKM1U1OoaOgSjoo6gwSLvGM81SSNGXJ4Sl/f6zIjz7YiaUizSfHNsCOX+uJYDklYDwn/pb1BRqAme6Ln2gRtMiKUI7ec9YkoFhx3JlUk9AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJaCzecjD2tAlHrtgWCJSRQQIP41EB/ZwWkT/dwQFlcwDU+HTlFZI956CAfC1vAM+1foycs/ISiuHSq+RkoeqZbPoK/v3V78Y9TC8qr87Eu8jOkA/b+F+ed7ptT3KRfediiBdIuUhIblcd+T7X4Qjp3ndVv5R/wicgbzkfWbI5ZDVv9+BqLptREiU1lk7bXP/CXmczeV4ADeGS+HxF9K+S05S8vSNQRj/0cMSXVIzrRoqeXhw3qY+2vOb6f4R64TfBTLAHJOo2aEw8G4g3gB2DUjJZD62dGqQbGfz6lwd+ftV7AgiBr9Nlo+s7mD0aCDMCftAJg4SEE6/bxZhklLaFY=
2dfcd657-a4d0-456c-a081-a356105d0581	833210ce-f3e3-49c3-9755-03ee5c10377e	priority	100
69d9ef25-7c75-43b1-a4bb-7551842f3eda	833210ce-f3e3-49c3-9755-03ee5c10377e	privateKey	MIIEogIBAAKCAQEAqSNnTaiCCpqEfNIBEVaHV1XOMBSVThzl6LqI9owIVkQeJraTfNOcGrir7K314nTt5jUhqQ+1+sc/NNpoZPrgNy8gOGSGn2QnwFh/I71NsROWucM8pZhS2uysOPF2hc6s8Nl9+vXorvc42pzFxpj7FdXCl9h00nr0JoK4Y916uodubemzqcYcnwLd7Jrpy3Lebs9Caqusq/qP+SlDAiAZLhVj3DrB6eQjmJEV2ymDn42JgyjNVNTqGjoEo6KOoMEi7xjPNUkjRlyeEpf3+syI8+2ImlIs0nxzbAjl/riWA5JWA8J/6W9QUagJnui59oEbTIilCO3nPWJKBYcdyZVJPQIDAQABAoIBAB+rHhC7jAuttkBDtsj3BVS8H2S/udvcC80ZPgNBoV77lpSjizZsTZZwPNqOENOTlqaLjK+hni5kB4jfGvxLP9d9RqBgbBdkco/wUe/QZj9RPl+uN0j/HgZZGX748PrpQVbANjcau3QlHFtMTriaVKrYMPzq3aa6OEQMpjcmlS/e1S4pqguvlMCx1hFsWeF9U+r08TY8aNWa/tTrh79zfiNale6Dlhi9d3Tj4fz0tCw3GNYK1vu9ytLhswqcGCjwodhiNYX7wgvFOY4ZqrePtIG9VUdHDiztVa/LpQBbKkgmq/YjKD4WWAbwoXCsDd8SkOdCBLdoW8cpkC6OIFu6UYkCgYEA20JhPlnrGHEGM29G3AHwckb7JVlXPwARu8iLGpeIRaqtxgr9oKkYqQfV1mAkZDdY025aBgC1k+9OkngBwuJeYXZoNzd7WfGWK3IwO4lz4BZDL7VFU6ahqsZ0NEUZtbM1u/+ug+2rbwm4qrdOSW7+387GZ4CRju/T4TMf9cQR/kUCgYEAxXr4gHdUhtd5Gc6dsqGZolMcaia/em8VNc7RFHzdG++VTLY5/jPKd9HXgPNosoGAXP63PBBO1DigP450698U8qedKtbiTIvHb+myOYUUKo3miRhy32uG8ekMgd3ATkIvwUyMD8bobHhxS5G07ycBN+wU+LwH2PJXz11KF175KpkCgYANdm3yHiNJROdUkSiQqa3R1nnlOS8aNy7fkNi5sUQ0wt4YouQf0UIqXsjKeOzDGoLhuIzegXyksLTqWWQCS1PwOAz+FvID+8l0sXY0saPjxnopm7+9+yVCDx1jeDqz5WUPPgvBHf7AuqAUG107NQ2BQHj+Me6+EAu6cCEuPfO84QKBgDIu06Nhr5sseluyg6R3KGF1mUzoV9Q3Ej7ANaVtLYsB0QDTdd1BL/xO2OKt+DcUbZg0KkAbLM0FLsO34cJmyB35thjCznMBOkcYLfAr/znpIWJJUjewTXR/8mu1/D5m11fZqeYAd+PIn5HCjyYO1WJunc2vipb4zpOlc0SJH+xRAoGATZHl+Fa3euDDIWLl5vwtp4CLEhcWvtxRcjoGdQOTYZkyyDw9/KGT6FI4bwd76AzzrHIKQDX1RzqgQHYO2LnvXNzG9OECLuL0d26tRlYXTm+LRKyOAKCqPGDigR/9pEpAJ35ntBf9rQheacQ5l3b6lRqbk+Gy6HcMgitMhb6YL8M=
fab2c556-b84c-4152-8f00-fcbfd27944de	833210ce-f3e3-49c3-9755-03ee5c10377e	keyUse	SIG
edd9c404-6e78-4e86-8c8c-b34039beba77	f62ff7d5-395d-4c9c-8259-d0a90e30cb69	kid	901adae8-50e8-4317-b6d1-124e3b551bb7
b798e2e5-e832-47dc-ae8f-925268f9d438	f62ff7d5-395d-4c9c-8259-d0a90e30cb69	secret	zf3-Bw9zqQwPQN9iTF6q6A
eda6af59-0047-44a5-997d-1706266c42e1	f62ff7d5-395d-4c9c-8259-d0a90e30cb69	priority	100
c79a3c31-e45e-4dbe-a66e-39c83328051a	a33a85b6-35a4-4906-890d-150df1d05881	secret	tGeupxihuHKHwI43v6gABs4Prv1fFt_AQPfBiTRdZrtzSs_K6yTL7Ws0XLHOL4qqoPWHzFqY6mIbEy1hMQW8Fg
235b13d2-ed93-40fa-aa59-4303134d7851	a33a85b6-35a4-4906-890d-150df1d05881	algorithm	HS256
d8ffab6a-e8ac-4c0d-8a8f-44f7798bcc2e	a33a85b6-35a4-4906-890d-150df1d05881	kid	15b0dd09-7588-4c94-bc89-e54f7a3b4359
99d960fe-fe41-44fa-a3d3-15b103ea9a93	a33a85b6-35a4-4906-890d-150df1d05881	priority	100
1e6913e2-2310-4d4b-bd1b-a1e248ce7f07	f1016501-6504-4949-b3f9-ba679c60ddba	certificate	MIICmzCCAYMCBgGKcPGG/jANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMwOTA3MTgzODExWhcNMzMwOTA3MTgzOTUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC6MT4t3ECzAIhc0R3suj3xfm8mY5q5jEVls4CZxIwK5O3Hyg1cX+F9bHo6b0VPPXCbU9ak73Frja5CWBwfwcFQMaIAjdtxlhI67RcNJtNxVDRdvKGC0ui6xJWgoKrOhP8R4GfFtpLFIeFYxPRrhMFXR/QIyOOh7D4Y8fnY+vw0DAyLjFEYxJrI9dKZKFjews3558SSuy51U35nrH4b/aE3sa9zNK1qWupP5rZ1w3McQy1g66D53vOpT7F+e5X3bC1QftGyVvqEahF2cJ4hP1gFa7Agm6zDCbykZfuofLYM1TmrsedRrGBAYsE9Jlm8rkxhK86c+F6W0RqVSjou0dqLAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIpjYnGB2SAXS9ByDADdiZ/UCdiubZ/WBZ+j89u3pc2vyf7wwDZlkHPCVMqfJ6r1ezZiFuqVNrEbzx3Slqa1pxbaQl6ikKxgRHdO4qrwwzwUKSTl0sKaIA8kt1epsWGPodH49dS4Tz5slemGUz6tzXEa2bU6yBjE4vcrUxCnBk4/U4q+MrYmrw8GpUkEVYpfPbZIUvlbyv/Vk9UI77P1E3LdbJYZl391/m7LB8CZAmh91oX7Ba+vtlXSjrvcig1mPerq12CAVfmAL+IHgrlPs5iym085ekWI6QsXMuMcoAWYyswlBpaTBDjZePARj4sNSUMfpnfxwYldSj+LX1/ADB4=
6eafe14c-f72a-4b73-a1c6-996b3c44ac1f	f1016501-6504-4949-b3f9-ba679c60ddba	privateKey	MIIEpQIBAAKCAQEAujE+LdxAswCIXNEd7Lo98X5vJmOauYxFZbOAmcSMCuTtx8oNXF/hfWx6Om9FTz1wm1PWpO9xa42uQlgcH8HBUDGiAI3bcZYSOu0XDSbTcVQ0XbyhgtLousSVoKCqzoT/EeBnxbaSxSHhWMT0a4TBV0f0CMjjoew+GPH52Pr8NAwMi4xRGMSayPXSmShY3sLN+efEkrsudVN+Z6x+G/2hN7GvczStalrqT+a2dcNzHEMtYOug+d7zqU+xfnuV92wtUH7Rslb6hGoRdnCeIT9YBWuwIJuswwm8pGX7qHy2DNU5q7HnUaxgQGLBPSZZvK5MYSvOnPheltEalUo6LtHaiwIDAQABAoIBADYM74D+rGWKZQuUxTwggLTnQDsDtTniB49TgaSh0wmilYhnFmPXja0MXZszDArJyjO9LdVpkSJo2cp2q4togsbV8bJ5e9fIefhTNVrjB4ShriX8CWLh+R+my8z6dztGjolQ/K7/pjHF+RX87vt7aWj+AVC/iJ1L6Gbzb9VWXvp4eXuOMbXrIFhAmr9+TBLnUrcVSVWa5xHLFTYwTgwA3EhLozvzCtG2ofYI+oSX5BRuwXRZ4g5cS7amq3bBguiVptDvzD5xfYR2Fcq0aZmejKzs9Ldc3cRXL1/7OvwyxIcgZkYiI49GbzUcVWV9VW+ntoNn/Z5DVzUjyKVNYb3gGrECgYEA8v+8SZN3ktnM9PB+Imqg3BRZBmN1yXS2zepez/WuvThZ8s4BuVlDkUxq0iUPsimPAD/MpQzqJB0wWMc/VfByWgHyAigPXf1ixK1NFGdznLoimXScrCGAh24K3YUImgFp/zBP7r51OkdBCXBPa1dbBpTZ4MgzGMfdpmSW05AKvdkCgYEAxCdy5Z+i7jAV3bKpfe3ZnFaPlcOsgxgTxlacTOYtn6OS8xSOl3q90OW7zOF0wdhi2ZD53fSzw3bwBTPFUTWQ/3mS8bcQlyi/cQ1pZbeWR874ffgYZGQOZiLSunbbZr17mVbl4lOmQuVsxMK5bFt8qTWUUgxACejMz6mu4QoNCQMCgYEA2e8kVjSM5Ea0O+VIquNIu7kAEuu24uPrY4hUWly0x/23Jj0+bJYzNCf+EdStXBNLrmSJzGllwNfw2V5xXkkUtcbS3r5A8gHjyBLJc4hItwJ1L33XWcV+OXgnBH9gtIaaIwWYWr2z832eRbHVeKbS+3caZTAIK6xtDONgJgQkrhkCgYEAqeb5kIermuCvr+4W/WrN+KrJiBGLFan/RuayT7F4hzQqDr8Zm3/Hdm/nMVl/xn/lb0oyA9z28DHPSNJE8UiSpZbqfs/wYN38pLHXPzG7y8ssVgBVMG+yQSmcmcJl3CH4MyOfz2BhPMR4aB26em7sFazBIihWN78b2CvDvEz2aX0CgYEAhjMQ7uoDesggQeigxpTtD8duvToOBVqWPNBKEijr/8gK3Fgf+1OadjJEuVgim9LhctNUmDVndqeZhjOx4U7UfDwPni+oTcDzO0yn+33jEIgHfH5fkYdCQrpldRBe5J2kxMI03NbFnyCuVQjZxGxzs4kRL/YkEj0yxOUIrJXSjXQ=
2d9578dd-bfff-4b2a-93f7-0df466bc9372	f1016501-6504-4949-b3f9-ba679c60ddba	keyUse	ENC
59e9da35-3b61-4f8b-9f7e-0cdc71d32920	f1016501-6504-4949-b3f9-ba679c60ddba	algorithm	RSA-OAEP
23537080-fd3c-4a3b-bf6f-c1764c6064b3	f1016501-6504-4949-b3f9-ba679c60ddba	priority	100
b9883802-fbc9-475a-9f08-ea6cb94f5242	6733870f-f006-4cc3-8b24-ac2636be8c89	privateKey	MIIEowIBAAKCAQEApoilFbQoSZ2LlnxG/bi84TrsJix8KQfdhqe7ojw2MBeD08tx4Qsp4dGsDDdxcM6OoYxZWJ43y5D+aRTM1EZh9p6IrYiq2yQG2Om2OaO+mUvGEzgCJwB7Kd/h3XMv9tDYcXtSVJaroo+ykpPy/U0v4nHY2hyR21zuX6BIIL8INzTodurZbfLLuRZCWP2Xj2RMlLUyj6vZIioaIBaPTRzTj6AIg4/epllmPLpiFueSr8n6oftjPSE0AUSXTGk1dtzAbAEetwOtoBQbVwiDfsXM4qWQwGTzggFd5XvT8CHFcdHNlI4pIK8lLvPRUVJEWo3us/uX0ftDH9a2LaGx+UIuwwIDAQABAoIBAC0HaJ/gOT6Cd2Jm0yk6oPPDo2PFBoNvqYIF65G39yz0xsPnUDD5/Eafk4YwHZ/TcjSTRvtTuKF14JyYL7Q8HbP59Nn7SLt9V86iDxAxytEXcIT00XwrQKI3c5KV2UPC/6tbnYzauqj3cuD4WS0NiGORxgFf1T57t8aqh6Y3ESkf2MW4wCvIWMEtK/ujjSL7qFKIqIIUaPci6MQY5LxeJ3EVeUSvjrPOz/hjC17zNB9ocHhwOxPi3WQO2rMQKLsbiYCWMxQ6WhyeopaaBxvEJPjjOXpJPiV7ADWs/BK74ScRv0avO/a1DZfEW5uME0FdwKqVcI4d83Rq7EHMaqt7lqkCgYEA3YkwYtgpgs51v8q8kQzttkNqK/ieFOBN5kZvhxwKAB1MEhoI3pEmMthOUT0AZbVm8Mk7OikM0ggJoZnz6LLkCZrPQelnF0a3BbDzweaR5RRhTUhrehHWKZykCpK3HIBOuhNY6Smv19gkSbnP8vH23hpJDavECtSqZx6r99j1eOsCgYEAwHD14E3vpafgtyEf0sL4U8JyJ1KOgaEOt18XyFABU6RMv6Z4/SFkhkMScz8mi17Eje0NZhAWAtvObv+reFyAYyQX5lE4fymsCCyGs0fvIRfRgmXMLZ6VWPRdKv3TFMmgZc7DnlDpjkO0sJXUoyQG1H92AbGRJgrWUDB1enJ/K4kCgYB+6EMurJQDGhC8IQCqu1RFsBLXQ6ITZXdargjfxkE4VZApYn6oOVA/mkgrI53hpexljXF/XNq6St5xk8b1C920XtnR8UocPGdGPFs3PcVgDK+83PqswCEGT3RtliSNkDcJQ2IQl8/i/y+yiF5G1zPLghVNXpN8fN1tG1X6MnBUpwKBgF2Zk73ZqmokUURBND1K34W92dAOc4nRUFsYQXUIlNyd2UaOLeLQzxgOn3a2jITVPzzYw9+Ui2AwkSOj7z7HnxqZf5Zigtw25JnFLm8c2c56y0hlQv4dV/7APGCgvH4r43whKTxjlnW/sK8C8T24VCofJMKGH1clhj/SkhFQh1IhAoGBAKHZWLpfIt8rBcCDNDBWp7dK8q3lKZIn2LfU8mm/OtQdufhzO130V3sdiAhOAxo5Pl4EGsIqfoRQqVJWTYWbRhrPZ61fN8u5JNgegAzaasy3UBgs2J0wwkGzSR5hTgqjpTkWHUFD7+uKB7ek5mplmXA8vF9k9Zs6TH5G+WL7/Kxp
85301d57-9a3a-483d-954b-58d3dcf6c75f	6733870f-f006-4cc3-8b24-ac2636be8c89	priority	100
4e1544ca-5f31-413a-904a-3a33e22c42f1	6733870f-f006-4cc3-8b24-ac2636be8c89	certificate	MIIClTCCAX0CBgGKcPiL6jANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANhcGkwHhcNMjMwOTA3MTg0NTUxWhcNMzMwOTA3MTg0NzMxWjAOMQwwCgYDVQQDDANhcGkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCmiKUVtChJnYuWfEb9uLzhOuwmLHwpB92Gp7uiPDYwF4PTy3HhCynh0awMN3Fwzo6hjFlYnjfLkP5pFMzURmH2noitiKrbJAbY6bY5o76ZS8YTOAInAHsp3+Hdcy/20Nhxe1JUlquij7KSk/L9TS/icdjaHJHbXO5foEggvwg3NOh26tlt8su5FkJY/ZePZEyUtTKPq9kiKhogFo9NHNOPoAiDj96mWWY8umIW55Kvyfqh+2M9ITQBRJdMaTV23MBsAR63A62gFBtXCIN+xczipZDAZPOCAV3le9PwIcVx0c2UjikgryUu89FRUkRaje6z+5fR+0Mf1rYtobH5Qi7DAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADUPBOZzSgDeWobPVkaob3r5FtjtUt9Y3bsKa4Hoy8+uUXaxIzFMV6AhFrASJuO1Vwffdr3zKAQuyxSSCTl1z1R9FtW2sCY4qjDQyM/LebtHzf9cs9cGmZyhdL3R+AOFHgusQaN0ulFhezeUe1M4Iy8pAqFmnLh3l8ggA0+1mS49qEeKsWjmydCf/X3SXzMES71DBBdctQ9FBSKJ48pBwupbA/B/HrvzwAzS4GksgRgolE27i4w/pJXj51NHQkoLx9YSw/hy6vEuwFmmH9k4p8t7e2b+HBoaEdcCvPWkfjb26tZ1nPFELAWE37zWm/03CFdm15THCLm+QUOkAA+yFR8=
81f7917c-c850-4fbb-9724-2fbe643013fb	6733870f-f006-4cc3-8b24-ac2636be8c89	keyUse	SIG
f60b951c-92b4-4bd5-ac05-bf638a6b2aff	d81bfe7f-9b4e-43f1-9820-36e6604a51b5	algorithm	HS256
6488c3aa-22a5-44e5-bc84-2d5b50624461	d81bfe7f-9b4e-43f1-9820-36e6604a51b5	kid	06b81650-14ec-462b-b5d6-e964abe64d82
c71be045-75b4-499b-b088-d4f973a2a4cd	d81bfe7f-9b4e-43f1-9820-36e6604a51b5	priority	100
64707630-529b-46ac-9640-253d8832ae43	d81bfe7f-9b4e-43f1-9820-36e6604a51b5	secret	9VuBo9-J3Z2OeXYC5ItAalrwPaPKv62ZHmtn8Vf6bwd4HQt3BEY8bA68A3GzrWhRKIAG7ayDvfJ1b30uRWZlkw
3a141f46-3090-444a-b5e1-21073c475147	268b7d89-5fc3-4562-ad9b-41337728390d	certificate	MIIClTCCAX0CBgGKcPiMCTANBgkqhkiG9w0BAQsFADAOMQwwCgYDVQQDDANhcGkwHhcNMjMwOTA3MTg0NTUxWhcNMzMwOTA3MTg0NzMxWjAOMQwwCgYDVQQDDANhcGkwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDO3PeIxBWwPQoTQMTnMozK0RunOoMYOUOh8RCVruxshQ+cimgxkgFX+C3isigL09cawtGmDi4XGPhlvTC0nfs/FAZBR5f7ud48vASATQ1onjg/htyw/irlvc3tjE4k0+O9u5nM2rYniag5YMUCSbJmwdt2kRzbPvBhaTrBUz0O+MhwvzJQ4sNGrZGS0Ol8fU+Y9lLG5OeaCU9SsM7rrkhOY8UpYbKFdakXzZOQW/eNKhi7JZny8avWPlGs4UGAvFFrYE4u6CcsHCaN3D//cK3JjwOxpJ9WaC6NmVpPieKDCQaFsltFOSN5FSyyDm5jQULVOuKXqdjSn+r1LPs51Q1dAgMBAAEwDQYJKoZIhvcNAQELBQADggEBACyT3+9qdV+OZH9RnpwJLhzPfZ0bE2j0QqRgP5T1wxH/6iUQ+of6lONQJoF9LJOPjVS2eetZDvuKhvifeDHwlGUoR7iWRMcqtIpJi61z2Ci+mMEeg9rVZMOLOEaHwOjmehZIFG6xzCUSXZrQLL48nk8JM3yNVUzepxgVS9ssjAFkLRlupd+3SG4LQ4a7sSOeZVlggYvcTE2S4YabN200XFc5uYzyYHkDXbmSavAkwqbGa/5RvpS0qlJMcm59odWu2m07fdj0biW0UaDY/XfmZn50zjLBVMvihnaW+Y3Pdd+i3D6C35zg60AOfkU6bBEKokRP4+24qIzOBJqUMlFVfyc=
e4fa90e3-8671-4370-8491-d6df92663e91	268b7d89-5fc3-4562-ad9b-41337728390d	algorithm	RSA-OAEP
6679d6f2-b65a-4c78-9834-2f9e10bfe31f	268b7d89-5fc3-4562-ad9b-41337728390d	privateKey	MIIEowIBAAKCAQEAztz3iMQVsD0KE0DE5zKMytEbpzqDGDlDofEQla7sbIUPnIpoMZIBV/gt4rIoC9PXGsLRpg4uFxj4Zb0wtJ37PxQGQUeX+7nePLwEgE0NaJ44P4bcsP4q5b3N7YxOJNPjvbuZzNq2J4moOWDFAkmyZsHbdpEc2z7wYWk6wVM9DvjIcL8yUOLDRq2RktDpfH1PmPZSxuTnmglPUrDO665ITmPFKWGyhXWpF82TkFv3jSoYuyWZ8vGr1j5RrOFBgLxRa2BOLugnLBwmjdw//3CtyY8DsaSfVmgujZlaT4nigwkGhbJbRTkjeRUssg5uY0FC1Tril6nY0p/q9Sz7OdUNXQIDAQABAoIBABg0TilcSi5eIgLpMfDcXxFvILVzOPoZXzLAXmCpQEQdWJuILVNZgls88H+FOX7SyWk58OZlY9qzgwMCfUOw9YAms2mpexzK3XhNRpiNi3tZgfra6JE0GChcCk+Yel9ARLZDUGZiE+yx5HNcQYj4Pw3bcnaf2ZjEt0MqmSOcPfl1iCyn3bg/C/VMaEyrtHP8vyhCPvw/q1Q/TdLim1G/2mDsOggjLVFU0FLKA2mtkUqmhr/vVV59cBBtLcU8emWlkqfA6yCPpFx6orQkaE/50k77V571ry8piShn6S/DU9ao6kt5dqzAvoR7+86rNK+yb/7GcxBGjCroFf7Cen8lj7ECgYEA81iuXTxR68SxXYbIAC3q+Qr14ytx0A9WbdHnlyZt77oFuGjtlKJ21I+UGnyl1bsf2WgkIwIDU2+CU4i5Sx7zehnYBYBTOSi7wAkDr3wRGJ+NCcOeup31vZAMyQroOOartrlzZh5XQ3nXIagF2MvNFO1PMh/j+38RoCEYtY+r8Q0CgYEA2Z6jD2p0eZX8ppYYjD3QeFKlv1Z0neAGXVPvtisvVRcMEUvtOoFVUvSYgvo5HepiIpkm5SP/unsbf7vnrSHlaHaHNhRFIHyDEood8nmrtNGvKa83fVFBv3Q+vKl6G2KiZvqIe1d1l4uU//EvzrlTlvfJ18mE7wv0WgpJuow0WZECgYEA3+S1+N6o2O3N6qk5lsCosp6dAXhVbQLPmJdKJ02aVLiozrTr8pdQEd5Qe9Y3lmBmu1cP+I2/laLBHC5tnWpKxgrFMLqS18JcjCE/HNRfvnH+B//OKRFwqgrBWLAKXWAOmT4jqM89pr2RbEv1pTRN6nU1Kn8g+aI+C0CoRVR89HkCgYAJgbuf3ceu1BWQdXgnEEA+MWYaQL2hc/rzMsqDC8nqjrIxQz7e0m2WzSaoeiPqoaWd21Duq67tR5mA8AWD87og4SSxARuv+qCDO9NpF1Wf9ZUQXh4vdFBJ+9sNxN2XuqxbkVBLCxwQ/cEJmVC8WC5FpxeDPMN46e3HzTFBXAShcQKBgGmc0M+htRIYlcAp+4tzEetWpT/+gKoBeK+nC2bHVLcaW2kIE2MjRFPrSigjyvqfqhDNxU7EwjscFty5+M4z1Xwi7vibA1a2xJY1NTJHAmgY8AZWGPYFP8at7HQcZDCD3+xphRc4jBvoCmlXzHaOykB357N98mgC5Uid1QL1tAtN
3a2e4a97-fd2d-4538-a82b-304f26edf838	268b7d89-5fc3-4562-ad9b-41337728390d	priority	100
165196d8-609d-455e-96b9-a0a6b9cc2ef3	268b7d89-5fc3-4562-ad9b-41337728390d	keyUse	ENC
3d7643e4-5901-4212-8548-a2be474e3d24	3e1b48b5-dffb-48fc-bfca-7d6dbd7d5b48	secret	PUIQWRQ2Esa9OZy_O-WS8Q
af2abcf3-180f-45f6-bff2-be5ab4500955	3e1b48b5-dffb-48fc-bfca-7d6dbd7d5b48	kid	6df5ab6b-2fa4-41d2-a4b3-339d63798db6
cd03a824-5971-4238-a9a8-9ea8d69296ba	3e1b48b5-dffb-48fc-bfca-7d6dbd7d5b48	priority	100
94f98f1f-3311-4f06-9c4d-75d1f078bd99	3c0b019d-e495-4eea-96f6-339d6cd71d93	max-clients	200
24d055cc-e20f-4c57-a202-345bd111dcd7	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
9f3a2336-d2b3-4373-86a8-ce89d4825f9a	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	oidc-full-name-mapper
2b4798ae-b815-422a-b0a4-8b40ba9f27b0	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
242787c5-8ae7-4f54-93bc-f7c90154a622	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	oidc-address-mapper
33e7e318-64db-451c-af68-42ed8a8a009d	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	saml-user-property-mapper
5b227c76-8c72-48b7-9502-707aecc1e840	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	saml-role-list-mapper
c6bbe56b-bf43-486a-b2e8-3303cf531a95	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	saml-user-attribute-mapper
3fd606a7-8a38-4ca5-9469-ed69320a9e03	f9fe4f60-8fc1-4b49-91f6-822b1f000325	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
198fdf31-0185-43fd-8a18-d844c88d536d	b948d442-c066-46a4-8f7a-57c9c2525134	allow-default-scopes	true
af14a064-e971-4ec6-9c3f-db7d03522a82	a51270f9-c91d-4227-b71c-b9643177a88a	client-uris-must-match	true
95f5c8ec-72d8-4f63-98df-4f6f22ad7c1e	a51270f9-c91d-4227-b71c-b9643177a88a	host-sending-registration-request-must-match	true
dc975f5f-1ac1-4666-add6-ac2aba329349	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	saml-user-attribute-mapper
29d7faec-f30e-4e6e-8d06-b9c2f87338c7	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	oidc-full-name-mapper
ebe8e039-69d7-44b0-961e-d9ddf355b677	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
f9bc75d9-2e8a-4f5b-91cd-dd6a852d261f	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
3a97467b-8547-446d-bf80-046e4c335fe3	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c116970c-687a-4ec1-a7e0-23e4fa5ffdc9	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	oidc-address-mapper
93525e3a-9a2a-491c-89be-0f2133a4a605	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	saml-role-list-mapper
687a02f5-07fb-4cc5-943d-08f55c023164	5c010e9f-92de-480b-a618-04ce3161fd33	allowed-protocol-mapper-types	saml-user-property-mapper
b0c54860-1012-4487-a40a-ef81c2a385d6	1669db8d-c7a0-4ca9-80bb-cd4a002beeb6	allow-default-scopes	true
\.


--
-- TOC entry 4148 (class 0 OID 16504)
-- Dependencies: 238
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.composite_role (composite, child_role) FROM stdin;
7342caa7-272c-405b-8bd1-77780993163a	ee03bcb1-7e6b-4be3-8bc9-b85e230b0159
7342caa7-272c-405b-8bd1-77780993163a	5436ef23-f6da-4453-9eef-4f7b3a044062
7342caa7-272c-405b-8bd1-77780993163a	e299d2cc-70f3-49f6-b53e-ab7d269255f2
7342caa7-272c-405b-8bd1-77780993163a	c4857fd2-01c7-4d93-8f69-6721ffd9e5af
7342caa7-272c-405b-8bd1-77780993163a	5e1de7bc-a2db-40ad-9983-34c9b704a320
7342caa7-272c-405b-8bd1-77780993163a	4be9ef4e-43f9-440e-a15d-379d0260424b
7342caa7-272c-405b-8bd1-77780993163a	bbd588a0-8272-4d42-bd6e-a60f78be51d5
7342caa7-272c-405b-8bd1-77780993163a	1991940f-7a52-4fd8-8c29-2e793359029c
7342caa7-272c-405b-8bd1-77780993163a	ca67c91f-af6c-4db9-ac5a-d2bf2f17fdc2
7342caa7-272c-405b-8bd1-77780993163a	6463f83d-91d3-4f66-9eb8-e6ea4a46da75
7342caa7-272c-405b-8bd1-77780993163a	f7046857-b53c-4f77-a656-75ee6960b5e8
7342caa7-272c-405b-8bd1-77780993163a	6bd5d13c-a4ae-45b3-94e8-4c0f87365727
7342caa7-272c-405b-8bd1-77780993163a	a17b2c69-12e4-4f2e-9be2-d70716df9bc9
7342caa7-272c-405b-8bd1-77780993163a	cd430554-06a8-43db-916f-e763831d2b09
7342caa7-272c-405b-8bd1-77780993163a	acc23f2d-d653-449f-ace9-93c61f6cca05
7342caa7-272c-405b-8bd1-77780993163a	9be2feef-90a5-4f9f-b243-63e8c7cd7c48
7342caa7-272c-405b-8bd1-77780993163a	9d7bfe23-89f0-4e2f-8bf5-df942b8f4f0b
7342caa7-272c-405b-8bd1-77780993163a	2c9e3b9c-81e4-4157-ad52-4ab1cc1b1728
5e1de7bc-a2db-40ad-9983-34c9b704a320	9be2feef-90a5-4f9f-b243-63e8c7cd7c48
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	c9c356d3-47ec-4c25-91f9-070db7c30aba
c4857fd2-01c7-4d93-8f69-6721ffd9e5af	2c9e3b9c-81e4-4157-ad52-4ab1cc1b1728
c4857fd2-01c7-4d93-8f69-6721ffd9e5af	acc23f2d-d653-449f-ace9-93c61f6cca05
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	0492795f-e5e1-4622-8f85-9ddd89df99b4
0492795f-e5e1-4622-8f85-9ddd89df99b4	e1296faa-d9c0-42d3-9787-56910eb9828a
1bbc6151-9b97-482e-9080-a88cf59e31e4	f0c8f631-d36a-4882-a6fc-0a1b709a90bc
7342caa7-272c-405b-8bd1-77780993163a	241bfc40-6d8d-486e-8143-42050397e120
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	bb6bacfa-ce21-46df-9407-a26791973e02
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	dd62b24c-4b9d-432b-bd88-9adbf9e887cb
7342caa7-272c-405b-8bd1-77780993163a	cd553226-0cd7-46c2-86ed-7319f4b14db4
7342caa7-272c-405b-8bd1-77780993163a	fb7500e4-2304-4fe9-8042-4f1cd0453270
7342caa7-272c-405b-8bd1-77780993163a	3b6820bb-c823-4510-ac29-c59a0a641357
7342caa7-272c-405b-8bd1-77780993163a	d34edce2-b506-464c-b7d2-e73c1d4c74d6
7342caa7-272c-405b-8bd1-77780993163a	c7dcc599-16d8-4cc8-b88f-075592720a52
7342caa7-272c-405b-8bd1-77780993163a	859404e1-8a7b-46cd-9b38-67fedd6b4516
7342caa7-272c-405b-8bd1-77780993163a	80675e7f-b919-45c1-894b-061d1e7e06b6
7342caa7-272c-405b-8bd1-77780993163a	cfe75d36-0907-4d1c-928c-0362d574472d
7342caa7-272c-405b-8bd1-77780993163a	3f406d9b-cdd1-4430-ac27-25a2796c46e4
7342caa7-272c-405b-8bd1-77780993163a	57eb9c9a-89a2-474e-9cc2-64b52c1ebc75
7342caa7-272c-405b-8bd1-77780993163a	2d8cb5c1-9f57-4868-93cd-f1f75e789c46
7342caa7-272c-405b-8bd1-77780993163a	51fa827a-c86f-44a0-b95d-ee52f7c17dd5
7342caa7-272c-405b-8bd1-77780993163a	4824db0d-a398-46ab-95bf-2c317f88b846
7342caa7-272c-405b-8bd1-77780993163a	783f713b-a7ff-48c9-bfec-dac37ec06bc1
7342caa7-272c-405b-8bd1-77780993163a	7fb85825-9810-42d9-8707-891c11fb3111
7342caa7-272c-405b-8bd1-77780993163a	1b01bd7b-43a8-43fb-b036-2a908723f61d
7342caa7-272c-405b-8bd1-77780993163a	b46e4418-17e0-42ea-8049-aafd345505fc
3b6820bb-c823-4510-ac29-c59a0a641357	783f713b-a7ff-48c9-bfec-dac37ec06bc1
3b6820bb-c823-4510-ac29-c59a0a641357	b46e4418-17e0-42ea-8049-aafd345505fc
d34edce2-b506-464c-b7d2-e73c1d4c74d6	7fb85825-9810-42d9-8707-891c11fb3111
04a09a36-7cb3-4853-85f9-49c56666fb35	e9afe2df-4f63-4b72-836f-786f07239de4
04a09a36-7cb3-4853-85f9-49c56666fb35	a16f32ec-a6ab-4132-87c8-ee78951dbb60
04a09a36-7cb3-4853-85f9-49c56666fb35	929c0f7e-c468-4857-8d95-b7fa17c3dd32
04a09a36-7cb3-4853-85f9-49c56666fb35	9792a811-230c-4970-ad8a-f5ccb04a8bdb
04a09a36-7cb3-4853-85f9-49c56666fb35	1b2ceecd-ea13-416a-a6f0-c43d9bbaac5c
04a09a36-7cb3-4853-85f9-49c56666fb35	3e6fdca1-093d-4225-b13e-c1d9ed485a72
04a09a36-7cb3-4853-85f9-49c56666fb35	0e54e5d9-0b3f-4861-9a2a-24ccf3efff21
04a09a36-7cb3-4853-85f9-49c56666fb35	704cf8d7-b3b3-4afd-a3c5-fa06b573b720
04a09a36-7cb3-4853-85f9-49c56666fb35	78239806-3524-400d-a2c5-12ed700f9b38
04a09a36-7cb3-4853-85f9-49c56666fb35	5ddd606d-7222-4551-99d2-0b0469958680
04a09a36-7cb3-4853-85f9-49c56666fb35	136595db-08a9-41c3-94a6-46fdf8f8b14b
04a09a36-7cb3-4853-85f9-49c56666fb35	bca17d71-970c-40f5-8069-5e0e702f788c
04a09a36-7cb3-4853-85f9-49c56666fb35	95c50dc2-0d22-4f09-8c30-b4c91f95daad
04a09a36-7cb3-4853-85f9-49c56666fb35	61ee7f05-ebf2-44ac-a3c2-16d4dfdd0654
04a09a36-7cb3-4853-85f9-49c56666fb35	44b3d1b3-520d-4fc2-a1bf-5b8e2550ddcd
04a09a36-7cb3-4853-85f9-49c56666fb35	cefdf094-fe9c-4edc-917b-5949876f818a
04a09a36-7cb3-4853-85f9-49c56666fb35	85032745-7579-4a65-9fbc-44b1c60fe2a2
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	78a646bb-15cd-463a-9ef3-e671d2228cd1
929c0f7e-c468-4857-8d95-b7fa17c3dd32	85032745-7579-4a65-9fbc-44b1c60fe2a2
929c0f7e-c468-4857-8d95-b7fa17c3dd32	61ee7f05-ebf2-44ac-a3c2-16d4dfdd0654
9792a811-230c-4970-ad8a-f5ccb04a8bdb	44b3d1b3-520d-4fc2-a1bf-5b8e2550ddcd
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	63aecec0-af48-4eea-9d80-64b9024d00ce
63aecec0-af48-4eea-9d80-64b9024d00ce	96415556-d511-466b-9b4b-b9708478df79
5285518a-a086-4bbc-80d7-b58827ed0f59	1e3e9177-218f-4969-aed9-138dd1102088
7342caa7-272c-405b-8bd1-77780993163a	a7d20f33-d7d4-4fd4-9da9-94d01b89ac80
04a09a36-7cb3-4853-85f9-49c56666fb35	7cc73044-3d6d-47cc-b364-84fb2cc91fb7
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	13cf3361-0704-4115-b5ea-bd3059e120d2
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	58a838a3-5410-4fd8-a7f1-e7dd6eeff6de
\.


--
-- TOC entry 4149 (class 0 OID 16507)
-- Dependencies: 239
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
53401a41-68c1-4ba2-ab24-3f6a4aa2b63a	\N	password	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2	1694111992015	\N	{"value":"uSKyW1qAqDGJ2yoCyCL5JKY9EwhnP9QSpfxl0eL5PDY=","salt":"wfMyYnND2AKv7kNFSiiH4g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
d2d79509-8195-4fd6-a8d5-279322196572	\N	password	18dd4c24-a575-4944-97b5-4d7e60e4b2ee	1694113850070	My password	{"value":"+hN1qSh+fcfYvY041XtJHkqgYWjKehonl1+lMufdzow=","salt":"ogLSMIg80GUtzBBekNsVfQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
fc1ec41a-1bd3-46e2-9b04-41cfd7fd20f0	\N	password	864b40d8-4b9c-4c63-84ae-59b96397e000	1694113867859	My password	{"value":"1p74/C2H1N5R1Ln06hE4paLmPGq+5yd0jFQmPA/CkB8=","salt":"80dVR/x1XrSBsyae52Sg5A==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
641576b6-f6b3-4467-94d1-ac526c11ce53	\N	password	181edd3e-372a-4ecb-9e6a-41a5bd02db0c	1694893092001	My password	{"value":"pdZoCrrziBJ0ev2C8KjnY1NosR9C+escB68KtieywN8=","salt":"BW7eOZ6qcW8r9YufNXthfA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
dbe3f683-f6d6-4e07-a37b-bb4d37b98498	\N	password	6ce64cf0-3e5c-40dc-aa62-822d55d5278d	1694893118377	My password	{"value":"mxJQpeth0If059z9Y/2o67FTVJ36b7KY+1HRmgD3vPs=","salt":"QawdlVvAKk5P1Ss8NpkDcw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1444156b-1995-4348-a621-de875e5587a0	\N	password	d2fbe307-308c-4afa-9db6-21db9233aba0	1700222201133	My password	{"value":"MUJMqVe74gA1IbHNVSjZsOtWEXkcsvAmIZutEoQlNGo=","salt":"kLmww39SrbNWy6HXcPVAFA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6ac4df27-29f1-498c-8d2c-f5cf87e0b727	\N	password	634d8884-417a-4592-bc9c-fc4738dc4547	1700222248614	My password	{"value":"7qMkYWH/wUq1ISw1F4gBVQth8uwAqQhTv1ncJtU7zWc=","salt":"xsU3PwZDEu5kemAwJjHuIw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- TOC entry 4150 (class 0 OID 16512)
-- Dependencies: 240
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-09-07 18:39:46.724458	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	4111986018
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-09-07 18:39:47.807092	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	4111986018
22.0.0-17484	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-09-07 18:39:50.062669	114	EXECUTED	8:4c3d4e8b142a66fcdf21b89a4dd33301	customChange		\N	4.20.0	\N	\N	4111986018
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-09-07 18:39:46.647934	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	4111986018
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-09-07 18:39:46.65395	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.20.0	\N	\N	4111986018
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-09-07 18:39:47.567877	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	4111986018
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-09-07 18:39:46.717836	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.20.0	\N	\N	4111986018
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-09-07 18:39:46.876408	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	4111986018
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-09-07 18:39:46.879508	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.20.0	\N	\N	4111986018
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-09-07 18:39:47.033768	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	4111986018
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-09-07 18:39:47.039409	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.20.0	\N	\N	4111986018
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-09-07 18:39:47.04602	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.20.0	\N	\N	4111986018
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-09-07 18:39:47.22664	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.20.0	\N	\N	4111986018
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-09-07 18:39:47.315494	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	4111986018
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-09-07 18:39:47.318421	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	4111986018
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-09-07 18:39:47.332928	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.20.0	\N	\N	4111986018
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-07 18:39:47.370992	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.20.0	\N	\N	4111986018
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-07 18:39:47.374054	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	4111986018
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-07 18:39:47.377338	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.20.0	\N	\N	4111986018
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-09-07 18:39:47.38108	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.20.0	\N	\N	4111986018
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-09-07 18:39:47.445876	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.20.0	\N	\N	4111986018
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-09-07 18:39:47.510906	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	4111986018
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-09-07 18:39:47.518359	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	4111986018
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-07 18:39:47.521305	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.20.0	\N	\N	4111986018
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-09-07 18:39:47.52644	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.20.0	\N	\N	4111986018
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-09-07 18:39:47.557831	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.20.0	\N	\N	4111986018
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-09-07 18:39:47.565133	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.20.0	\N	\N	4111986018
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-09-07 18:39:47.654084	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.20.0	\N	\N	4111986018
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-09-07 18:39:47.802873	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.20.0	\N	\N	4111986018
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-09-07 18:39:47.972447	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.20.0	\N	\N	4111986018
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-09-07 18:39:48.011075	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.20.0	\N	\N	4111986018
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-09-07 18:39:48.057748	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.20.0	\N	\N	4111986018
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-09-07 18:39:48.073247	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.20.0	\N	\N	4111986018
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-07 18:39:48.091881	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	4111986018
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-07 18:39:48.095385	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	4111986018
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-07 18:39:48.142068	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.20.0	\N	\N	4111986018
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-09-07 18:39:48.150844	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.20.0	\N	\N	4111986018
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-09-07 18:39:48.166388	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	4111986018
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-09-07 18:39:48.173799	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.20.0	\N	\N	4111986018
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-09-07 18:39:48.180456	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.20.0	\N	\N	4111986018
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-07 18:39:48.183161	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	4111986018
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-07 18:39:48.186131	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.20.0	\N	\N	4111986018
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-09-07 18:39:48.19354	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.20.0	\N	\N	4111986018
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-09-07 18:39:48.63681	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.20.0	\N	\N	4111986018
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-09-07 18:39:48.647936	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.20.0	\N	\N	4111986018
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-07 18:39:48.661384	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	4111986018
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-07 18:39:48.67973	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.20.0	\N	\N	4111986018
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-07 18:39:48.68434	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.20.0	\N	\N	4111986018
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-07 18:39:48.782454	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.20.0	\N	\N	4111986018
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-09-07 18:39:48.793503	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.20.0	\N	\N	4111986018
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-09-07 18:39:48.935046	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.20.0	\N	\N	4111986018
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-09-07 18:39:49.047978	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.20.0	\N	\N	4111986018
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-09-07 18:39:49.062295	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-09-07 18:39:49.070939	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.20.0	\N	\N	4111986018
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-09-07 18:39:49.080253	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.20.0	\N	\N	4111986018
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-07 18:39:49.09685	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.20.0	\N	\N	4111986018
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-07 18:39:49.10485	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.20.0	\N	\N	4111986018
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-07 18:39:49.152271	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.20.0	\N	\N	4111986018
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-09-07 18:39:49.30396	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.20.0	\N	\N	4111986018
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-09-07 18:39:49.372967	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.20.0	\N	\N	4111986018
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-09-07 18:39:49.388717	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.20.0	\N	\N	4111986018
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-07 18:39:49.416749	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.20.0	\N	\N	4111986018
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-09-07 18:39:49.435345	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.20.0	\N	\N	4111986018
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-09-07 18:39:49.445638	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	4111986018
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-09-07 18:39:49.453764	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.20.0	\N	\N	4111986018
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-07 18:39:49.461593	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.20.0	\N	\N	4111986018
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-09-07 18:39:49.493831	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.20.0	\N	\N	4111986018
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-09-07 18:39:49.507229	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.20.0	\N	\N	4111986018
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-09-07 18:39:49.513624	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.20.0	\N	\N	4111986018
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-09-07 18:39:49.530345	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.20.0	\N	\N	4111986018
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-09-07 18:39:49.537426	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.20.0	\N	\N	4111986018
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-09-07 18:39:49.543158	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	4111986018
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-07 18:39:49.550532	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	4111986018
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-07 18:39:49.556791	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	4111986018
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-07 18:39:49.560277	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.20.0	\N	\N	4111986018
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-07 18:39:49.576176	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.20.0	\N	\N	4111986018
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-09-07 18:39:49.593969	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.20.0	\N	\N	4111986018
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-07 18:39:49.600006	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.20.0	\N	\N	4111986018
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-07 18:39:49.60291	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.20.0	\N	\N	4111986018
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-07 18:39:49.629728	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.20.0	\N	\N	4111986018
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-09-07 18:39:49.633935	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.20.0	\N	\N	4111986018
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-07 18:39:49.653337	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.20.0	\N	\N	4111986018
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-07 18:39:49.658285	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	4111986018
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-07 18:39:49.672013	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	4111986018
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-07 18:39:49.677515	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.20.0	\N	\N	4111986018
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-09-07 18:39:49.696047	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.20.0	\N	\N	4111986018
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-09-07 18:39:49.705715	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.20.0	\N	\N	4111986018
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-07 18:39:49.717008	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.20.0	\N	\N	4111986018
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-09-07 18:39:49.737705	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.20.0	\N	\N	4111986018
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.748445	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.20.0	\N	\N	4111986018
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.756652	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.20.0	\N	\N	4111986018
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.769324	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	4111986018
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.782874	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.20.0	\N	\N	4111986018
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.786384	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	4111986018
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.803287	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.20.0	\N	\N	4111986018
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.806301	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.20.0	\N	\N	4111986018
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-09-07 18:39:49.81473	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.20.0	\N	\N	4111986018
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.842646	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.20.0	\N	\N	4111986018
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.845802	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.854283	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.867826	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.870699	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.884179	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.20.0	\N	\N	4111986018
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-09-07 18:39:49.890844	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.20.0	\N	\N	4111986018
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-09-07 18:39:49.898662	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.20.0	\N	\N	4111986018
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-09-07 18:39:49.913483	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.20.0	\N	\N	4111986018
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-09-07 18:39:49.929494	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.20.0	\N	\N	4111986018
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-09-07 18:39:49.936427	107	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.20.0	\N	\N	4111986018
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-07 18:39:49.950229	108	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	4111986018
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-07 18:39:49.953956	109	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.20.0	\N	\N	4111986018
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-09-07 18:39:49.964044	110	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.20.0	\N	\N	4111986018
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2023-09-07 18:39:49.971741	111	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.20.0	\N	\N	4111986018
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-09-07 18:39:50.043216	112	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.20.0	\N	\N	4111986018
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2023-09-07 18:39:50.047819	113	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.20.0	\N	\N	4111986018
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-11-17 11:46:39.47007	115	MARK_RAN	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.23.2	\N	\N	0221598537
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2023-11-17 11:46:39.483356	116	EXECUTED	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.23.2	\N	\N	0221598537
\.


--
-- TOC entry 4151 (class 0 OID 16517)
-- Dependencies: 241
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 4152 (class 0 OID 16520)
-- Dependencies: 242
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2a6978d8-2996-40c2-b70f-f491584d8f90	f
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	051e8be0-fc52-4c1e-a184-bffdd192d8ed	t
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	4c237789-5d12-452b-ac37-419172627623	t
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	bc544bb7-a832-41f7-b4cc-775206c29ce2	t
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	25af5016-8247-4abe-90c3-bfd4e0297c45	f
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	10aad80e-f081-4c44-adbe-9f7e99a8b925	f
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	21e15ba2-6475-4e24-ae73-ed0e2b224b11	t
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2d5410a2-a71d-43b0-857c-111eed14c53e	t
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	791c532f-6203-4ea0-901a-043acab9bbcd	f
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	407b0d8f-3acb-4f85-b6a6-4013c43b718c	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	8a1bc266-1016-45ac-baf1-aaf2a72b33a4	f
f22bc560-708c-401c-ad05-2dbb1cda77dd	d9e489ee-6687-468b-bd43-82c773795734	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	3333893c-e45f-4d79-aba1-7588d8664b70	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	39b22340-8ec4-4352-85c9-ca4c87c2b35e	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	2c73bcba-f990-4d3e-9800-10255453a27b	f
f22bc560-708c-401c-ad05-2dbb1cda77dd	46f28b59-b9cc-4472-9211-92ea9121335c	f
f22bc560-708c-401c-ad05-2dbb1cda77dd	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	50baaf2f-a7f0-4c34-9705-6b60d974d9bc	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	3caf37ff-603b-45aa-8f68-7a6d1b8ce255	f
f22bc560-708c-401c-ad05-2dbb1cda77dd	3b522a3b-ed69-4e6f-b3e5-78067a0fd314	t
f22bc560-708c-401c-ad05-2dbb1cda77dd	d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1	t
\.


--
-- TOC entry 4153 (class 0 OID 16524)
-- Dependencies: 243
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- TOC entry 4154 (class 0 OID 16529)
-- Dependencies: 244
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- TOC entry 4155 (class 0 OID 16534)
-- Dependencies: 245
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4156 (class 0 OID 16539)
-- Dependencies: 246
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4157 (class 0 OID 16542)
-- Dependencies: 247
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 4158 (class 0 OID 16547)
-- Dependencies: 248
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4159 (class 0 OID 16550)
-- Dependencies: 249
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4160 (class 0 OID 16556)
-- Dependencies: 250
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4161 (class 0 OID 16559)
-- Dependencies: 251
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4162 (class 0 OID 16564)
-- Dependencies: 252
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 4163 (class 0 OID 16569)
-- Dependencies: 253
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 4164 (class 0 OID 16575)
-- Dependencies: 254
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
c66a2e8d-7a0a-42c0-86a8-dd5398ba4d5a	2871365d-80f9-4737-b5e1-e154c32ce038
74ece232-7cd7-4f8c-99c4-34a0ac8aa6fd	d6c1cf29-8f2b-4eb6-8424-c077d0885596
d50d7e48-2d96-48c4-a527-eb06f87336a0	d5056ac9-3374-40ef-a83f-2750e1af3ac2
44e98f75-4193-419c-be26-1f9809d1c81c	ca61efdb-4e04-4bf2-9a23-2c77ec67a379
44e98f75-4193-419c-be26-1f9809d1c81c	3c054a19-10e2-4fe8-882d-09bfbd14d35d
c4559e87-153e-45af-bd66-67da3a2c977a	1b355c03-21a2-45f2-9055-556f9b21736f
\.


--
-- TOC entry 4165 (class 0 OID 16578)
-- Dependencies: 255
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 4166 (class 0 OID 16589)
-- Dependencies: 256
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4167 (class 0 OID 16594)
-- Dependencies: 257
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4168 (class 0 OID 16599)
-- Dependencies: 258
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4169 (class 0 OID 16604)
-- Dependencies: 259
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
96479cd6-63f5-4fc6-a2e2-4e4fe3661321	back-office	 	f22bc560-708c-401c-ad05-2dbb1cda77dd
2871365d-80f9-4737-b5e1-e154c32ce038	user	96479cd6-63f5-4fc6-a2e2-4e4fe3661321	f22bc560-708c-401c-ad05-2dbb1cda77dd
d6c1cf29-8f2b-4eb6-8424-c077d0885596	admin	96479cd6-63f5-4fc6-a2e2-4e4fe3661321	f22bc560-708c-401c-ad05-2dbb1cda77dd
d5056ac9-3374-40ef-a83f-2750e1af3ac2	user	f259c8b4-c086-4352-9769-15dad9f6b972	f22bc560-708c-401c-ad05-2dbb1cda77dd
ca61efdb-4e04-4bf2-9a23-2c77ec67a379	admin	f259c8b4-c086-4352-9769-15dad9f6b972	f22bc560-708c-401c-ad05-2dbb1cda77dd
f259c8b4-c086-4352-9769-15dad9f6b972	platform	 	f22bc560-708c-401c-ad05-2dbb1cda77dd
53ef0549-a898-472a-ab5c-eee726849a83	management	 	f22bc560-708c-401c-ad05-2dbb1cda77dd
3c054a19-10e2-4fe8-882d-09bfbd14d35d	admin	53ef0549-a898-472a-ab5c-eee726849a83	f22bc560-708c-401c-ad05-2dbb1cda77dd
1b355c03-21a2-45f2-9055-556f9b21736f	user	53ef0549-a898-472a-ab5c-eee726849a83	f22bc560-708c-401c-ad05-2dbb1cda77dd
\.


--
-- TOC entry 4170 (class 0 OID 16607)
-- Dependencies: 260
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	${role_default-roles}	default-roles-master	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	\N
7342caa7-272c-405b-8bd1-77780993163a	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	${role_admin}	admin	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	\N
ee03bcb1-7e6b-4be3-8bc9-b85e230b0159	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	${role_create-realm}	create-realm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	\N
5436ef23-f6da-4453-9eef-4f7b3a044062	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_create-client}	create-client	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
e299d2cc-70f3-49f6-b53e-ab7d269255f2	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-realm}	view-realm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
c4857fd2-01c7-4d93-8f69-6721ffd9e5af	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-users}	view-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
5e1de7bc-a2db-40ad-9983-34c9b704a320	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-clients}	view-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
4be9ef4e-43f9-440e-a15d-379d0260424b	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-events}	view-events	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
bbd588a0-8272-4d42-bd6e-a60f78be51d5	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-identity-providers}	view-identity-providers	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
1991940f-7a52-4fd8-8c29-2e793359029c	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_view-authorization}	view-authorization	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
ca67c91f-af6c-4db9-ac5a-d2bf2f17fdc2	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-realm}	manage-realm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
6463f83d-91d3-4f66-9eb8-e6ea4a46da75	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-users}	manage-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
f7046857-b53c-4f77-a656-75ee6960b5e8	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-clients}	manage-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
6bd5d13c-a4ae-45b3-94e8-4c0f87365727	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-events}	manage-events	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
a17b2c69-12e4-4f2e-9be2-d70716df9bc9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-identity-providers}	manage-identity-providers	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
cd430554-06a8-43db-916f-e763831d2b09	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_manage-authorization}	manage-authorization	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
acc23f2d-d653-449f-ace9-93c61f6cca05	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_query-users}	query-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
9be2feef-90a5-4f9f-b243-63e8c7cd7c48	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_query-clients}	query-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
9d7bfe23-89f0-4e2f-8bf5-df942b8f4f0b	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_query-realms}	query-realms	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
2c9e3b9c-81e4-4157-ad52-4ab1cc1b1728	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_query-groups}	query-groups	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
c9c356d3-47ec-4c25-91f9-070db7c30aba	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_view-profile}	view-profile	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
0492795f-e5e1-4622-8f85-9ddd89df99b4	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_manage-account}	manage-account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
e1296faa-d9c0-42d3-9787-56910eb9828a	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_manage-account-links}	manage-account-links	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
6ac127a3-a6bf-4c14-89af-f1053b00cee4	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_view-applications}	view-applications	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
f0c8f631-d36a-4882-a6fc-0a1b709a90bc	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_view-consent}	view-consent	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
1bbc6151-9b97-482e-9080-a88cf59e31e4	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_manage-consent}	manage-consent	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
e18fc46e-739b-4263-8f0d-d925a9685515	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_view-groups}	view-groups	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
a1c9f25e-c48f-4f5c-837f-0579cfa1732f	e154faf5-b5d2-4799-9bd6-8bdaa349601b	t	${role_delete-account}	delete-account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e154faf5-b5d2-4799-9bd6-8bdaa349601b	\N
fbd4e4a2-3d83-4236-b1f6-0223a361bfde	e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	t	${role_read-token}	read-token	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	e7188c48-2d4a-4855-b2a4-dbb9ad3ba19f	\N
241bfc40-6d8d-486e-8143-42050397e120	2e527d92-7ea4-4944-ae26-b5a34aec87cb	t	${role_impersonation}	impersonation	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	2e527d92-7ea4-4944-ae26-b5a34aec87cb	\N
bb6bacfa-ce21-46df-9407-a26791973e02	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	${role_offline-access}	offline_access	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	\N
dd62b24c-4b9d-432b-bd88-9adbf9e887cb	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	${role_uma_authorization}	uma_authorization	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	\N	\N
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	f22bc560-708c-401c-ad05-2dbb1cda77dd	f	${role_default-roles}	default-roles-api	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
cd553226-0cd7-46c2-86ed-7319f4b14db4	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_create-client}	create-client	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
fb7500e4-2304-4fe9-8042-4f1cd0453270	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-realm}	view-realm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
3b6820bb-c823-4510-ac29-c59a0a641357	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-users}	view-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
d34edce2-b506-464c-b7d2-e73c1d4c74d6	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-clients}	view-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
c7dcc599-16d8-4cc8-b88f-075592720a52	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-events}	view-events	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
859404e1-8a7b-46cd-9b38-67fedd6b4516	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-identity-providers}	view-identity-providers	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
80675e7f-b919-45c1-894b-061d1e7e06b6	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_view-authorization}	view-authorization	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
cfe75d36-0907-4d1c-928c-0362d574472d	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-realm}	manage-realm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
3f406d9b-cdd1-4430-ac27-25a2796c46e4	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-users}	manage-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
57eb9c9a-89a2-474e-9cc2-64b52c1ebc75	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-clients}	manage-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
2d8cb5c1-9f57-4868-93cd-f1f75e789c46	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-events}	manage-events	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
51fa827a-c86f-44a0-b95d-ee52f7c17dd5	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-identity-providers}	manage-identity-providers	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
4824db0d-a398-46ab-95bf-2c317f88b846	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_manage-authorization}	manage-authorization	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
783f713b-a7ff-48c9-bfec-dac37ec06bc1	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_query-users}	query-users	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
7fb85825-9810-42d9-8707-891c11fb3111	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_query-clients}	query-clients	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
1b01bd7b-43a8-43fb-b036-2a908723f61d	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_query-realms}	query-realms	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
b46e4418-17e0-42ea-8049-aafd345505fc	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_query-groups}	query-groups	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
04a09a36-7cb3-4853-85f9-49c56666fb35	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_realm-admin}	realm-admin	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
e9afe2df-4f63-4b72-836f-786f07239de4	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_create-client}	create-client	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
a16f32ec-a6ab-4132-87c8-ee78951dbb60	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-realm}	view-realm	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
929c0f7e-c468-4857-8d95-b7fa17c3dd32	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-users}	view-users	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
9792a811-230c-4970-ad8a-f5ccb04a8bdb	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-clients}	view-clients	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
1b2ceecd-ea13-416a-a6f0-c43d9bbaac5c	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-events}	view-events	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
3e6fdca1-093d-4225-b13e-c1d9ed485a72	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-identity-providers}	view-identity-providers	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
0e54e5d9-0b3f-4861-9a2a-24ccf3efff21	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_view-authorization}	view-authorization	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
704cf8d7-b3b3-4afd-a3c5-fa06b573b720	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-realm}	manage-realm	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
78239806-3524-400d-a2c5-12ed700f9b38	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-users}	manage-users	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
5ddd606d-7222-4551-99d2-0b0469958680	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-clients}	manage-clients	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
136595db-08a9-41c3-94a6-46fdf8f8b14b	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-events}	manage-events	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
bca17d71-970c-40f5-8069-5e0e702f788c	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-identity-providers}	manage-identity-providers	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
95c50dc2-0d22-4f09-8c30-b4c91f95daad	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_manage-authorization}	manage-authorization	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
61ee7f05-ebf2-44ac-a3c2-16d4dfdd0654	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_query-users}	query-users	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
44b3d1b3-520d-4fc2-a1bf-5b8e2550ddcd	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_query-clients}	query-clients	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
cefdf094-fe9c-4edc-917b-5949876f818a	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_query-realms}	query-realms	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
85032745-7579-4a65-9fbc-44b1c60fe2a2	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_query-groups}	query-groups	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
78a646bb-15cd-463a-9ef3-e671d2228cd1	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_view-profile}	view-profile	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
63aecec0-af48-4eea-9d80-64b9024d00ce	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_manage-account}	manage-account	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
96415556-d511-466b-9b4b-b9708478df79	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_manage-account-links}	manage-account-links	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
ae03f2cb-7ae2-4ce1-8cfa-1e562a41e33b	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_view-applications}	view-applications	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
1e3e9177-218f-4969-aed9-138dd1102088	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_view-consent}	view-consent	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
5285518a-a086-4bbc-80d7-b58827ed0f59	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_manage-consent}	manage-consent	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
b47c7cba-69cf-4e0b-a1b8-a12c7ea1e939	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_view-groups}	view-groups	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
5c4c9ff2-5022-40b0-a75a-d4f99b7f4237	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	t	${role_delete-account}	delete-account	f22bc560-708c-401c-ad05-2dbb1cda77dd	659d2ff1-0b5c-482a-9c34-73def2ec2d0f	\N
a7d20f33-d7d4-4fd4-9da9-94d01b89ac80	7b1b68dc-583f-4952-bd7f-dcce425bf42e	t	${role_impersonation}	impersonation	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	7b1b68dc-583f-4952-bd7f-dcce425bf42e	\N
7cc73044-3d6d-47cc-b364-84fb2cc91fb7	1f8f4c4b-515d-4cae-ad55-371f83967386	t	${role_impersonation}	impersonation	f22bc560-708c-401c-ad05-2dbb1cda77dd	1f8f4c4b-515d-4cae-ad55-371f83967386	\N
ee78484e-0acc-4e1b-b332-7b7eae732f44	1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	t	${role_read-token}	read-token	f22bc560-708c-401c-ad05-2dbb1cda77dd	1cd60c76-57d3-46c4-b80e-7c6f8b0c014e	\N
13cf3361-0704-4115-b5ea-bd3059e120d2	f22bc560-708c-401c-ad05-2dbb1cda77dd	f	${role_offline-access}	offline_access	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
58a838a3-5410-4fd8-a7f1-e7dd6eeff6de	f22bc560-708c-401c-ad05-2dbb1cda77dd	f	${role_uma_authorization}	uma_authorization	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
c66a2e8d-7a0a-42c0-86a8-dd5398ba4d5a	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		back_office_user	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
74ece232-7cd7-4f8c-99c4-34a0ac8aa6fd	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		back_office_admin	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
44e98f75-4193-419c-be26-1f9809d1c81c	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		platform_admin	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
d50d7e48-2d96-48c4-a527-eb06f87336a0	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		platform_user	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
85014373-5918-450e-afb3-3212ac0eb561	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		management_admin	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
c4559e87-153e-45af-bd66-67da3a2c977a	f22bc560-708c-401c-ad05-2dbb1cda77dd	f		management_user	f22bc560-708c-401c-ad05-2dbb1cda77dd	\N	\N
\.


--
-- TOC entry 4171 (class 0 OID 16613)
-- Dependencies: 261
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migration_model (id, version, update_time) FROM stdin;
c1syr	22.0.1	1694111990
cu7hl	22.0.5	1700221599
\.


--
-- TOC entry 4172 (class 0 OID 16617)
-- Dependencies: 262
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4173 (class 0 OID 16624)
-- Dependencies: 263
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 4174 (class 0 OID 16630)
-- Dependencies: 264
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 4175 (class 0 OID 16635)
-- Dependencies: 265
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
ee7de1d6-8429-4c16-a7b2-ba04f3cc34f1	audience resolve	openid-connect	oidc-audience-resolve-mapper	d67b2d04-0a42-4877-ad42-fb7ac325e66d	\N
3fc5c649-d7d4-489a-81f6-662748c5d2df	locale	openid-connect	oidc-usermodel-attribute-mapper	3f12da87-c610-479c-a8b8-e17bd2941cdc	\N
a9f9ffe3-6786-4622-9523-576dc1a219b8	role list	saml	saml-role-list-mapper	\N	051e8be0-fc52-4c1e-a184-bffdd192d8ed
eb749e17-4034-45c8-a9a3-4dcc2f5a31b9	full name	openid-connect	oidc-full-name-mapper	\N	4c237789-5d12-452b-ac37-419172627623
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
f745d431-489a-4485-b3d6-513d54d8929a	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
36d3ee50-63b9-402d-921d-4c9b8a5c701a	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	username	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
7603e68a-8fea-46e4-8e63-fd7315961c52	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
5110f3c2-d107-4294-92cb-c7bb84177bef	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
0cb8aea0-231c-461c-b083-71cdbae794e7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
19623b21-5e7e-4f95-8891-9c2dc8228d87	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
467410ff-cd99-4caf-97db-19f161c3c377	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	4c237789-5d12-452b-ac37-419172627623
d432598e-387a-4c52-999d-0fb2cdb42cca	email	openid-connect	oidc-usermodel-attribute-mapper	\N	bc544bb7-a832-41f7-b4cc-775206c29ce2
bee386fb-00f5-4bcd-863b-1281df48f8e3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	bc544bb7-a832-41f7-b4cc-775206c29ce2
6f7d29b0-e589-436f-b177-7c8088143d77	address	openid-connect	oidc-address-mapper	\N	25af5016-8247-4abe-90c3-bfd4e0297c45
47fa07c5-7325-46a3-88d6-ef7acab3675b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	10aad80e-f081-4c44-adbe-9f7e99a8b925
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	10aad80e-f081-4c44-adbe-9f7e99a8b925
88646f3a-d805-464b-b045-63dad14781bd	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	21e15ba2-6475-4e24-ae73-ed0e2b224b11
d161c81c-5a70-437a-bb40-988da4fd6a7b	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	21e15ba2-6475-4e24-ae73-ed0e2b224b11
df5fe4dd-ca0c-4576-8c61-9d57cff95899	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	21e15ba2-6475-4e24-ae73-ed0e2b224b11
370239d9-0040-42a3-abdf-7d03179e3ff5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2d5410a2-a71d-43b0-857c-111eed14c53e
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	791c532f-6203-4ea0-901a-043acab9bbcd
22ac0b10-151e-4209-82b0-965e9cca4ac5	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	791c532f-6203-4ea0-901a-043acab9bbcd
977c3f87-e0a2-42ad-9d28-a4df69c34309	acr loa level	openid-connect	oidc-acr-mapper	\N	407b0d8f-3acb-4f85-b6a6-4013c43b718c
e648bc73-5413-4cfc-b0a6-4a2183520554	audience resolve	openid-connect	oidc-audience-resolve-mapper	a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	\N
b4c64ba2-b363-4962-af76-f4611ccda15b	role list	saml	saml-role-list-mapper	\N	d9e489ee-6687-468b-bd43-82c773795734
eab84936-734d-459d-9efd-affb075b7b33	full name	openid-connect	oidc-full-name-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
465435fe-d3d3-4e40-bf17-9627acd92471	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
ead9a777-12c3-4b64-8754-3a13d703a6b1	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
dbd22a7f-365b-4568-afba-cb3da762ce11	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
8474249b-d869-4c0c-83ba-6de1adddb3a8	username	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
397ae89d-85d8-4e00-9a36-2d6d9f14029e	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	website	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
4aa44903-1bd0-4624-85af-807103ea7894	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
d222fa05-e16b-42c4-aae8-7f5ae873cec7	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
7271a116-3725-4f08-b784-caf0e4ce4dd3	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
26e0125b-1c27-4f70-9572-30f3eb945acf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	3333893c-e45f-4d79-aba1-7588d8664b70
c0974f7a-a77e-4adb-abfb-072a589963a0	email	openid-connect	oidc-usermodel-attribute-mapper	\N	39b22340-8ec4-4352-85c9-ca4c87c2b35e
ffa873fc-3954-4b74-b555-2b75b2be2ebc	email verified	openid-connect	oidc-usermodel-property-mapper	\N	39b22340-8ec4-4352-85c9-ca4c87c2b35e
b98aceb5-1326-480a-acd0-70573583add1	address	openid-connect	oidc-address-mapper	\N	2c73bcba-f990-4d3e-9800-10255453a27b
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	46f28b59-b9cc-4472-9211-92ea9121335c
ed7e9cd5-5c85-4c60-babb-05a8c5341021	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	46f28b59-b9cc-4472-9211-92ea9121335c
8c7e7126-9bc9-42ed-bd91-54a41507feaa	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d
29cfb5a0-c2f6-49c8-b865-244a22e379d4	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d
e466ad84-278c-471f-a27e-3533b810b336	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	8c7d9b8f-ef5b-4ace-a8a1-8ef4d09d4a0d
bc92db83-992f-4bda-9e54-5fafceec2608	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	50baaf2f-a7f0-4c34-9705-6b60d974d9bc
b953eac5-cbce-43df-9555-f7190b677d20	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	3caf37ff-603b-45aa-8f68-7a6d1b8ce255
627976e7-07b3-4b7a-a7cb-99da88b861dc	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3caf37ff-603b-45aa-8f68-7a6d1b8ce255
5477a353-7133-4922-84bf-1d7c2c2a37ee	acr loa level	openid-connect	oidc-acr-mapper	\N	3b522a3b-ed69-4e6f-b3e5-78067a0fd314
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	locale	openid-connect	oidc-usermodel-attribute-mapper	8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	\N
c1356b52-f5ca-4332-a39e-ebd659bb328f	company_slug	openid-connect	oidc-usermodel-attribute-mapper	\N	d1d0d4f1-a76f-4a5f-a7f2-1544cf1313e1
\.


--
-- TOC entry 4176 (class 0 OID 16640)
-- Dependencies: 266
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
3fc5c649-d7d4-489a-81f6-662748c5d2df	true	userinfo.token.claim
3fc5c649-d7d4-489a-81f6-662748c5d2df	locale	user.attribute
3fc5c649-d7d4-489a-81f6-662748c5d2df	true	id.token.claim
3fc5c649-d7d4-489a-81f6-662748c5d2df	true	access.token.claim
3fc5c649-d7d4-489a-81f6-662748c5d2df	locale	claim.name
3fc5c649-d7d4-489a-81f6-662748c5d2df	String	jsonType.label
a9f9ffe3-6786-4622-9523-576dc1a219b8	false	single
a9f9ffe3-6786-4622-9523-576dc1a219b8	Basic	attribute.nameformat
a9f9ffe3-6786-4622-9523-576dc1a219b8	Role	attribute.name
0cb8aea0-231c-461c-b083-71cdbae794e7	true	userinfo.token.claim
0cb8aea0-231c-461c-b083-71cdbae794e7	website	user.attribute
0cb8aea0-231c-461c-b083-71cdbae794e7	true	id.token.claim
0cb8aea0-231c-461c-b083-71cdbae794e7	true	access.token.claim
0cb8aea0-231c-461c-b083-71cdbae794e7	website	claim.name
0cb8aea0-231c-461c-b083-71cdbae794e7	String	jsonType.label
19623b21-5e7e-4f95-8891-9c2dc8228d87	true	userinfo.token.claim
19623b21-5e7e-4f95-8891-9c2dc8228d87	zoneinfo	user.attribute
19623b21-5e7e-4f95-8891-9c2dc8228d87	true	id.token.claim
19623b21-5e7e-4f95-8891-9c2dc8228d87	true	access.token.claim
19623b21-5e7e-4f95-8891-9c2dc8228d87	zoneinfo	claim.name
19623b21-5e7e-4f95-8891-9c2dc8228d87	String	jsonType.label
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	true	userinfo.token.claim
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	username	user.attribute
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	true	id.token.claim
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	true	access.token.claim
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	preferred_username	claim.name
22764e4e-59ee-4b33-b8ee-1b70fc63a27d	String	jsonType.label
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	true	userinfo.token.claim
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	lastName	user.attribute
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	true	id.token.claim
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	true	access.token.claim
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	family_name	claim.name
33a3ffe9-58e9-44f4-b9d4-c6f5ae18224a	String	jsonType.label
36d3ee50-63b9-402d-921d-4c9b8a5c701a	true	userinfo.token.claim
36d3ee50-63b9-402d-921d-4c9b8a5c701a	nickname	user.attribute
36d3ee50-63b9-402d-921d-4c9b8a5c701a	true	id.token.claim
36d3ee50-63b9-402d-921d-4c9b8a5c701a	true	access.token.claim
36d3ee50-63b9-402d-921d-4c9b8a5c701a	nickname	claim.name
36d3ee50-63b9-402d-921d-4c9b8a5c701a	String	jsonType.label
467410ff-cd99-4caf-97db-19f161c3c377	true	userinfo.token.claim
467410ff-cd99-4caf-97db-19f161c3c377	locale	user.attribute
467410ff-cd99-4caf-97db-19f161c3c377	true	id.token.claim
467410ff-cd99-4caf-97db-19f161c3c377	true	access.token.claim
467410ff-cd99-4caf-97db-19f161c3c377	locale	claim.name
467410ff-cd99-4caf-97db-19f161c3c377	String	jsonType.label
5110f3c2-d107-4294-92cb-c7bb84177bef	true	userinfo.token.claim
5110f3c2-d107-4294-92cb-c7bb84177bef	picture	user.attribute
5110f3c2-d107-4294-92cb-c7bb84177bef	true	id.token.claim
5110f3c2-d107-4294-92cb-c7bb84177bef	true	access.token.claim
5110f3c2-d107-4294-92cb-c7bb84177bef	picture	claim.name
5110f3c2-d107-4294-92cb-c7bb84177bef	String	jsonType.label
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	true	userinfo.token.claim
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	firstName	user.attribute
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	true	id.token.claim
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	true	access.token.claim
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	given_name	claim.name
539108c6-23b6-4ac5-b13a-2d4f4e8af48e	String	jsonType.label
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	true	userinfo.token.claim
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	birthdate	user.attribute
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	true	id.token.claim
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	true	access.token.claim
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	birthdate	claim.name
5dc213a9-6b17-428c-a3e2-fcff6e242cd4	String	jsonType.label
7603e68a-8fea-46e4-8e63-fd7315961c52	true	userinfo.token.claim
7603e68a-8fea-46e4-8e63-fd7315961c52	profile	user.attribute
7603e68a-8fea-46e4-8e63-fd7315961c52	true	id.token.claim
7603e68a-8fea-46e4-8e63-fd7315961c52	true	access.token.claim
7603e68a-8fea-46e4-8e63-fd7315961c52	profile	claim.name
7603e68a-8fea-46e4-8e63-fd7315961c52	String	jsonType.label
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	true	userinfo.token.claim
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	updatedAt	user.attribute
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	true	id.token.claim
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	true	access.token.claim
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	updated_at	claim.name
af49ee42-ded2-4d9f-b6bd-b7c57ec8ee9b	long	jsonType.label
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	true	userinfo.token.claim
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	gender	user.attribute
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	true	id.token.claim
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	true	access.token.claim
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	gender	claim.name
db1b8476-c7f2-42e7-8f97-0fe3b5eaa3be	String	jsonType.label
eb749e17-4034-45c8-a9a3-4dcc2f5a31b9	true	userinfo.token.claim
eb749e17-4034-45c8-a9a3-4dcc2f5a31b9	true	id.token.claim
eb749e17-4034-45c8-a9a3-4dcc2f5a31b9	true	access.token.claim
f745d431-489a-4485-b3d6-513d54d8929a	true	userinfo.token.claim
f745d431-489a-4485-b3d6-513d54d8929a	middleName	user.attribute
f745d431-489a-4485-b3d6-513d54d8929a	true	id.token.claim
f745d431-489a-4485-b3d6-513d54d8929a	true	access.token.claim
f745d431-489a-4485-b3d6-513d54d8929a	middle_name	claim.name
f745d431-489a-4485-b3d6-513d54d8929a	String	jsonType.label
bee386fb-00f5-4bcd-863b-1281df48f8e3	true	userinfo.token.claim
bee386fb-00f5-4bcd-863b-1281df48f8e3	emailVerified	user.attribute
bee386fb-00f5-4bcd-863b-1281df48f8e3	true	id.token.claim
bee386fb-00f5-4bcd-863b-1281df48f8e3	true	access.token.claim
bee386fb-00f5-4bcd-863b-1281df48f8e3	email_verified	claim.name
bee386fb-00f5-4bcd-863b-1281df48f8e3	boolean	jsonType.label
d432598e-387a-4c52-999d-0fb2cdb42cca	true	userinfo.token.claim
d432598e-387a-4c52-999d-0fb2cdb42cca	email	user.attribute
d432598e-387a-4c52-999d-0fb2cdb42cca	true	id.token.claim
d432598e-387a-4c52-999d-0fb2cdb42cca	true	access.token.claim
d432598e-387a-4c52-999d-0fb2cdb42cca	email	claim.name
d432598e-387a-4c52-999d-0fb2cdb42cca	String	jsonType.label
6f7d29b0-e589-436f-b177-7c8088143d77	formatted	user.attribute.formatted
6f7d29b0-e589-436f-b177-7c8088143d77	country	user.attribute.country
6f7d29b0-e589-436f-b177-7c8088143d77	postal_code	user.attribute.postal_code
6f7d29b0-e589-436f-b177-7c8088143d77	true	userinfo.token.claim
6f7d29b0-e589-436f-b177-7c8088143d77	street	user.attribute.street
6f7d29b0-e589-436f-b177-7c8088143d77	true	id.token.claim
6f7d29b0-e589-436f-b177-7c8088143d77	region	user.attribute.region
6f7d29b0-e589-436f-b177-7c8088143d77	true	access.token.claim
6f7d29b0-e589-436f-b177-7c8088143d77	locality	user.attribute.locality
47fa07c5-7325-46a3-88d6-ef7acab3675b	true	userinfo.token.claim
47fa07c5-7325-46a3-88d6-ef7acab3675b	phoneNumber	user.attribute
47fa07c5-7325-46a3-88d6-ef7acab3675b	true	id.token.claim
47fa07c5-7325-46a3-88d6-ef7acab3675b	true	access.token.claim
47fa07c5-7325-46a3-88d6-ef7acab3675b	phone_number	claim.name
47fa07c5-7325-46a3-88d6-ef7acab3675b	String	jsonType.label
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	true	userinfo.token.claim
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	phoneNumberVerified	user.attribute
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	true	id.token.claim
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	true	access.token.claim
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	phone_number_verified	claim.name
7e2a0ef8-3a7e-4e7e-86d8-072e7b32d5bf	boolean	jsonType.label
88646f3a-d805-464b-b045-63dad14781bd	true	multivalued
88646f3a-d805-464b-b045-63dad14781bd	foo	user.attribute
88646f3a-d805-464b-b045-63dad14781bd	true	access.token.claim
88646f3a-d805-464b-b045-63dad14781bd	realm_access.roles	claim.name
88646f3a-d805-464b-b045-63dad14781bd	String	jsonType.label
d161c81c-5a70-437a-bb40-988da4fd6a7b	true	multivalued
d161c81c-5a70-437a-bb40-988da4fd6a7b	foo	user.attribute
d161c81c-5a70-437a-bb40-988da4fd6a7b	true	access.token.claim
d161c81c-5a70-437a-bb40-988da4fd6a7b	resource_access.${client_id}.roles	claim.name
d161c81c-5a70-437a-bb40-988da4fd6a7b	String	jsonType.label
22ac0b10-151e-4209-82b0-965e9cca4ac5	true	multivalued
22ac0b10-151e-4209-82b0-965e9cca4ac5	foo	user.attribute
22ac0b10-151e-4209-82b0-965e9cca4ac5	true	id.token.claim
22ac0b10-151e-4209-82b0-965e9cca4ac5	true	access.token.claim
22ac0b10-151e-4209-82b0-965e9cca4ac5	groups	claim.name
22ac0b10-151e-4209-82b0-965e9cca4ac5	String	jsonType.label
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	true	userinfo.token.claim
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	username	user.attribute
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	true	id.token.claim
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	true	access.token.claim
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	upn	claim.name
ad9b523e-0bc3-41a2-a7a4-8f2ae4529410	String	jsonType.label
977c3f87-e0a2-42ad-9d28-a4df69c34309	true	id.token.claim
977c3f87-e0a2-42ad-9d28-a4df69c34309	true	access.token.claim
b4c64ba2-b363-4962-af76-f4611ccda15b	false	single
b4c64ba2-b363-4962-af76-f4611ccda15b	Basic	attribute.nameformat
b4c64ba2-b363-4962-af76-f4611ccda15b	Role	attribute.name
26e0125b-1c27-4f70-9572-30f3eb945acf	true	userinfo.token.claim
26e0125b-1c27-4f70-9572-30f3eb945acf	updatedAt	user.attribute
26e0125b-1c27-4f70-9572-30f3eb945acf	true	id.token.claim
26e0125b-1c27-4f70-9572-30f3eb945acf	true	access.token.claim
26e0125b-1c27-4f70-9572-30f3eb945acf	updated_at	claim.name
26e0125b-1c27-4f70-9572-30f3eb945acf	long	jsonType.label
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	true	userinfo.token.claim
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	website	user.attribute
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	true	id.token.claim
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	true	access.token.claim
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	website	claim.name
2a5067f4-78d0-4bde-86e2-c7d6e002b82c	String	jsonType.label
397ae89d-85d8-4e00-9a36-2d6d9f14029e	true	userinfo.token.claim
397ae89d-85d8-4e00-9a36-2d6d9f14029e	profile	user.attribute
397ae89d-85d8-4e00-9a36-2d6d9f14029e	true	id.token.claim
397ae89d-85d8-4e00-9a36-2d6d9f14029e	true	access.token.claim
397ae89d-85d8-4e00-9a36-2d6d9f14029e	profile	claim.name
397ae89d-85d8-4e00-9a36-2d6d9f14029e	String	jsonType.label
465435fe-d3d3-4e40-bf17-9627acd92471	true	userinfo.token.claim
465435fe-d3d3-4e40-bf17-9627acd92471	lastName	user.attribute
465435fe-d3d3-4e40-bf17-9627acd92471	true	id.token.claim
465435fe-d3d3-4e40-bf17-9627acd92471	true	access.token.claim
465435fe-d3d3-4e40-bf17-9627acd92471	family_name	claim.name
465435fe-d3d3-4e40-bf17-9627acd92471	String	jsonType.label
4aa44903-1bd0-4624-85af-807103ea7894	true	userinfo.token.claim
4aa44903-1bd0-4624-85af-807103ea7894	gender	user.attribute
4aa44903-1bd0-4624-85af-807103ea7894	true	id.token.claim
4aa44903-1bd0-4624-85af-807103ea7894	true	access.token.claim
4aa44903-1bd0-4624-85af-807103ea7894	gender	claim.name
4aa44903-1bd0-4624-85af-807103ea7894	String	jsonType.label
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	true	userinfo.token.claim
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	firstName	user.attribute
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	true	id.token.claim
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	true	access.token.claim
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	given_name	claim.name
5a5a9df4-8e47-49ed-8110-d9abd7f9bf88	String	jsonType.label
7271a116-3725-4f08-b784-caf0e4ce4dd3	true	userinfo.token.claim
7271a116-3725-4f08-b784-caf0e4ce4dd3	zoneinfo	user.attribute
7271a116-3725-4f08-b784-caf0e4ce4dd3	true	id.token.claim
7271a116-3725-4f08-b784-caf0e4ce4dd3	true	access.token.claim
7271a116-3725-4f08-b784-caf0e4ce4dd3	zoneinfo	claim.name
7271a116-3725-4f08-b784-caf0e4ce4dd3	String	jsonType.label
8474249b-d869-4c0c-83ba-6de1adddb3a8	true	userinfo.token.claim
8474249b-d869-4c0c-83ba-6de1adddb3a8	username	user.attribute
8474249b-d869-4c0c-83ba-6de1adddb3a8	true	id.token.claim
8474249b-d869-4c0c-83ba-6de1adddb3a8	true	access.token.claim
8474249b-d869-4c0c-83ba-6de1adddb3a8	preferred_username	claim.name
8474249b-d869-4c0c-83ba-6de1adddb3a8	String	jsonType.label
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	true	userinfo.token.claim
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	picture	user.attribute
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	true	id.token.claim
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	true	access.token.claim
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	picture	claim.name
cc01a6ba-2129-42db-bd27-f5f9e39a68d9	String	jsonType.label
d222fa05-e16b-42c4-aae8-7f5ae873cec7	true	userinfo.token.claim
d222fa05-e16b-42c4-aae8-7f5ae873cec7	birthdate	user.attribute
d222fa05-e16b-42c4-aae8-7f5ae873cec7	true	id.token.claim
d222fa05-e16b-42c4-aae8-7f5ae873cec7	true	access.token.claim
d222fa05-e16b-42c4-aae8-7f5ae873cec7	birthdate	claim.name
d222fa05-e16b-42c4-aae8-7f5ae873cec7	String	jsonType.label
dbd22a7f-365b-4568-afba-cb3da762ce11	true	userinfo.token.claim
dbd22a7f-365b-4568-afba-cb3da762ce11	nickname	user.attribute
dbd22a7f-365b-4568-afba-cb3da762ce11	true	id.token.claim
dbd22a7f-365b-4568-afba-cb3da762ce11	true	access.token.claim
dbd22a7f-365b-4568-afba-cb3da762ce11	nickname	claim.name
dbd22a7f-365b-4568-afba-cb3da762ce11	String	jsonType.label
eab84936-734d-459d-9efd-affb075b7b33	true	userinfo.token.claim
eab84936-734d-459d-9efd-affb075b7b33	true	id.token.claim
eab84936-734d-459d-9efd-affb075b7b33	true	access.token.claim
ead9a777-12c3-4b64-8754-3a13d703a6b1	true	userinfo.token.claim
ead9a777-12c3-4b64-8754-3a13d703a6b1	middleName	user.attribute
ead9a777-12c3-4b64-8754-3a13d703a6b1	true	id.token.claim
ead9a777-12c3-4b64-8754-3a13d703a6b1	true	access.token.claim
ead9a777-12c3-4b64-8754-3a13d703a6b1	middle_name	claim.name
ead9a777-12c3-4b64-8754-3a13d703a6b1	String	jsonType.label
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	true	userinfo.token.claim
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	locale	user.attribute
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	true	id.token.claim
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	true	access.token.claim
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	locale	claim.name
fd9e99b6-3a3c-4862-8c04-f2a48d7c6462	String	jsonType.label
c0974f7a-a77e-4adb-abfb-072a589963a0	true	userinfo.token.claim
c0974f7a-a77e-4adb-abfb-072a589963a0	email	user.attribute
c0974f7a-a77e-4adb-abfb-072a589963a0	true	id.token.claim
c0974f7a-a77e-4adb-abfb-072a589963a0	true	access.token.claim
c0974f7a-a77e-4adb-abfb-072a589963a0	email	claim.name
c0974f7a-a77e-4adb-abfb-072a589963a0	String	jsonType.label
ffa873fc-3954-4b74-b555-2b75b2be2ebc	true	userinfo.token.claim
ffa873fc-3954-4b74-b555-2b75b2be2ebc	emailVerified	user.attribute
ffa873fc-3954-4b74-b555-2b75b2be2ebc	true	id.token.claim
ffa873fc-3954-4b74-b555-2b75b2be2ebc	true	access.token.claim
ffa873fc-3954-4b74-b555-2b75b2be2ebc	email_verified	claim.name
ffa873fc-3954-4b74-b555-2b75b2be2ebc	boolean	jsonType.label
b98aceb5-1326-480a-acd0-70573583add1	formatted	user.attribute.formatted
b98aceb5-1326-480a-acd0-70573583add1	country	user.attribute.country
b98aceb5-1326-480a-acd0-70573583add1	postal_code	user.attribute.postal_code
b98aceb5-1326-480a-acd0-70573583add1	true	userinfo.token.claim
b98aceb5-1326-480a-acd0-70573583add1	street	user.attribute.street
b98aceb5-1326-480a-acd0-70573583add1	true	id.token.claim
b98aceb5-1326-480a-acd0-70573583add1	region	user.attribute.region
b98aceb5-1326-480a-acd0-70573583add1	true	access.token.claim
b98aceb5-1326-480a-acd0-70573583add1	locality	user.attribute.locality
ed7e9cd5-5c85-4c60-babb-05a8c5341021	true	userinfo.token.claim
ed7e9cd5-5c85-4c60-babb-05a8c5341021	phoneNumberVerified	user.attribute
ed7e9cd5-5c85-4c60-babb-05a8c5341021	true	id.token.claim
ed7e9cd5-5c85-4c60-babb-05a8c5341021	true	access.token.claim
ed7e9cd5-5c85-4c60-babb-05a8c5341021	phone_number_verified	claim.name
ed7e9cd5-5c85-4c60-babb-05a8c5341021	boolean	jsonType.label
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	true	userinfo.token.claim
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	phoneNumber	user.attribute
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	true	id.token.claim
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	true	access.token.claim
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	phone_number	claim.name
f904adbd-d9b7-4ea7-94d0-3f8517d089e6	String	jsonType.label
29cfb5a0-c2f6-49c8-b865-244a22e379d4	true	multivalued
29cfb5a0-c2f6-49c8-b865-244a22e379d4	foo	user.attribute
29cfb5a0-c2f6-49c8-b865-244a22e379d4	true	access.token.claim
29cfb5a0-c2f6-49c8-b865-244a22e379d4	resource_access.${client_id}.roles	claim.name
29cfb5a0-c2f6-49c8-b865-244a22e379d4	String	jsonType.label
8c7e7126-9bc9-42ed-bd91-54a41507feaa	true	multivalued
8c7e7126-9bc9-42ed-bd91-54a41507feaa	foo	user.attribute
8c7e7126-9bc9-42ed-bd91-54a41507feaa	true	access.token.claim
8c7e7126-9bc9-42ed-bd91-54a41507feaa	realm_access.roles	claim.name
8c7e7126-9bc9-42ed-bd91-54a41507feaa	String	jsonType.label
627976e7-07b3-4b7a-a7cb-99da88b861dc	true	multivalued
627976e7-07b3-4b7a-a7cb-99da88b861dc	foo	user.attribute
627976e7-07b3-4b7a-a7cb-99da88b861dc	true	id.token.claim
627976e7-07b3-4b7a-a7cb-99da88b861dc	true	access.token.claim
627976e7-07b3-4b7a-a7cb-99da88b861dc	groups	claim.name
627976e7-07b3-4b7a-a7cb-99da88b861dc	String	jsonType.label
b953eac5-cbce-43df-9555-f7190b677d20	true	userinfo.token.claim
b953eac5-cbce-43df-9555-f7190b677d20	username	user.attribute
b953eac5-cbce-43df-9555-f7190b677d20	true	id.token.claim
b953eac5-cbce-43df-9555-f7190b677d20	true	access.token.claim
b953eac5-cbce-43df-9555-f7190b677d20	upn	claim.name
b953eac5-cbce-43df-9555-f7190b677d20	String	jsonType.label
5477a353-7133-4922-84bf-1d7c2c2a37ee	true	id.token.claim
5477a353-7133-4922-84bf-1d7c2c2a37ee	true	access.token.claim
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	true	userinfo.token.claim
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	locale	user.attribute
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	true	id.token.claim
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	true	access.token.claim
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	locale	claim.name
45aa7d6b-ea5c-4c1a-b2c9-25c9e32b03ff	String	jsonType.label
c1356b52-f5ca-4332-a39e-ebd659bb328f	true	userinfo.token.claim
c1356b52-f5ca-4332-a39e-ebd659bb328f	company_slug	user.attribute
c1356b52-f5ca-4332-a39e-ebd659bb328f	true	id.token.claim
c1356b52-f5ca-4332-a39e-ebd659bb328f	true	access.token.claim
c1356b52-f5ca-4332-a39e-ebd659bb328f	company_slug	claim.name
c1356b52-f5ca-4332-a39e-ebd659bb328f	String	jsonType.label
\.


--
-- TOC entry 4177 (class 0 OID 16645)
-- Dependencies: 267
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	2e527d92-7ea4-4944-ae26-b5a34aec87cb	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	507f64f1-fbf8-46ad-b58a-9a8e30ab195d	596eacd4-8a8e-46f7-b8e9-65fb90619f1e	2c7169e5-8b4e-42d0-8528-98a607b766e8	d5ef22a2-5d02-4a03-b402-ae48b9dafbb1	74e36e0a-27ab-4ab9-be8e-df34337e18da	2592000	f	900	t	f	92709a50-37bf-492f-beef-6c42d5604eb5	0	f	0	0	bf70a6ae-f397-4b6b-8df7-14746bf7cf5e
f22bc560-708c-401c-ad05-2dbb1cda77dd	60	300	300	\N	\N	\N	t	f	0	\N	api	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	7b1b68dc-583f-4952-bd7f-dcce425bf42e	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	bab30669-6c44-49d5-95c0-c6ab266d3f87	db1ad190-2a35-46f7-9a9b-b8c95fee3ca0	2d2ba200-7a62-4c71-a80f-e360ad8a0402	68da3da3-118a-417a-9392-0f8237ffe2f9	155576ad-86b2-40ed-9d53-761c460a13bc	2592000	f	900	t	f	1d3daad3-a767-4c69-9bc0-669f96814ece	0	f	0	0	095bc3e8-37d4-4ce4-b47c-e5fa9d000f26
\.


--
-- TOC entry 4178 (class 0 OID 16678)
-- Dependencies: 268
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	
_browser_header.xContentTypeOptions	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	nosniff
_browser_header.referrerPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	no-referrer
_browser_header.xRobotsTag	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	none
_browser_header.xFrameOptions	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SAMEORIGIN
_browser_header.contentSecurityPolicy	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	1; mode=block
_browser_header.strictTransportSecurity	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	max-age=31536000; includeSubDomains
bruteForceProtected	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	false
permanentLockout	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	false
maxFailureWaitSeconds	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	900
minimumQuickLoginWaitSeconds	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	60
waitIncrementSeconds	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	60
quickLoginCheckMilliSeconds	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	1000
maxDeltaTimeSeconds	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	43200
failureFactor	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	30
realmReusableOtpCode	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	false
displayName	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	Keycloak
displayNameHtml	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	RS256
offlineSessionMaxLifespanEnabled	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	false
offlineSessionMaxLifespan	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	5184000
realmReusableOtpCode	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
oauth2DeviceCodeLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	600
oauth2DevicePollingInterval	f22bc560-708c-401c-ad05-2dbb1cda77dd	5
cibaBackchannelTokenDeliveryMode	f22bc560-708c-401c-ad05-2dbb1cda77dd	poll
cibaExpiresIn	f22bc560-708c-401c-ad05-2dbb1cda77dd	120
cibaInterval	f22bc560-708c-401c-ad05-2dbb1cda77dd	5
cibaAuthRequestedUserHint	f22bc560-708c-401c-ad05-2dbb1cda77dd	login_hint
parRequestUriLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	60
clientSessionIdleTimeout	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
clientSessionMaxLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
clientOfflineSessionIdleTimeout	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
clientOfflineSessionMaxLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
bruteForceProtected	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
permanentLockout	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
maxFailureWaitSeconds	f22bc560-708c-401c-ad05-2dbb1cda77dd	900
minimumQuickLoginWaitSeconds	f22bc560-708c-401c-ad05-2dbb1cda77dd	60
waitIncrementSeconds	f22bc560-708c-401c-ad05-2dbb1cda77dd	60
quickLoginCheckMilliSeconds	f22bc560-708c-401c-ad05-2dbb1cda77dd	1000
maxDeltaTimeSeconds	f22bc560-708c-401c-ad05-2dbb1cda77dd	43200
failureFactor	f22bc560-708c-401c-ad05-2dbb1cda77dd	30
actionTokenGeneratedByAdminLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	43200
actionTokenGeneratedByUserLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	300
defaultSignatureAlgorithm	f22bc560-708c-401c-ad05-2dbb1cda77dd	RS256
offlineSessionMaxLifespanEnabled	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
offlineSessionMaxLifespan	f22bc560-708c-401c-ad05-2dbb1cda77dd	5184000
webAuthnPolicyRpEntityName	f22bc560-708c-401c-ad05-2dbb1cda77dd	keycloak
webAuthnPolicySignatureAlgorithms	f22bc560-708c-401c-ad05-2dbb1cda77dd	ES256
webAuthnPolicyRpId	f22bc560-708c-401c-ad05-2dbb1cda77dd	
webAuthnPolicyAttestationConveyancePreference	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyAuthenticatorAttachment	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyRequireResidentKey	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyUserVerificationRequirement	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyCreateTimeout	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
webAuthnPolicyAvoidSameAuthenticatorRegister	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
webAuthnPolicyRpEntityNamePasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	ES256
webAuthnPolicyRpIdPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	
webAuthnPolicyAttestationConveyancePreferencePasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyRequireResidentKeyPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	not specified
webAuthnPolicyCreateTimeoutPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	false
client-policies.profiles	f22bc560-708c-401c-ad05-2dbb1cda77dd	{"profiles":[]}
client-policies.policies	f22bc560-708c-401c-ad05-2dbb1cda77dd	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	f22bc560-708c-401c-ad05-2dbb1cda77dd	
_browser_header.xContentTypeOptions	f22bc560-708c-401c-ad05-2dbb1cda77dd	nosniff
_browser_header.referrerPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	no-referrer
_browser_header.xRobotsTag	f22bc560-708c-401c-ad05-2dbb1cda77dd	none
_browser_header.xFrameOptions	f22bc560-708c-401c-ad05-2dbb1cda77dd	SAMEORIGIN
_browser_header.contentSecurityPolicy	f22bc560-708c-401c-ad05-2dbb1cda77dd	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	f22bc560-708c-401c-ad05-2dbb1cda77dd	1; mode=block
_browser_header.strictTransportSecurity	f22bc560-708c-401c-ad05-2dbb1cda77dd	max-age=31536000; includeSubDomains
\.


--
-- TOC entry 4179 (class 0 OID 16683)
-- Dependencies: 269
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 4180 (class 0 OID 16686)
-- Dependencies: 270
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_CONSENT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_RESET_PASSWORD
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	GRANT_CONSENT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	VERIFY_PROFILE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_TOTP
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REMOVE_TOTP
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REVOKE_GRANT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	LOGIN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_LOGIN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	RESET_PASSWORD_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IMPERSONATE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CODE_TO_TOKEN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CUSTOM_REQUIRED_ACTION
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_CODE_TO_TOKEN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	RESTART_AUTHENTICATION
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_PROFILE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IMPERSONATE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	LOGIN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_PASSWORD_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_VERIFY_USER_CODE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_INITIATED_ACCOUNT_LINKING
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	TOKEN_EXCHANGE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REGISTER
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	LOGOUT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	AUTHREQID_TO_TOKEN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	DELETE_ACCOUNT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_REGISTER
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_LINK_ACCOUNT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_PASSWORD
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	DELETE_ACCOUNT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	FEDERATED_IDENTITY_LINK_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_DELETE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_FIRST_LOGIN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	VERIFY_EMAIL
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_DELETE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_LOGIN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	RESTART_AUTHENTICATION_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REMOVE_FEDERATED_IDENTITY_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	EXECUTE_ACTIONS
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	TOKEN_EXCHANGE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	PERMISSION_TOKEN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_IDENTITY_PROVIDER_LINK_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	EXECUTE_ACTION_TOKEN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_VERIFY_EMAIL
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_AUTH
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	EXECUTE_ACTIONS_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REMOVE_FEDERATED_IDENTITY
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_CODE_TO_TOKEN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_POST_LOGIN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_LINK_ACCOUNT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_EMAIL
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_VERIFY_USER_CODE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REGISTER_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REVOKE_GRANT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	LOGOUT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_EMAIL_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	EXECUTE_ACTION_TOKEN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_UPDATE_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_PROFILE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	AUTHREQID_TO_TOKEN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	FEDERATED_IDENTITY_LINK
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_REGISTER_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_VERIFY_EMAIL_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_IDENTITY_PROVIDER_LINK
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	RESET_PASSWORD
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_INITIATED_ACCOUNT_LINKING_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	OAUTH2_DEVICE_AUTH_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_CONSENT
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	REMOVE_TOTP_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	VERIFY_EMAIL_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	SEND_RESET_PASSWORD_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CLIENT_UPDATE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_POST_LOGIN_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CUSTOM_REQUIRED_ACTION_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	UPDATE_TOTP_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	CODE_TO_TOKEN
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	VERIFY_PROFILE
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	GRANT_CONSENT_ERROR
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	IDENTITY_PROVIDER_FIRST_LOGIN_ERROR
\.


--
-- TOC entry 4181 (class 0 OID 16689)
-- Dependencies: 271
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
f22bc560-708c-401c-ad05-2dbb1cda77dd	jboss-logging
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	metrics-listener
e57cceb5-7637-45fa-b2ba-ebbba563f9c9	jboss-logging
\.


--
-- TOC entry 4182 (class 0 OID 16692)
-- Dependencies: 272
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 4183 (class 0 OID 16697)
-- Dependencies: 273
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	e57cceb5-7637-45fa-b2ba-ebbba563f9c9
password	password	t	t	f22bc560-708c-401c-ad05-2dbb1cda77dd
\.


--
-- TOC entry 4184 (class 0 OID 16704)
-- Dependencies: 274
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 4185 (class 0 OID 16709)
-- Dependencies: 275
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- TOC entry 4186 (class 0 OID 16712)
-- Dependencies: 276
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.redirect_uris (client_id, value) FROM stdin;
e154faf5-b5d2-4799-9bd6-8bdaa349601b	/realms/master/account/*
d67b2d04-0a42-4877-ad42-fb7ac325e66d	/realms/master/account/*
3f12da87-c610-479c-a8b8-e17bd2941cdc	/admin/master/console/*
659d2ff1-0b5c-482a-9c34-73def2ec2d0f	/realms/api/account/*
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	/realms/api/account/*
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	/admin/api/console/*
daa819c5-ca52-4936-8800-7116fdfe0d54	*
\.


--
-- TOC entry 4187 (class 0 OID 16715)
-- Dependencies: 277
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 4188 (class 0 OID 16720)
-- Dependencies: 278
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
568330d5-d975-47c4-a357-1d946bac242d	VERIFY_EMAIL	Verify Email	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	VERIFY_EMAIL	50
d74956cc-1863-4515-a3f7-40b6b71a4845	UPDATE_PROFILE	Update Profile	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	UPDATE_PROFILE	40
7037b7ce-ac68-4ae3-a355-8c53182128b7	CONFIGURE_TOTP	Configure OTP	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	CONFIGURE_TOTP	10
0546f586-e3bc-4143-bffc-97dd5c86ca75	UPDATE_PASSWORD	Update Password	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	UPDATE_PASSWORD	30
876c57d4-0533-4b11-ba8e-b574aa0fdb2b	TERMS_AND_CONDITIONS	Terms and Conditions	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	f	TERMS_AND_CONDITIONS	20
0662d63d-291e-4d5e-a673-ac1a90d87bc2	delete_account	Delete Account	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	f	f	delete_account	60
03ad92d9-4479-4e40-9f4b-2bd7c4260bd1	update_user_locale	Update User Locale	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	update_user_locale	1000
c4008e09-d64f-4741-93b2-fd9000212f6a	webauthn-register	Webauthn Register	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	webauthn-register	70
46ac06fa-56a3-4654-85ca-459705b5595b	webauthn-register-passwordless	Webauthn Register Passwordless	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	t	f	webauthn-register-passwordless	80
7828b2e2-67b0-46c3-956d-791cd4c012cc	VERIFY_EMAIL	Verify Email	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	VERIFY_EMAIL	50
10b046d8-03f7-4bf3-8682-71ee41bb8ba3	UPDATE_PROFILE	Update Profile	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	UPDATE_PROFILE	40
b971ab68-8c38-4e86-8714-9b130b5641e0	CONFIGURE_TOTP	Configure OTP	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	CONFIGURE_TOTP	10
8ac50c1e-55e6-4aa8-b7b5-f99074f9ebee	UPDATE_PASSWORD	Update Password	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	UPDATE_PASSWORD	30
5ded2658-4d98-4063-a527-e3304064838f	TERMS_AND_CONDITIONS	Terms and Conditions	f22bc560-708c-401c-ad05-2dbb1cda77dd	f	f	TERMS_AND_CONDITIONS	20
0b4f4cb3-473e-48f5-b53d-4a0f7881c669	delete_account	Delete Account	f22bc560-708c-401c-ad05-2dbb1cda77dd	f	f	delete_account	60
568ced69-e022-40ad-92e9-27eeb5afe40b	update_user_locale	Update User Locale	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	update_user_locale	1000
049ceb90-ab48-4a98-b2fb-db61582b0679	webauthn-register	Webauthn Register	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	webauthn-register	70
7db80bb6-c5c5-4245-a3df-98d67ac3084b	webauthn-register-passwordless	Webauthn Register Passwordless	f22bc560-708c-401c-ad05-2dbb1cda77dd	t	f	webauthn-register-passwordless	80
\.


--
-- TOC entry 4189 (class 0 OID 16727)
-- Dependencies: 279
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 4190 (class 0 OID 16733)
-- Dependencies: 280
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4191 (class 0 OID 16736)
-- Dependencies: 281
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4192 (class 0 OID 16739)
-- Dependencies: 282
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 4193 (class 0 OID 16744)
-- Dependencies: 283
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4194 (class 0 OID 16749)
-- Dependencies: 284
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 4195 (class 0 OID 16754)
-- Dependencies: 285
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 4196 (class 0 OID 16760)
-- Dependencies: 286
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 4197 (class 0 OID 16765)
-- Dependencies: 287
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 4198 (class 0 OID 16768)
-- Dependencies: 288
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 4199 (class 0 OID 16773)
-- Dependencies: 289
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
d67b2d04-0a42-4877-ad42-fb7ac325e66d	e18fc46e-739b-4263-8f0d-d925a9685515
d67b2d04-0a42-4877-ad42-fb7ac325e66d	0492795f-e5e1-4622-8f85-9ddd89df99b4
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	b47c7cba-69cf-4e0b-a1b8-a12c7ea1e939
a1bfb4b2-02d3-414a-b8e0-5a932fc5c304	63aecec0-af48-4eea-9d80-64b9024d00ce
\.


--
-- TOC entry 4200 (class 0 OID 16776)
-- Dependencies: 290
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4201 (class 0 OID 16779)
-- Dependencies: 291
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
company_slug	back-office	18dd4c24-a575-4944-97b5-4d7e60e4b2ee	81481643-3e37-43c1-908d-f5e128d2028b
company_slug	back-office	864b40d8-4b9c-4c63-84ae-59b96397e000	4d6c5a7c-bafd-41fe-8911-8f18f0e351d4
company_slug	management	634d8884-417a-4592-bc9c-fc4738dc4547	5ac7fd99-25c3-4aca-8600-b94a3645d33f
company_slug	management	d2fbe307-308c-4afa-9db6-21db9233aba0	62478294-9bea-48f2-83b7-0112d36f1495
company_slug	platform	181edd3e-372a-4ecb-9e6a-41a5bd02db0c	597d7d1b-80e9-4191-86c4-9b2099034164
company_slug	platform	6ce64cf0-3e5c-40dc-aa62-822d55d5278d	e74036ee-765b-43e4-b08d-2a1cb840dbfe
\.


--
-- TOC entry 4202 (class 0 OID 16785)
-- Dependencies: 292
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4203 (class 0 OID 16790)
-- Dependencies: 293
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4204 (class 0 OID 16793)
-- Dependencies: 294
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
7d08b9b5-bb0e-48c3-8158-2474ae3e38a2	\N	071cc69e-9790-4ed1-98aa-c798d4be66d2	f	t	\N	\N	\N	e57cceb5-7637-45fa-b2ba-ebbba563f9c9	admin	1694111991899	\N	0
634d8884-417a-4592-bc9c-fc4738dc4547	management_admin@cloud-diplomats.com	management_admin@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	management_admin	1700222166608	\N	0
d2fbe307-308c-4afa-9db6-21db9233aba0	management_user@cloud-diplomats.com	management_user@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	management_user	1700222189751	\N	0
181edd3e-372a-4ecb-9e6a-41a5bd02db0c	platform_admin@cloud-diplomats.com	platform_admin@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	platform_admin	1694893076540	\N	0
18dd4c24-a575-4944-97b5-4d7e60e4b2ee	back_office_admin@cloud-diplomats.com	back_office_admin@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	back_office_admin	1694112582470	\N	0
864b40d8-4b9c-4c63-84ae-59b96397e000	back_office_user@cloud-diplomats.com	back_office_user@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	back_office_user	1694112567788	\N	0
6ce64cf0-3e5c-40dc-aa62-822d55d5278d	platform_user@cloud-diplomats.com	platform_user@cloud-diplomats.com	t	t	\N	\N	\N	f22bc560-708c-401c-ad05-2dbb1cda77dd	platform_user	1694893109445	\N	0
\.


--
-- TOC entry 4205 (class 0 OID 16801)
-- Dependencies: 295
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4206 (class 0 OID 16806)
-- Dependencies: 296
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 4207 (class 0 OID 16811)
-- Dependencies: 297
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4208 (class 0 OID 16816)
-- Dependencies: 298
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4209 (class 0 OID 16821)
-- Dependencies: 299
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
2871365d-80f9-4737-b5e1-e154c32ce038	864b40d8-4b9c-4c63-84ae-59b96397e000
d6c1cf29-8f2b-4eb6-8424-c077d0885596	18dd4c24-a575-4944-97b5-4d7e60e4b2ee
ca61efdb-4e04-4bf2-9a23-2c77ec67a379	181edd3e-372a-4ecb-9e6a-41a5bd02db0c
d5056ac9-3374-40ef-a83f-2750e1af3ac2	6ce64cf0-3e5c-40dc-aa62-822d55d5278d
3c054a19-10e2-4fe8-882d-09bfbd14d35d	634d8884-417a-4592-bc9c-fc4738dc4547
1b355c03-21a2-45f2-9055-556f9b21736f	d2fbe307-308c-4afa-9db6-21db9233aba0
\.


--
-- TOC entry 4210 (class 0 OID 16824)
-- Dependencies: 300
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 4211 (class 0 OID 16828)
-- Dependencies: 301
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
bf70a6ae-f397-4b6b-8df7-14746bf7cf5e	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
7342caa7-272c-405b-8bd1-77780993163a	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
cd553226-0cd7-46c2-86ed-7319f4b14db4	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
fb7500e4-2304-4fe9-8042-4f1cd0453270	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
3b6820bb-c823-4510-ac29-c59a0a641357	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
d34edce2-b506-464c-b7d2-e73c1d4c74d6	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
c7dcc599-16d8-4cc8-b88f-075592720a52	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
859404e1-8a7b-46cd-9b38-67fedd6b4516	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
80675e7f-b919-45c1-894b-061d1e7e06b6	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
cfe75d36-0907-4d1c-928c-0362d574472d	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
3f406d9b-cdd1-4430-ac27-25a2796c46e4	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
57eb9c9a-89a2-474e-9cc2-64b52c1ebc75	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
2d8cb5c1-9f57-4868-93cd-f1f75e789c46	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
51fa827a-c86f-44a0-b95d-ee52f7c17dd5	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
4824db0d-a398-46ab-95bf-2c317f88b846	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
783f713b-a7ff-48c9-bfec-dac37ec06bc1	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
7fb85825-9810-42d9-8707-891c11fb3111	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
1b01bd7b-43a8-43fb-b036-2a908723f61d	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
b46e4418-17e0-42ea-8049-aafd345505fc	7d08b9b5-bb0e-48c3-8158-2474ae3e38a2
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	864b40d8-4b9c-4c63-84ae-59b96397e000
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	18dd4c24-a575-4944-97b5-4d7e60e4b2ee
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	181edd3e-372a-4ecb-9e6a-41a5bd02db0c
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	6ce64cf0-3e5c-40dc-aa62-822d55d5278d
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	634d8884-417a-4592-bc9c-fc4738dc4547
095bc3e8-37d4-4ce4-b47c-e5fa9d000f26	d2fbe307-308c-4afa-9db6-21db9233aba0
\.


--
-- TOC entry 4212 (class 0 OID 16831)
-- Dependencies: 302
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 4213 (class 0 OID 16837)
-- Dependencies: 303
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 4214 (class 0 OID 16842)
-- Dependencies: 304
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 4215 (class 0 OID 16847)
-- Dependencies: 305
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.web_origins (client_id, value) FROM stdin;
3f12da87-c610-479c-a8b8-e17bd2941cdc	+
8d71fd9c-c39f-44d3-bda2-39e55b8cc9a3	+
daa819c5-ca52-4936-8800-7116fdfe0d54	*
\.


--
-- TOC entry 3904 (class 2606 OID 16851)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3757 (class 2606 OID 16853)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3643 (class 2606 OID 16855)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3658 (class 2606 OID 16857)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3645 (class 2606 OID 16859)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3792 (class 2606 OID 16861)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3634 (class 2606 OID 16863)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3677 (class 2606 OID 16865)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3683 (class 2606 OID 16867)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3679 (class 2606 OID 16869)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3720 (class 2606 OID 16871)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3702 (class 2606 OID 16873)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3705 (class 2606 OID 16875)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3712 (class 2606 OID 16877)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3716 (class 2606 OID 16879)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3724 (class 2606 OID 16881)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3732 (class 2606 OID 16883)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3794 (class 2606 OID 16885)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3797 (class 2606 OID 16887)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3800 (class 2606 OID 16889)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3809 (class 2606 OID 16891)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3741 (class 2606 OID 16893)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3641 (class 2606 OID 16895)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3699 (class 2606 OID 16897)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3728 (class 2606 OID 16899)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3784 (class 2606 OID 16901)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3675 (class 2606 OID 16903)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3900 (class 2606 OID 16905)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3888 (class 2606 OID 16907)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3671 (class 2606 OID 16909)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3636 (class 2606 OID 16911)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3666 (class 2606 OID 16913)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3854 (class 2606 OID 16915)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3648 (class 2606 OID 16917)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3789 (class 2606 OID 16919)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3805 (class 2606 OID 16921)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3759 (class 2606 OID 16923)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3616 (class 2606 OID 16925)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3632 (class 2606 OID 16927)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3622 (class 2606 OID 16929)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3626 (class 2606 OID 16931)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3629 (class 2606 OID 16933)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3669 (class 2606 OID 16935)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3897 (class 2606 OID 16937)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3686 (class 2606 OID 16939)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3673 (class 2606 OID 16941)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3746 (class 2606 OID 16943)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3776 (class 2606 OID 16945)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3807 (class 2606 OID 16947)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3690 (class 2606 OID 16949)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3880 (class 2606 OID 16951)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3830 (class 2606 OID 16953)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 16955)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3834 (class 2606 OID 16957)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3619 (class 2606 OID 16959)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3822 (class 2606 OID 16961)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3844 (class 2606 OID 16963)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3825 (class 2606 OID 16965)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3857 (class 2606 OID 16967)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3872 (class 2606 OID 16969)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 16971)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3882 (class 2606 OID 16973)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3710 (class 2606 OID 16975)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3869 (class 2606 OID 16977)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3864 (class 2606 OID 16979)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3753 (class 2606 OID 16981)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3734 (class 2606 OID 16983)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3738 (class 2606 OID 16985)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3748 (class 2606 OID 16987)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3751 (class 2606 OID 16989)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3763 (class 2606 OID 16991)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3766 (class 2606 OID 16993)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3770 (class 2606 OID 16995)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3778 (class 2606 OID 16997)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3782 (class 2606 OID 16999)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3812 (class 2606 OID 17001)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3815 (class 2606 OID 17003)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3817 (class 2606 OID 17005)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3894 (class 2606 OID 17007)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3849 (class 2606 OID 17009)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3851 (class 2606 OID 17011)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 17013)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3891 (class 2606 OID 17015)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3902 (class 2606 OID 17017)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3906 (class 2606 OID 17019)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3693 (class 2606 OID 17021)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3656 (class 2606 OID 17023)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3651 (class 2606 OID 17025)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3828 (class 2606 OID 17027)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3664 (class 2606 OID 17029)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3697 (class 2606 OID 17031)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3803 (class 2606 OID 17033)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3820 (class 2606 OID 17035)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3755 (class 2606 OID 17037)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3744 (class 2606 OID 17039)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3639 (class 2606 OID 17041)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3653 (class 2606 OID 17043)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3876 (class 2606 OID 17045)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3842 (class 2606 OID 17047)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3832 (class 2606 OID 17049)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3837 (class 2606 OID 17051)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3847 (class 2606 OID 17053)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3867 (class 2606 OID 17055)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3787 (class 2606 OID 17057)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3878 (class 2606 OID 17059)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3617 (class 1259 OID 17060)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3620 (class 1259 OID 17061)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3630 (class 1259 OID 17062)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3623 (class 1259 OID 17063)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3624 (class 1259 OID 17064)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3627 (class 1259 OID 17065)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3659 (class 1259 OID 17066)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3637 (class 1259 OID 17067)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3646 (class 1259 OID 17068)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3667 (class 1259 OID 17069)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3654 (class 1259 OID 17070)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3660 (class 1259 OID 17071)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3779 (class 1259 OID 17072)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3661 (class 1259 OID 17073)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3684 (class 1259 OID 17074)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3680 (class 1259 OID 17075)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3681 (class 1259 OID 17076)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3687 (class 1259 OID 17077)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3688 (class 1259 OID 17078)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3694 (class 1259 OID 17079)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3695 (class 1259 OID 17080)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3700 (class 1259 OID 17081)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3729 (class 1259 OID 17082)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3730 (class 1259 OID 17083)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3703 (class 1259 OID 17084)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3706 (class 1259 OID 17085)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3707 (class 1259 OID 17086)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3708 (class 1259 OID 17087)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3713 (class 1259 OID 17088)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3714 (class 1259 OID 17089)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3717 (class 1259 OID 17090)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3718 (class 1259 OID 17091)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3721 (class 1259 OID 17092)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3722 (class 1259 OID 17093)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3725 (class 1259 OID 17094)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3726 (class 1259 OID 17095)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3735 (class 1259 OID 17096)
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3736 (class 1259 OID 17097)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3739 (class 1259 OID 17098)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3749 (class 1259 OID 17099)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3742 (class 1259 OID 17100)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3760 (class 1259 OID 17101)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3761 (class 1259 OID 17102)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3767 (class 1259 OID 17103)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3771 (class 1259 OID 17104)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3772 (class 1259 OID 17105)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3773 (class 1259 OID 17106)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3774 (class 1259 OID 17107)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3780 (class 1259 OID 17108)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3790 (class 1259 OID 17109)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3649 (class 1259 OID 17110)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3795 (class 1259 OID 17111)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3801 (class 1259 OID 17112)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3798 (class 1259 OID 17113)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3785 (class 1259 OID 17114)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3810 (class 1259 OID 17115)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3813 (class 1259 OID 17116)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3818 (class 1259 OID 17117)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3823 (class 1259 OID 17118)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3826 (class 1259 OID 17119)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3835 (class 1259 OID 17120)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3840 (class 1259 OID 17121)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3845 (class 1259 OID 17122)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3852 (class 1259 OID 17123)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3662 (class 1259 OID 17124)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3855 (class 1259 OID 17125)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3858 (class 1259 OID 17126)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3764 (class 1259 OID 17127)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3768 (class 1259 OID 17128)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3870 (class 1259 OID 17129)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3861 (class 1259 OID 17130)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3862 (class 1259 OID 17131)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3865 (class 1259 OID 17132)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3691 (class 1259 OID 17133)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3873 (class 1259 OID 17134)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3892 (class 1259 OID 17135)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3895 (class 1259 OID 17136)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3898 (class 1259 OID 17137)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3874 (class 1259 OID 17138)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3883 (class 1259 OID 17139)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3884 (class 1259 OID 17140)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3889 (class 1259 OID 17141)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3907 (class 1259 OID 17142)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3920 (class 2606 OID 17143)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3934 (class 2606 OID 17148)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3914 (class 2606 OID 17153)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3931 (class 2606 OID 17158)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3916 (class 2606 OID 17163)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3921 (class 2606 OID 17168)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3980 (class 2606 OID 17173)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3923 (class 2606 OID 17178)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3950 (class 2606 OID 17183)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3976 (class 2606 OID 17188)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3922 (class 2606 OID 17193)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3947 (class 2606 OID 17198)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3952 (class 2606 OID 17203)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3969 (class 2606 OID 17208)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3978 (class 2606 OID 17213)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3938 (class 2606 OID 17218)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3948 (class 2606 OID 17223)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3943 (class 2606 OID 17228)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3927 (class 2606 OID 17233)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3910 (class 2606 OID 17238)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3911 (class 2606 OID 17243)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3912 (class 2606 OID 17248)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3913 (class 2606 OID 17253)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3919 (class 2606 OID 17258)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3979 (class 2606 OID 17263)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3917 (class 2606 OID 17268)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3918 (class 2606 OID 17273)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3924 (class 2606 OID 17278)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3940 (class 2606 OID 17283)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3915 (class 2606 OID 17288)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3926 (class 2606 OID 17293)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 3925 (class 2606 OID 17298)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3944 (class 2606 OID 17303)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3975 (class 2606 OID 17308)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3973 (class 2606 OID 17313)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3974 (class 2606 OID 17318)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3908 (class 2606 OID 17323)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3967 (class 2606 OID 17328)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3957 (class 2606 OID 17333)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3962 (class 2606 OID 17338)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3958 (class 2606 OID 17343)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3959 (class 2606 OID 17348)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3909 (class 2606 OID 17353)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3968 (class 2606 OID 17358)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3960 (class 2606 OID 17363)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3961 (class 2606 OID 17368)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3955 (class 2606 OID 17373)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3953 (class 2606 OID 17378)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3954 (class 2606 OID 17383)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3956 (class 2606 OID 17388)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3963 (class 2606 OID 17393)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3928 (class 2606 OID 17398)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3971 (class 2606 OID 17403)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3970 (class 2606 OID 17408)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3932 (class 2606 OID 17413)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3933 (class 2606 OID 17418)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3945 (class 2606 OID 17423)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3946 (class 2606 OID 17428)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3936 (class 2606 OID 17433)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3937 (class 2606 OID 17438)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3981 (class 2606 OID 17443)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3966 (class 2606 OID 17448)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3941 (class 2606 OID 17453)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3929 (class 2606 OID 17458)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3942 (class 2606 OID 17463)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 3930 (class 2606 OID 17468)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3951 (class 2606 OID 17473)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3964 (class 2606 OID 17478)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3965 (class 2606 OID 17483)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3949 (class 2606 OID 17488)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3972 (class 2606 OID 17493)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3977 (class 2606 OID 17498)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3939 (class 2606 OID 17503)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3935 (class 2606 OID 17508)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


-- Completed on 2023-11-17 15:49:28 -03

--
-- PostgreSQL database dump complete
--

