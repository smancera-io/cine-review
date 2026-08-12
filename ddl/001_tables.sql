/*
*   Tables: Full relational schema for cine-review. 28 tables: lookup/catalog tables (single name column, referenced by everything else), the person/director/actor hierarchy, 
*   core entities (movie, review, award, watchlist, app_user), and many to many junction tables.
*
*   All primary keys are surrogate UUIDs (CHAR(36) DEFAULT (UUID())), even where an external natural key exists such as tmdb_id.
*   ON DELETE is set deliberately per relationship, not by default: CASCADE where the child row has no meaning without that specific parent (e.g. review and app_user), 
*   RESTRICT where the parent is a shared catalog value referenced by many unrelated rows (role, category, status), SET NULL where the reference is optional/descriptive on 
*   an otherwise still valid row (country, classification, style).
*/
CREATE DATABASE cine_review;
USE cine_review;

/*
*   Table: country.
*   Catalog of countries (Colombia, United States, South Korea, etc.).
*/
CREATE TABLE country (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: Genre.
*   Catalog of movie genres (Science Fiction, Drama, Thriller, etc.).
*/
CREATE TABLE genre (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: award_category.
*   Catalog of award categories (Best Director, Best Picture, etc.). 
*/
CREATE TABLE award_category (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(150) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: award.
*   Catalog of awarding bodies/festivals (Academy Awards, BAFTA, etc.). 
*/
CREATE TABLE award (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(150) NOT NULL UNIQUE,
    country_id CHAR(36),
    founded_year YEAR,
    PRIMARY KEY (id),
    CONSTRAINT fk_country_id
        FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL
);

/*
*   Table: person.
*   Industry side identity, real people who exist independently of the app (directors, actors). Superclass for the director/actor table per type hierarchy below, a plain 
*   person row with no matching director/actor row is valid.
*   Deliberately separate from app_user: Person is catalog identity (what the system catalogs, populated by an admin, not the subject themselves), app_user is operational 
*   identity (who logs in and acts, self registered, needs password_hash/role_id). No real overlap in this domain: A director doesn't need to log in to review movies as 
*   themselves. If a feature ever required that (e.g. a verified director account), that would be the trigger to reconsider unifying them, not needed for the current scope.
*/
CREATE TABLE person (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    country_id CHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_person_country
        FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL
);

/* 
*   Table: directing_style.
*   Catalog of directing styles (Epic Cinema, Neorealism, Psychological Thriller, etc.).
*/
CREATE TABLE directing_style (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/*
*   Table: director.
*   Subtype of person. The id is both PK and FK to person.id because it is the same row, not a copy. Table per type instead of nullable columns directly on person 
*   (would leave directing_style_id/acting_method_id NULL on most rows, with nothing enforcing which role a person actually has) or a type discriminator column 
*   (would push CASE WHEN logic into every query needing the role-specific attribute). This avoids both: no wasted nullable columns, no conditional logic.
*/
CREATE TABLE director (
    id CHAR(36),
    directing_style_id CHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_director_person
        FOREIGN KEY (id) REFERENCES person(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_director_style
        FOREIGN KEY (directing_style_id) REFERENCES directing_style(id)
        ON DELETE SET NULL
);

/* 
*   Table: acting_method.
*   Catalog of acting methods/techniques (Stanislavski Method, Meisner Technique, Brechtian Epic Theatre.).
*/
CREATE TABLE acting_method (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/*
*   Table: actor.
*   Same table per type pattern as director, see that table's comment for why. The id is PK and FK to person.id.
*/
CREATE TABLE actor (
    id CHAR(36),
    acting_method_id CHAR(36),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_actor_person
        FOREIGN KEY (id) REFERENCES person(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_actor_method
        FOREIGN KEY (acting_method_id) REFERENCES acting_method(id)
        ON DELETE SET NULL
);

/* 
*   Table: user_role.
*   Catalog of app user roles (ADMIN, ROLE.).
*/
CREATE TABLE user_role (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/*
*   Table: app_user.
*   The app's login/audience identity, you must see person's comment above for why this is a separate table instead of another person subtype.
*/
CREATE TABLE app_user (
    id CHAR(36) DEFAULT (UUID()),
    role_id CHAR(36) NOT NULL,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    country_id CHAR(36),
    birth_date DATE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
	CONSTRAINT fk_user_country_id
		FOREIGN KEY (country_id) REFERENCES country(id)
		ON DELETE SET NULL,
	CONSTRAINT fk_user_role_id
		FOREIGN KEY (role_id) REFERENCES user_role(id)
		ON DELETE RESTRICT
);

/* 
*   Table: production_company.
*   Companies involved in producing/distributing movies (Warner Bros. Pictures, A24, CJ ENM, etc.).
*/
CREATE TABLE production_company (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(200) NOT NULL UNIQUE,
    country_id CHAR(36),
    founded_year YEAR,
    PRIMARY KEY (id),
    CONSTRAINT fk_pc_country_id
        FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL
);

/* 
*   Table: subscription_type.
*   Catalog of streaming subscription types (SUBSCRIPTION, RENT, FREE, PURCHASE.). 
*/
CREATE TABLE subscription_type (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: streaming_platform.
*   Streaming platforms movies are available on (Netflix, HBO Max, Amazon Prime Video, Mubi.).
*/
CREATE TABLE streaming_platform (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(100) NOT NULL UNIQUE,
    country_id CHAR(36),
    subscription_type_id CHAR(36),
    PRIMARY KEY (id),
    CONSTRAINT fk_sp_country_id
        FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_subscription_type_id
        FOREIGN KEY (subscription_type_id) REFERENCES subscription_type(id)
        ON DELETE SET NULL
);

/*
*   Table: classification.
*   Content ratings (e.g. MPAA's G/PG/PG-13/R/NC-17). Not a pure lookup table, this carries classification_system, a description, and min_age alongside the code.
*   COLUMN min_age is stored but not enforced anywhere: "a user can't review a movie below their classification's minimum age" would require comparing this table's 
*   min_age against app_user.birth_dat, they are two different tables. A CHECK constraint can only validate columns within the same row, never reference another table, 
*   so this rule can't be expressed there. It would need a TRIGGER or application layer validation.
*/
CREATE TABLE classification (
    id CHAR(36) DEFAULT (UUID()),
    classification_system VARCHAR(100) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description TEXT,
    min_age INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

/*
*   Table: movie.
*   The central entity which is referenced directly or indirectly by most other tables in the schema.
*   COLUMN tmdb_id is UNIQUE, not the primary key, even though it's an obvious natural key candidate (a real, unique id from The Movie Database). Kept as a plain attribute 
*   instead, so the schema's internal identity doesn't depend on an external system this app doesn't control. It's also nullable in practice: smaller or regional releases 
*   aren't always catalogued in TMDB (see 'Embrace of the Serpent' in 001_seed_data.sql).
*/
CREATE TABLE movie (
    id CHAR(36) DEFAULT (UUID()),
    country_id CHAR(36),
    classification_id CHAR(36),
    title VARCHAR(255) NOT NULL,
    release_year YEAR,
    synopsis TEXT,
    tmdb_id INT UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_movie_country
        FOREIGN KEY (country_id) REFERENCES country(id)
        ON DELETE SET NULL,
    CONSTRAINT fk_movie_classification
        FOREIGN KEY (classification_id) REFERENCES classification(id)
        ON DELETE SET NULL
);

/*
*   Table: review.
*   Records an app_user's rating (1-10) and opinion of a movie. A user reviews each movie at most once (uq_user_movie).
*   COLUMN rating is TINYINT rather than INT: the valid range is 1-10 (chk_rating), a single byte is more than enough, while INT would reserve 4 bytes for a value that never 
*   exceeds 10.
*   ON DELETE CASCADE on user_id and movie_id: a review has no meaning without both its user and its movie, it isn't valid orphaned data in this domain.
*/
CREATE TABLE review (
    id CHAR(36) DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    movie_id CHAR(36) NOT NULL,
    rating TINYINT NOT NULL,
    body TEXT,
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

/*
*   Table: movie_actor.
*   Many to many junction between movie and actor, with the character played and whether the role was a lead.
*   COLUMN is_lead is BOOLEAN, in MySQL that's an alias for TINYINT(1), not a distinct native type. Same underlying storage as the TINYINT used for review.rating, just a more 
*   readable name here.
*/
CREATE TABLE movie_actor (
    movie_id CHAR(36) NOT NULL,
    actor_id CHAR(36) NOT NULL,
    character_name VARCHAR(150),
    is_lead BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (movie_id, actor_id),
    CONSTRAINT fk_ma_movie_id
        FOREIGN KEY (movie_id) REFERENCES movie(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_actor_id
        FOREIGN KEY (actor_id) REFERENCES actor(id)
        ON DELETE CASCADE
);

/* 
*   Table: movie_genre.
*   Many to many junction between movie and genre. 
*/
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

/* 
*   Table: status_watchlist.
*   Catalog of watchlist entry statuses (PENDING, WATCHING, WATCHED, DROPPED)
*/
CREATE TABLE status_watchlist (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(25) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: watchlist.
*   Tracks which movies a user has added to their watchlist, and its current status. 
*/
CREATE TABLE watchlist (
    id CHAR(36) DEFAULT (UUID()),
    user_id CHAR(36) NOT NULL,
    movie_id CHAR(36) NOT NULL,
    status_id CHAR(36) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_user_id
        FOREIGN KEY (user_id) REFERENCES app_user(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_watchlist_movie_id
        FOREIGN KEY (movie_id) REFERENCES movie(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_status_id
        FOREIGN KEY (status_id) REFERENCES status_watchlist(id)
        ON DELETE RESTRICT,
    CONSTRAINT uq_watchlist
        UNIQUE (user_id, movie_id)
);

/*
*   Table: movie_award.
*   Records movie award nominations/wins. Not a simple junction: Id is its own surrogate PK rather than a composite (movie_id, award_id), because the same movie can be 
*   nominated for the same award multiple times across different categories or years (e.g. Parasite: 4 rows, 2 different awards, 3 different categories for the Oscar alone). 
*   A composite (movie_id, award_id) PK would make that pair unique and reject all but the first of those rows. Real uniqueness is enforced instead by uq_movie_nomination
*   (movie_id, award_id, year, category_id).
*/
CREATE TABLE movie_award (
    id CHAR(36) DEFAULT (UUID()),
    movie_id CHAR(36) NOT NULL,
    award_id CHAR(36) NOT NULL,
    category_id CHAR(36) NOT NULL,
    year YEAR NOT NULL,
    won BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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

/*
*   Table: person_award.
*   Same pattern as movie_award, you must see that table's comment for why it has its own surrogate PK instead of a composite one. Same structure, applied to individual 
*   people instead of movies.
*/
CREATE TABLE person_award (
    id CHAR(36) DEFAULT (UUID()),
    person_id CHAR(36) NOT NULL,
    award_id CHAR(36) NOT NULL,
    category_id CHAR(36) NOT NULL,
    year YEAR NOT NULL,
    won BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
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

/* 
*   Table: company_role.
*   Catalog of roles a production company can have on a movie (producer, distributor, etc.). 
*/
CREATE TABLE company_role (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: movie_company.
*   Many to many junction between movie and production_company, with the company's role on that movie. 
*/
CREATE TABLE movie_company (
    movie_id CHAR(36) NOT NULL,
    company_id CHAR(36) NOT NULL,
    role_id CHAR(36) NOT NULL,
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

/*
*   Table: movie_platform.
*   Many to many junction between movie and streaming_platform, with the availability window on that platform.
*   CONSTRAINT chk_dates: available_until must be NULL or later than available_since, the NULL meaning "still available, no end date set".
*/
CREATE TABLE movie_platform (
    movie_id CHAR(36) NOT NULL,
    platform_id CHAR(36) NOT NULL,
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

/* 
*   Table: director_role.
*   Catalog of roles a director can have on a movie (director, co-director, etc.). 
*/
CREATE TABLE director_role (
    id CHAR(36) DEFAULT (UUID()),
    name VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

/* 
*   Table: movie_director.
*   Many to many junction between movie and director, with the director's role on that movie. 
*/
CREATE TABLE movie_director (
    movie_id CHAR(36) NOT NULL,
    director_id CHAR(36) NOT NULL,
    role_id CHAR(36) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (movie_id, director_id),
    CONSTRAINT fk_dr_movie_id
        FOREIGN KEY (movie_id) REFERENCES movie(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_director_id
        FOREIGN KEY (director_id) REFERENCES director(id)
        ON DELETE CASCADE,
    CONSTRAINT fk_md_role_id
        FOREIGN KEY (role_id) REFERENCES director_role(id)
        ON DELETE RESTRICT
);