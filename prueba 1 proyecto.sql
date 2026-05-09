/* Creación de la base de datos cine_review */
CREATE DATABASE cine_review;

/* Selección de la base de datos cine_review para comenzar a trabajar */
USE cine_review;

/* Creación de las tablas */
/* Creación de la tabla country */
CREATE TABLE countries (
  id CHAR(36) DEFAULT (UUID()),
  name_country VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);
CREATE TABLE genres (
  id   CHAR(36) PRIMARY KEY DEFAULT (UUID()),
  name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE directors (
  id         CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  full_name  VARCHAR(255) NOT NULL,
  country_id CHAR(36),
  birth_date DATE,
  FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL
);
CREATE TABLE actors (
  id         CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  full_name  VARCHAR(255) NOT NULL,
  country_id CHAR(36),
  birth_date DATE,
  FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL
);
CREATE TABLE users (
  id            CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  username      VARCHAR(80)  NOT NULL UNIQUE,
  email         VARCHAR(255) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  role          ENUM('USER','ADMIN') NOT NULL DEFAULT 'USER',
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
CREATE TABLE awards (
  id           CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  name         VARCHAR(150) NOT NULL UNIQUE,
  country_id   CHAR(36),
  founded_year DATE,
  FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL
);
CREATE TABLE production_companies (
  id           CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  name         VARCHAR(200) NOT NULL UNIQUE,
  country_id   CHAR(36),
  founded_year DATE,
  FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL
);
CREATE TABLE streaming_platforms (
  id                CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  name              VARCHAR(100) NOT NULL UNIQUE,
  country_id        CHAR(36),
  subscription_type ENUM('SUBSCRIPTION','RENT','FREE','PURCHASE') DEFAULT 'SUBSCRIPTION',
  FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL
);

CREATE TABLE movies (
  id           CHAR(36)     PRIMARY KEY DEFAULT (UUID()),
  title        VARCHAR(255) NOT NULL,
  release_year YEAR,
  synopsis     TEXT,
  country_id   CHAR(36),     
  tmdb_id      INT UNIQUE,
  CONSTRAINT fk_movie_country  FOREIGN KEY (country_id)  REFERENCES countries(id) ON DELETE SET NULL
);

CREATE TABLE reviews (
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
  user_id CHAR(36) NOT NULL, movie_id CHAR(36) NOT NULL,
  rating TINYINT NOT NULL, body TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_rv_user  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
  CONSTRAINT fk_rv_movie FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
  CONSTRAINT chk_rating  CHECK (rating BETWEEN 1 AND 10),
  CONSTRAINT uq_user_movie UNIQUE (user_id, movie_id)
);

CREATE TABLE movie_actors (
  movie_id CHAR(36) NOT NULL, actor_id CHAR(36) NOT NULL,
  character_name VARCHAR(150), is_lead BOOLEAN DEFAULT FALSE,
  PRIMARY KEY (movie_id, actor_id),
  FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
  FOREIGN KEY (actor_id) REFERENCES actors(id) ON DELETE CASCADE
);
CREATE TABLE movie_genres (
  movie_id CHAR(36) NOT NULL, genre_id CHAR(36) NOT NULL,
  PRIMARY KEY (movie_id, genre_id),
  FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES genres(id) ON DELETE CASCADE
);
CREATE TABLE watchlist (
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
  user_id CHAR(36) NOT NULL, movie_id CHAR(36) NOT NULL,
  status ENUM('PENDING','WATCHING','WATCHED','DROPPED') DEFAULT 'PENDING',
  added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
  FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
  CONSTRAINT uq_watchlist UNIQUE (user_id, movie_id)
);
CREATE TABLE movie_awards (
  id CHAR(36) PRIMARY KEY DEFAULT (UUID()),
  movie_id CHAR(36) NOT NULL, award_id CHAR(36) NOT NULL,
  year SMALLINT NOT NULL, category VARCHAR(150) NOT NULL,
  won BOOLEAN NOT NULL DEFAULT FALSE,
  FOREIGN KEY (movie_id) REFERENCES movies(id)  ON DELETE CASCADE,
  FOREIGN KEY (award_id) REFERENCES awards(id)  ON DELETE CASCADE,
  CONSTRAINT uq_nomination UNIQUE (movie_id, award_id, year, category)
);
CREATE TABLE movie_companies (
  movie_id   CHAR(36) NOT NULL, company_id CHAR(36) NOT NULL,
  role ENUM('PRODUCER','DISTRIBUTOR','CO_PRODUCER','EXECUTIVE_PRODUCER') NOT NULL DEFAULT 'PRODUCER',
  PRIMARY KEY (movie_id, company_id),
  FOREIGN KEY (movie_id)   REFERENCES movies(id)               ON DELETE CASCADE,
  FOREIGN KEY (company_id) REFERENCES production_companies(id) ON DELETE CASCADE
);
CREATE TABLE movie_platforms (
  movie_id CHAR(36) NOT NULL, platform_id CHAR(36) NOT NULL,
  available_since DATE, available_until DATE,
  PRIMARY KEY (movie_id, platform_id),
  CONSTRAINT chk_dates CHECK (available_until IS NULL OR available_until > available_since),
  FOREIGN KEY (movie_id)    REFERENCES movies(id)              ON DELETE CASCADE,
  FOREIGN KEY (platform_id) REFERENCES streaming_platforms(id) ON DELETE CASCADE
);

CREATE TABLE movie_directors (
	movie_id CHAR(36) NOT NULL, director_id CHAR(36) NOT NULL,
	rol_director ENUM ('LEADER','SUBLEADER'),
	PRIMARY KEY (movie_id, director_id),
	FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE,
	FOREIGN KEY (director_id) REFERENCES directors(id) ON DELETE CASCADE
);