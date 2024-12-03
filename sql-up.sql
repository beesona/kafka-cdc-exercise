CREATE TABLE IF NOT EXISTS public.users (
 id serial4 NOT NULL,
 email varchar(128) NOT NULL,
 first_name varchar(128) DEFAULT NULL,
 last_name varchar(128) DEFAULT NULL,
 user_name varchar(128) NOT NULL,
 created_at timestamptz NULL,
 updated_at timestamptz NULL,
 is_deleted boolean default false,
 deleted_at timestamptz NULL,
 CONSTRAINT users_email_key UNIQUE (email),
 CONSTRAINT users_pkey PRIMARY KEY (id),
 CONSTRAINT users_user_name_key UNIQUE (user_name)
);

CREATE TABLE IF NOT EXISTS public.user_addresses (
 id serial4 NOT NULL,
 user_id serial4,
 address_type varchar(128) not null,
 street varchar(128) NOT NULL,
 city varchar(128) DEFAULT NULL,
 state varchar(128) DEFAULT NULL,
 zip varchar(128) NOT NULL,
 created_at timestamptz NULL,
 updated_at timestamptz NULL,
  is_deleted boolean default false,
 deleted_at timestamptz NULL,
 CONSTRAINT addresses_pkey PRIMARY KEY (id),
 CONSTRAINT user_addresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id)
);
