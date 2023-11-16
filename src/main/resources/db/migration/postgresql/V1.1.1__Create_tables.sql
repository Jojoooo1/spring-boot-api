CREATE TABLE public.company (
  id bigserial PRIMARY KEY,
  -- id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- can not be used cf. https://github.com/vladmihalcea/hypersistence-utils/issues/1
  slug varchar(255) NOT NULL UNIQUE,
  name varchar(255) NOT NULL UNIQUE,
  official_name varchar(255) UNIQUE,
  state_tax_id varchar(255),
  federal_tax_id varchar(255) UNIQUE, -- CNPJ
  phone varchar(255),
  email varchar(255),

  address_street varchar(255),
  address_street_number varchar(255),
  address_complement varchar(255),
  address_city_district varchar(255),
  address_post_code varchar(255),
  address_city varchar(255),
  address_state_code varchar(255),
  address_country varchar(255),
  address_latitude numeric,
  address_longitude numeric,

  is_platform boolean DEFAULT false,
  is_back_office boolean DEFAULT false,
  is_internal boolean DEFAULT false,
  is_management boolean DEFAULT false,

  created_by varchar(255),
  updated_by varchar(255),

  created_at timestamp NOT NULL,
  updated_at timestamp NOT NULL
);

CREATE TABLE public.api_key
(
    id bigserial PRIMARY KEY,
    -- id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY, -- can not be used cf. https://github.com/vladmihalcea/hypersistence-utils/issues/1
    company_id bigint NOT NULL REFERENCES company (id),
    name varchar(255) NOT NULL,
    key varchar(255) NOT NULL UNIQUE,
    is_active boolean NOT NULL DEFAULT FALSE,

    created_by varchar(255),
    updated_by varchar(255),

    created_at timestamp NOT NULL,
    updated_at timestamp NOT NULL
);
CREATE INDEX api_key_key_is_active_idx ON api_key (key, is_active);

INSERT INTO public.company (slug, name, email, created_at, updated_at)
VALUES ('management', 'management-company', 'management-company@gmail.com', NOW(), NOW());

INSERT INTO public.company (slug, name, email, created_at, updated_at)
VALUES ('back-office', 'back-office-company', 'back-office-company@gmail.com', NOW(), NOW());

INSERT INTO public.company (slug, name, email, is_internal, created_at, updated_at)
VALUES ('internal', 'internal-company', 'internal-company@gmail.com', true, NOW(), NOW());
INSERT INTO public.api_key (company_id, name, key, is_active, created_at, updated_at)
VALUES (2, 'apikey-internal', 'internal-apikey', true, NOW(), NOW());

INSERT INTO public.company (slug, name, email, is_platform, created_at, updated_at)
VALUES ('platform', 'platform-company', 'platform-company@gmail.com', true, NOW(), NOW());
INSERT INTO public.api_key (company_id, name, key, is_active, created_at, updated_at)
VALUES (3, 'apikey-platform', 'platform-apikey', true, NOW(), NOW());
