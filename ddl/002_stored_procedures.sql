/*
*   Stored procedures: The app's data-access layer for writes (insert/update/delete) plus two read helpers (movie detail, user watchlist). Called directly, not via ORM.
*
*   Convention: None of these return values via out parameters, each returns its result as a select result set instead. See 003_procedures_driven_data.sql's header for 
*   why that matters when calling these from a plain SQL script.
*   Convention: Failures come back as select 'ERROR: ...' as message, not a thrown SQL exception. A call can "succeed" with no error while still failing its business rule.
*   Known limitation: sp_insert_person and sp_insert_movie each do multiple inserts with no explicit transaction, a failure partway through leaves earlier inserts committed, 
*   not rolled back.
*/

/*
*   Procedure: insert_person.
*   Inserts a person with their base information (name, last name, birth date, country), then routes them into director or actor based on p_type.
*
*   COLUMN p_type: Drives explicit branching logic (if/elseif) that decides which child table to insert into. MySQL has no native mechanism for this. The procedure 
*   implements table-per-type dispatch by hand.
*   IF structure p_type: Matches neither director nor actor, the person row has already been inserted before that check run. No explicit transaction. An invalid p_type 
*   leaves that person row committed with no corresponding director/actor row: an orphaned person, not caught or rolled back. Same gap as sp_insert_movie below.
*/
DELIMITER $$
CREATE PROCEDURE sp_insert_person(
    IN p_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_birth_date DATE,
    IN p_country_id CHAR(36),
    IN p_type VARCHAR(10),
    IN p_style_method_id CHAR(36)
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
			SELECT 'ERROR: type must be DIRECTOR or ACTOR' AS message;
		END IF;
		SELECT * FROM person WHERE id = v_person_id;
	END$$
DELIMITER ;

/*
*   Procedure: insert_movie.
*   Inserts a movie plus its director link and 1 to 3 genre links in a single call. Genres 2 and 3 are optional (null-checked before inserting).
*
*   IF structure: Validates the director exists before inserting anything. Fails fast with an error message instead of hitting the movie_director fk constraint after 
*   the movie row is already created.
*   Limitation: the movie/movie_director/movie_genre inserts are not wrapped in an explicit transaction. If a later insert in the same call fails (e.g. a bad genre_3_id), 
*   the movie and movie_director rows already inserted stay committed. No automatic rollback.
*   Returns the new movie row via select, see this file's header for why that matters to anything calling this from a plain script.
*/
DELIMITER $$
CREATE PROCEDURE sp_insert_movie(
    IN p_title VARCHAR(255),
    IN p_release_year YEAR,
    IN p_country_id CHAR(36),
    IN p_classification_id CHAR(36),
    IN p_synopsis TEXT,
    IN p_tmdb_id INT,
    IN p_director_id CHAR(36),
    IN p_role_id CHAR(36),
    IN p_genre_1_id CHAR(36),
    IN p_genre_2_id CHAR(36),
    IN p_genre_3_id CHAR(36)
	)
	BEGIN
		DECLARE v_movie_id CHAR(36) DEFAULT (UUID());
		IF NOT EXISTS (SELECT 1 FROM director WHERE id = p_director_id) THEN
			SELECT 'ERROR: director does not exist' AS message;
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
			IF p_genre_3_id IS NOT NULL THEN
				INSERT INTO movie_genre (movie_id, genre_id)
				VALUES (v_movie_id, p_genre_3_id);
			END IF;
			SELECT * FROM movie WHERE id = v_movie_id;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: register_user.
*   Inserts a new app_user with their login credentials (password hash, role) and personal information (name, last name, email, country, birth date).
*
*   IF structure: Checks for a duplicate email with if exists before inserting, rather than letting the email unique constraint fail and catching that error. Trades one 
*   extra query for a controlled, readable error message instead of MySQL's raw constraint-violation error.
*/
DELIMITER $$
CREATE PROCEDURE sp_register_user(
    IN p_name VARCHAR(50),
    IN p_last_name VARCHAR(50),
    IN p_email VARCHAR(255),
    IN p_password_hash VARCHAR(255),
    IN p_country_id CHAR(36),
    IN p_birth_date DATE,
    IN p_role_id CHAR(36)
	)
	BEGIN
		IF EXISTS (SELECT 1 FROM app_user WHERE email = p_email) THEN
			SELECT 'ERROR: email already registered' AS message;
		ELSE
			INSERT INTO app_user (id, role_id, name, last_name, email, password_hash, country_id, birth_date)
			VALUES (UUID(), p_role_id, p_name, p_last_name, p_email, p_password_hash, p_country_id, p_birth_date);
			SELECT * FROM app_user WHERE email = p_email;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: update_review.
*   Lets a user edit the rating and body of a review they've already submitted.
*
*   IF structure: The where clause checks id and user_id together. This is access control, not just an existence check. A review that exists but belongs to someone else 
*   returns the same "not found" error as one that doesn't exist at all, so a caller can't tell the difference between "wrong id" and "not yours."
*/
DELIMITER $$
CREATE PROCEDURE sp_update_review(
    IN p_review_id CHAR(36),
    IN p_user_id CHAR(36),
    IN p_rating TINYINT,
    IN p_body TEXT
	)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM review WHERE id = p_review_id AND user_id = p_user_id) THEN
			SELECT 'ERROR: review not found or not authorized' AS message;
		ELSE
			UPDATE review
				SET rating = p_rating,
					body = p_body
			WHERE id = p_review_id;
			SELECT * FROM review WHERE id = p_review_id;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: update_watchlist_status.
*   Lets a user update the status of a movie in their own watchlist.
*
*   IF structure: Same authorization pattern as sp_update_review the where clause checks id and user_id together, so a user can only modify their own watchlist entries.
*/
DELIMITER $$
CREATE PROCEDURE sp_update_watchlist_status(
    IN p_watchlist_id CHAR(36),
    IN p_user_id CHAR(36),
    IN p_status_id CHAR(36)
	)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM watchlist WHERE id = p_watchlist_id AND user_id = p_user_id) THEN
			SELECT 'ERROR: entry not found or not authorized' AS message;
		ELSE
			UPDATE watchlist
				SET status_id = p_status_id
			WHERE id = p_watchlist_id;
			SELECT * FROM watchlist WHERE id = p_watchlist_id;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: get_movie_detail.
*   Read-only. Returns 3 independent result sets in a single call: Movie details (with average rating and review count), its list of genres, and its cast. Not obvious 
*   from the signature alone, a caller needs to read all 3 result sets, not just the first.
*
*   Use LEFT JOIN instead of INNER JOIN in the first query: A movie with no reviews yet, or missing an optional field like country, must still return its row. With 
*   INNER JOIN, AVG/COUNT over zero matching reviews would collapse the entire row out of the result, not just those columns.
*/
DELIMITER $$
CREATE PROCEDURE sp_get_movie_detail(
    IN p_movie_id CHAR(36)
	)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM movie WHERE id = p_movie_id) THEN
			SELECT 'ERROR: movie not found' AS message;
		ELSE
			SELECT
				m.title,
				m.release_year,
				m.synopsis,
				c.name AS country,
				cl.name AS classification,
				p.name AS director_name,
				p.last_name AS director_last_name,
				ROUND(AVG(r.rating), 2) AS avg_rating,
				COUNT(DISTINCT r.id) AS total_reviews
			FROM movie m
			LEFT JOIN country c ON c.id = m.country_id
			LEFT JOIN classification cl ON cl.id = m.classification_id
			LEFT JOIN movie_director md ON md.movie_id = m.id
			LEFT JOIN director d ON d.id = md.director_id
			LEFT JOIN person p ON p.id = d.id
			LEFT JOIN review r ON r.movie_id = m.id
			WHERE m.id = p_movie_id
			GROUP BY m.title, m.release_year, m.synopsis,
                c.name, cl.name, p.name, p.last_name;
			SELECT g.name AS genre
			FROM movie_genre mg
			JOIN genre g ON g.id = mg.genre_id
			WHERE mg.movie_id = p_movie_id;
			SELECT
				p.name,
				p.last_name,
				ma.character_name,
				ma.is_lead
			FROM movie_actor ma
			JOIN actor a ON a.id = ma.actor_id
			JOIN person p ON p.id = a.id
			WHERE ma.movie_id = p_movie_id
			ORDER BY ma.is_lead DESC;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: get_user_watchlist
*   Read-only. Returns a user's watchlist with movie title, status, and the date each entry was added.
*
*   Use INNER JOIN instead of LEFT JOIN: movie_id and status_id are NOT NULL on watchlist, so they're guaranteed to match. INNER JOIN and LEFT JOIN return identical results 
*   here. INNER JOIN is just the more honest choice, since it reflects that those FKs always resolve. 
*/
DELIMITER $$
CREATE PROCEDURE sp_get_user_watchlist(
    IN p_user_id CHAR(36)
	)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM app_user WHERE id = p_user_id) THEN
			SELECT 'ERROR: user not found' AS message;
		ELSE
			SELECT
				m.title,
				m.release_year,
				sw.name AS status,
				w.added_at
			FROM watchlist w
			JOIN movie m ON m.id = w.movie_id
            JOIN status_watchlist sw ON sw.id = w.status_id
			WHERE w.user_id = p_user_id
			ORDER BY w.added_at DESC;
		END IF;
	END$$
DELIMITER ;

/*
*   Procedure: delete_review
*   Deletes a review, either the review's own author, or any user with the ADMIN role, is allowed to delete it.
*
*   COLUMN p_role_name: Carries the caller's role so the procedure can apply that owner-or-admin rule directly: delete if user_id matches, OR if p_role_name = 'ADMIN'. 
*   This is real access control, not just an existence check.
*/
DELIMITER $$
CREATE PROCEDURE sp_delete_review(
    IN p_review_id CHAR(36),
    IN p_user_id CHAR(36),
    IN p_role_name VARCHAR(50)
	)
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM review WHERE id = p_review_id) THEN
			SELECT 'ERROR: review not found' AS message;
		ELSEIF NOT EXISTS (SELECT 1 FROM review WHERE id = p_review_id AND user_id = p_user_id)
			AND p_role_name != 'ADMIN' THEN
			SELECT 'ERROR: not authorized' AS message;
		ELSE
			DELETE FROM review WHERE id = p_review_id;
			SELECT 'OK: review deleted' AS message;
		END IF;
	END$$
DELIMITER ;