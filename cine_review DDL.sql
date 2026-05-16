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
	PRIMARY KEY (id),
	CONSTRAINT fk_country_id
		FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL
);

CREATE TABLE person (
    id         CHAR(36) DEFAULT (UUID()),
    name       VARCHAR(50)  NOT NULL,
    last_name  VARCHAR(50)  NOT NULL,
    birth_date DATE,
    country_id CHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_person_country 
        FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL
);

CREATE TABLE directing_style (
    id   CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,  
    PRIMARY KEY (id)
);

CREATE TABLE director (
	id 				   CHAR(36) ,
    directing_style_id CHAR(36),
    created_at         TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at  	   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_director_person 
        FOREIGN KEY (id) REFERENCES person(id) 
        ON DELETE CASCADE,
	CONSTRAINT fk_director_style
        FOREIGN KEY (directing_style_id) REFERENCES directing_style(id)
        ON DELETE SET NULL
);

CREATE TABLE acting_method (
    id   CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,  
    PRIMARY KEY (id)
);

CREATE TABLE actor (
	id			     CHAR(36),
    acting_method_id CHAR(36),
    created_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at       TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT fk_actor_person 
      FOREIGN KEY (id) REFERENCES person(id) 
      ON DELETE CASCADE,
	CONSTRAINT fk_actor_method
        FOREIGN KEY (acting_method_id) REFERENCES acting_method(id)
        ON DELETE SET NULL
);

CREATE TABLE user_role (
	id   CHAR(36) DEFAULT (UUID()),
	name VARCHAR(50) NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE app_user (
	id            CHAR(36) DEFAULT (UUID()),
	role_id       CHAR (36) NOT NULL,
	name          VARCHAR(50) NOT NULL,
	last_name     VARCHAR(50) NOT NULL,
	country_id    CHAR(36),
	birth_date    DATE,
	email         VARCHAR(255) NOT NULL UNIQUE,
	password_hash VARCHAR(255) NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT fk_user_country_id 
		FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL,
	CONSTRAINT fk_user_role_id
		FOREIGN KEY (role_id) REFERENCES user_role(id)
        ON DELETE RESTRICT
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
	id                   CHAR(36) DEFAULT (UUID()),
	name                 VARCHAR(100) NOT NULL UNIQUE,
	country_id           CHAR(36),
	subscription_type_id CHAR(36),
    PRIMARY KEY (id),
    CONSTRAINT fk_sp_country_id
		FOREIGN KEY (country_id) REFERENCES country(id) 
        ON DELETE SET NULL,
	CONSTRAINT fk_subscription_type_id
		FOREIGN KEY(subscription_type_id) REFERENCES subscription_type(id)
        ON DELETE SET NULL
);

CREATE TABLE classification (
	id          		  CHAR(36) DEFAULT (UUID()),
	classification_system VARCHAR(100) NOT NULL, 
	name        		  VARCHAR (50) NOT NULL,
	description 		  TEXT,
	min_age     		  INT,
	created_at  		  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at  		  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id)
);

CREATE TABLE movie (
	id           	  CHAR(36) DEFAULT (UUID()),
	country_id   	  CHAR(36),
    classification_id CHAR(36),
	title        	  VARCHAR(255) NOT NULL,
	release_year 	  YEAR,
	synopsis     	  TEXT,
	tmdb_id      	  INT UNIQUE,
    created_at  	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at  	  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	CONSTRAINT fk_movie_country
		FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL,
	CONSTRAINT fk_movie_classification
		FOREIGN KEY (classification_id) REFERENCES classification(id)
        ON DELETE SET NULL
);

CREATE TABLE review (
	id         CHAR(36) DEFAULT (UUID()),
	user_id    CHAR(36) NOT NULL, 
    movie_id   CHAR(36) NOT NULL,
	rating 	   TINYINT NOT NULL,
    body 	   TEXT,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
	CONSTRAINT fk_rv_user  
		FOREIGN KEY (user_id) REFERENCES app_user(id)  
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
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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
		FOREIGN KEY (user_id) REFERENCES app_user(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_watchlist_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id) 
        ON DELETE CASCADE,
	CONSTRAINT fk_status_id
		FOREIGN KEY(status_id) REFERENCES status_watchlist(id)
        ON DELETE RESTRICT,
	CONSTRAINT uq_watchlist 
		UNIQUE (user_id, movie_id)
);
CREATE TABLE movie_award (
	id 		    CHAR(36) DEFAULT (UUID()),
	movie_id    CHAR(36) NOT NULL, 
    award_id    CHAR(36) NOT NULL,
    category_id CHAR(36) NOT NULL,
	year        YEAR NOT NULL, 
	won         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_mw_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_award_id
		FOREIGN KEY (award_id) REFERENCES award(id)  
        ON DELETE CASCADE,
	CONSTRAINT fk_maw_category_id
		FOREIGN KEY (category_id) REFERENCES award_category(id)
		ON DELETE RESTRICT,
	CONSTRAINT uq_movie_nomination
		UNIQUE (movie_id, award_id, year, category_id)
);
CREATE TABLE person_award (
    id          CHAR(36) DEFAULT (UUID()),
    person_id   CHAR(36) NOT NULL,
    award_id    CHAR(36) NOT NULL,
    category_id CHAR(36) NOT NULL,
    year        YEAR NOT NULL,
    won         BOOLEAN NOT NULL DEFAULT FALSE,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_person_id  
        FOREIGN KEY (person_id) REFERENCES person(id)          
        ON DELETE CASCADE,
    CONSTRAINT fk_pa_award_id   
        FOREIGN KEY (award_id) REFERENCES award(id)           
        ON DELETE CASCADE,
	CONSTRAINT fk_paw_category_id
		FOREIGN KEY (category_id) REFERENCES award_category(id)
		ON DELETE RESTRICT,
   CONSTRAINT uq_person_nomination
		UNIQUE (person_id, award_id, year, category_id)
);

CREATE TABLE company_role (
	id   CHAR(36) DEFAULT(UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

CREATE TABLE movie_company (
	movie_id   CHAR(36) NOT NULL, 
	company_id CHAR(36) NOT NULL,
	role_id    CHAR(36) NOT NULL,
	PRIMARY KEY (movie_id, company_id),
    CONSTRAINT fk_cr_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)               
		ON DELETE CASCADE,
	CONSTRAINT fk_company_id
		FOREIGN KEY (company_id) REFERENCES production_company(id) 
		ON DELETE CASCADE,
	CONSTRAINT fk_role_id
		FOREIGN KEY (role_id) REFERENCES company_role(id)
        ON DELETE RESTRICT 
);
CREATE TABLE movie_platform (
	movie_id        CHAR(36) NOT NULL, 
	platform_id     CHAR(36) NOT NULL,
	available_since DATE, 
    available_until DATE,
	PRIMARY KEY (movie_id, platform_id),
	CONSTRAINT chk_dates 
		CHECK (available_until IS NULL OR available_until > available_since),
	CONSTRAINT fk_mp_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)              
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
	movie_id    CHAR(36) NOT NULL,
    director_id CHAR(36) NOT NULL,
	role_id     CHAR(36) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (movie_id, director_id),
	CONSTRAINT fk_dr_movie_id
		FOREIGN KEY (movie_id) REFERENCES movie(id)
		ON DELETE CASCADE,
	CONSTRAINT fk_director_id
		FOREIGN KEY (director_id) REFERENCES director(id) 
		ON DELETE CASCADE,
	CONSTRAINT fk_md_role_id
		FOREIGN KEY (role_id) REFERENCES director_role (id)
        ON DELETE RESTRICT
);

DELIMITER $$
CREATE PROCEDURE sp_insert_person(
    IN p_name             VARCHAR(50),
    IN p_last_name        VARCHAR(50),
    IN p_birth_date       DATE,
    IN p_country_id       CHAR(36),
    IN p_type             VARCHAR(10),
    IN p_style_method_id  CHAR(36)
)
BEGIN
    DECLARE v_person_id CHAR(36) DEFAULT (UUID());
    INSERT INTO person (id, name, last_name, birth_date, country_id)
    VALUES (v_person_id, p_name, p_last_name, p_birth_date, p_country_id);
    IF p_type = 'DIRECTOR' THEN
        INSERT INTO director (id, directing_style_id)
        VALUES (v_person_id, p_style_method_id);
    ELSEIF p_type = 'ACTOR' THEN
        INSERT INTO actor (id, acting_method_id)
        VALUES (v_person_id, p_style_method_id);
    ELSE
        SELECT 'ERROR: tipo debe ser DIRECTOR o ACTOR' AS message;
    END IF;
    SELECT * FROM person WHERE id = v_person_id;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_insert_movie(
    IN p_title             VARCHAR(255),
    IN p_release_year      YEAR,
    IN p_country_id        CHAR(36),
    IN p_classification_id CHAR(36),
    IN p_synopsis          TEXT,
    IN p_tmdb_id           INT,
    IN p_director_id       CHAR(36),
    IN p_role_id           CHAR(36),
    IN p_genre_1_id        CHAR(36),
    IN p_genre_2_id        CHAR(36),
    IN p_genre_3_id        CHAR(36)
)
BEGIN
    DECLARE v_movie_id CHAR(36) DEFAULT (UUID());
    IF NOT EXISTS (SELECT 1 FROM director WHERE id = p_director_id) THEN
        SELECT 'ERROR: director no existe' AS message;
    ELSE
        INSERT INTO movie (id, country_id, classification_id, title, release_year, synopsis, tmdb_id)
        VALUES (v_movie_id, p_country_id, p_classification_id, p_title, p_release_year, p_synopsis, p_tmdb_id);
        INSERT INTO movie_director (movie_id, director_id, role_id)
        VALUES (v_movie_id, p_director_id, p_role_id);
        INSERT INTO movie_genre (movie_id, genre_id)
        VALUES (v_movie_id, p_genre_1_id);
        IF p_genre_2_id IS NOT NULL THEN
            INSERT INTO movie_genre (movie_id, genre_id)
            VALUES (v_movie_id, p_genre_2_id);
        END IF;
        IF p_genre_3_id IS NULL THEN
            INSERT INTO movie_genre (movie_id, genre_id)
            VALUES (v_movie_id, p_genre_3_id);
        END IF;
        SELECT * FROM movie WHERE id = v_movie_id;
    END IF;
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_register_user(
    IN p_name          VARCHAR(50),
    IN p_last_name     VARCHAR(50),
    IN p_email         VARCHAR(255),
    IN p_password_hash VARCHAR(255),
    IN p_country_id    CHAR(36),
    IN p_birth_date    DATE,
    IN p_role_id       CHAR(36)
)
BEGIN
    IF EXISTS (SELECT 1 FROM app_user WHERE email = p_email) THEN
        SELECT 'ERROR: email ya registrado' AS message;
    ELSE
        INSERT INTO app_user (id, role_id, name, last_name, email, password_hash, country_id, birth_date)
        VALUES (UUID(), p_role_id, p_name, p_last_name, p_email, p_password_hash, p_country_id, p_birth_date);
        SELECT * FROM app_user WHERE email = p_email;
    END IF;
END$$
DELIMITER ;