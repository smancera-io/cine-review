CREATE DATABASE cine_review;

USE cine_review;

CREATE TABLE country (
	id 	 CHAR(36) DEFAULT (UUID()),
    name VARCHAR (100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE genre (
	id   CHAR(36) DEFAULT (UUID()),
	name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE award_category (
    id   CHAR(36) DEFAULT (UUID()),
    name VARCHAR(150) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE award (
	id           CHAR(36) DEFAULT (UUID()),
	name         VARCHAR(150) NOT NULL UNIQUE,
	country_id   CHAR(36),
	founded_year YEAR,
    category_id CHAR(36) NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_country_id
		FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL,
	CONSTRAINT fk_category_id
		FOREIGN KEY (category_id) REFERENCES award_category(id)
);

CREATE TABLE person (
    id         CHAR(36) DEFAULT (UUID()),
    name       VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    birth_date DATE,
    country_id CHAR(36),
    PRIMARY KEY (id),
    CONSTRAINT fk_person_country 
        FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL
);

CREATE TABLE director (
	id CHAR(36) ,
    directing_style VARCHAR(100),
    PRIMARY KEY (id),
    CONSTRAINT fk_director_person 
        FOREIGN KEY (id) REFERENCES person(id) 
        ON DELETE CASCADE
);

CREATE TABLE actor (
	id			  CHAR(36),
    acting_method VARCHAR(100),
	PRIMARY KEY (id),
	CONSTRAINT fk_actor_person 
      FOREIGN KEY (id) REFERENCES person(id) 
      ON DELETE CASCADE
);

CREATE TABLE user_role (
	id CHAR(36) DEFAULT (UUID()),
  name VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

CREATE TABLE app_user (
	id            CHAR(36) DEFAULT (UUID()),
  role_id       CHAR (36) NOT NULL,
	name          VARCHAR(50) NOT NULL,
  lastName      VARCHAR(50) NOT NULL,
	country_id    CHAR(36),
	birth_date    DATE,
	email         VARCHAR(255) NOT NULL UNIQUE,
	password_hash VARCHAR(255) NOT NULL,
	created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (id),
  CONSTRAINT fk_user_country_id 
		FOREIGN KEY (country_id) REFERENCES country(id),
	CONSTRAINT fk_user_role_id
		FOREIGN KEY (role_id) REFERENCES user_role(id)
);

CREATE TABLE production_company (
	id           CHAR(36) DEFAULT (UUID()),
	name         VARCHAR(200) NOT NULL UNIQUE,
	country_id   CHAR(36),
	founded_year YEAR,
    PRIMARY KEY (id),
    CONSTRAINT fk_pc_country_id
		FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL
);

CREATE TABLE subscription_type (
	id   CHAR(36) DEFAULT(UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

CREATE TABLE streaming_platform (
	id                CHAR(36) DEFAULT (UUID()),
	name              VARCHAR(100) NOT NULL UNIQUE,
	country_id        CHAR(36),
	subscription_type_id CHAR(36),
    PRIMARY KEY (id),
    CONSTRAINT fk_sp_country_id
		FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL,
	CONSTRAINT fk_subscription_type_id
		FOREIGN KEY(subscription_type_id) REFERENCES subscription_type(id)
);

create TABLE classification (
  id          CHAR(36) DEFAULT (UUID()),
  clasification_system      VARCHAR(100) NOT NULL, -- PEGI, MPA, etc.
  name        VARCHAR (50) NOT NULL, -- G, PG, PG13, etc.
  description TEXT,
  min_age     INT,

  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (id)
);

CREATE TABLE movie (
	id           CHAR(36) DEFAULT (UUID()),
	country_id   CHAR(36),
  clasification_id CHAR(36),

	title        VARCHAR(255) NOT NULL,
	release_year YEAR,
	synopsis     TEXT,
	tmdb_id      INT UNIQUE,

  PRIMARY KEY (id),
	CONSTRAINT fk_movie_country
		FOREIGN KEY (country_id)  REFERENCES country(id)
        ON DELETE SET NULL,
	CONSTRAINT fk_movie_clasification
		FOREIGN KEY (clasification_id) REFERENCES clasification(id)
        ON DELETE SET NULL
);

CREATE TABLE review (
	id         CHAR(36) DEFAULT (UUID()),
	user_id    CHAR(36) NOT NULL, 
    movie_id   CHAR(36) NOT NULL,
	rating 	   TINYINT NOT NULL,
    body 	   TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
	CONSTRAINT fk_rv_user  
		FOREIGN KEY (user_id)  REFERENCES user(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_rv_movie 
		FOREIGN KEY (movie_id) REFERENCES movie(id) 
		ON DELETE CASCADE,
	CONSTRAINT chk_rating  
		CHECK (rating BETWEEN 1 AND 10),
	CONSTRAINT uq_user_movie 
		UNIQUE (user_id, movie_id)
);

CREATE TABLE movie_actor (
	movie_id       CHAR(36) NOT NULL, 
    actor_id       CHAR(36) NOT NULL,
	character_name VARCHAR(150), 
    is_lead        BOOLEAN DEFAULT FALSE,
	PRIMARY KEY (movie_id, actor_id),
    CONSTRAINT fk_ma_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id) 
		ON DELETE CASCADE,
	CONSTRAINT fk_actor_id
		FOREIGN KEY (actor_id) REFERENCES actor(id) 
		ON DELETE CASCADE
);
CREATE TABLE movie_genre (
	movie_id CHAR(36) NOT NULL, 
	genre_id CHAR(36) NOT NULL,
	PRIMARY KEY (movie_id, genre_id),
    CONSTRAINT fk_mg_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id) 
        ON DELETE CASCADE,
	CONSTRAINT fk_genre_id
		FOREIGN KEY (genre_id) REFERENCES genre(id) 
        ON DELETE CASCADE
);

CREATE TABLE status_watchlist (
	id   CHAR(36) DEFAULT (UUID()),
    name VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE watchlist (
	id        CHAR(36) DEFAULT (UUID()),
	user_id   CHAR(36) NOT NULL, 
    movie_id  CHAR(36) NOT NULL,
	status_id CHAR(36) NOT NULL,
	added_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY  (id),
    CONSTRAINT fk_user_id
		FOREIGN KEY (user_id)  REFERENCES user(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_watchlist_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id) 
        ON DELETE CASCADE,
	CONSTRAINT fk_status_id
		FOREIGN KEY(status_id) REFERENCES status_watchlist(id),
	CONSTRAINT uq_watchlist 
		UNIQUE (user_id, movie_id)
);
CREATE TABLE movie_award (
	id 		 CHAR(36) DEFAULT (UUID()),
	movie_id CHAR(36) NOT NULL, 
    award_id CHAR(36) NOT NULL,
	year     YEAR NOT NULL, 
	won      BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id),
    CONSTRAINT fk_mw_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_award_id
		FOREIGN KEY (award_id) REFERENCES award(id)  
        ON DELETE CASCADE,
	CONSTRAINT uq_nomination 
		UNIQUE (movie_id, award_id, year)
);
CREATE TABLE person_award (
    id          CHAR(36) DEFAULT (UUID()),
    person_id   CHAR(36) NOT NULL,
    award_id    CHAR(36) NOT NULL,
    year        YEAR NOT NULL,
    won         BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id),
    CONSTRAINT fk_person_id  
        FOREIGN KEY (person_id)   REFERENCES person(id)          ON DELETE CASCADE,
    CONSTRAINT fk_pa_award_id   
        FOREIGN KEY (award_id)    REFERENCES award(id)           ON DELETE CASCADE,
    CONSTRAINT uq_person_nomination 
        UNIQUE (person_id, award_id, year)
);

CREATE TABLE company_role (
	id CHAR(36) DEFAULT(UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE movie_company (
	movie_id   CHAR(36) NOT NULL, 
	company_id CHAR(36) NOT NULL,
	role_id    CHAR(36) NOT NULL,
	PRIMARY KEY (movie_id, company_id),
    CONSTRAINT fk_cr_movie_id
		FOREIGN KEY (movie_id)   REFERENCES movie(id)               
		ON DELETE CASCADE,
	CONSTRAINT fk_company_id
		FOREIGN KEY (company_id) REFERENCES production_company(id) 
		ON DELETE CASCADE,
	CONSTRAINT fk_role_id
		FOREIGN KEY (role_id) REFERENCES company_role(id)
);
CREATE TABLE movie_platforms (
	movie_id        CHAR(36) NOT NULL, 
	platform_id     CHAR(36) NOT NULL,
	available_since DATE, 
    available_until DATE,
	PRIMARY KEY (movie_id, platform_id),
	CONSTRAINT chk_dates 
		CHECK (available_until IS NULL OR available_until > available_since),
	CONSTRAINT fk_mp_movie_id
		FOREIGN KEY (movie_id)    REFERENCES movie(id)              
        ON DELETE CASCADE,
	CONSTRAINT fk_platform_id
		FOREIGN KEY (platform_id) REFERENCES streaming_platform(id) 
		ON DELETE CASCADE
);

CREATE TABLE director_role (
	id   CHAR(36) DEFAULT(UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE movie_director (
	movie_id     CHAR(36) NOT NULL,
  director_id  CHAR(36) NOT NULL,
	role_id       CHAR(36) NOT NULL,

	PRIMARY KEY (movie_id, director_id),
  CONSTRAINT fk_dr_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)
		ON DELETE CASCADE,
	CONSTRAINT fk_director_id
		FOREIGN KEY (director_id) REFERENCES director(id) 
		ON DELETE CASCADE,
	CONSTRAINT fk_md_role_id
		FOREIGN KEY (role_id) REFERENCES director_role (id)
);


