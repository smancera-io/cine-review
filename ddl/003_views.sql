/* Creation of views */
/* Creation of the v_movie_ranking view */
CREATE VIEW v_movie_ranking AS
	SELECT
		m.title,
		m.release_year,
		cl.name AS classification,
		c.name AS country,
		COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating,
		COUNT(DISTINCT r.id) AS total_reviews,
		SUM(CASE WHEN ma.won THEN 1 ELSE 0 END) AS awards_won
	FROM movie m
		LEFT JOIN review r ON r.movie_id = m.id
		LEFT JOIN country c ON c.id = m.country_id
		LEFT JOIN classification cl ON cl.id = m.classification_id
		LEFT JOIN movie_award ma ON ma.movie_id = m.id
	GROUP BY m.id, m.title, m.release_year, cl.name, c.name
	ORDER BY avg_rating DESC;

/* Creation of the v_genre_popularity view */
CREATE VIEW v_genre_popularity AS
	SELECT
		g.name AS genre,
		COUNT(DISTINCT mg.movie_id) AS total_movies,
		COUNT(DISTINCT r.id) AS total_reviews,
		ROUND(AVG(r.rating), 2) AS avg_rating
	FROM genre g
		LEFT JOIN movie_genre mg ON mg.genre_id = g.id
		LEFT JOIN review r ON r.movie_id = mg.movie_id
	GROUP BY g.id, g.name
	ORDER BY total_reviews DESC;

/* Creation of the v_watchlist_popularity view */
CREATE VIEW v_watchlist_popularity AS
	SELECT
		m.title,
		m.release_year,
		g_list.genres,
		COUNT(DISTINCT w.user_id) AS total_users,
		SUM(CASE WHEN sw.name = 'WATCHED'  THEN 1 ELSE 0 END) AS watched,
		SUM(CASE WHEN sw.name = 'WATCHING' THEN 1 ELSE 0 END) AS watching,
		SUM(CASE WHEN sw.name = 'PENDING'  THEN 1 ELSE 0 END) AS pending,
		SUM(CASE WHEN sw.name = 'DROPPED'  THEN 1 ELSE 0 END) AS dropped
	FROM movie m
		LEFT JOIN watchlist w ON w.movie_id = m.id
		LEFT JOIN status_watchlist sw ON sw.id = w.status_id
		LEFT JOIN (
			SELECT mg.movie_id,
			GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
			FROM movie_genre mg
			JOIN genre g ON g.id = mg.genre_id
				GROUP BY mg.movie_id
			) g_list ON g_list.movie_id = m.id
	GROUP BY m.id, m.title, m.release_year, g_list.genres
	ORDER BY total_users DESC;

/* Creation of the v_user_activity view */
CREATE VIEW v_user_activity AS
	SELECT
		u.name,
		u.last_name,
		u.email,
		c.name AS country,
		COUNT(DISTINCT r.id) AS total_reviews,
		ROUND(AVG(r.rating), 2) AS avg_rating_given,
		COUNT(DISTINCT w.id) AS total_watchlist,
		SUM(CASE WHEN sw.name = 'WATCHED' THEN 1 ELSE 0 END) AS movies_watched
	FROM app_user u
		LEFT JOIN review r ON r.user_id = u.id
		LEFT JOIN watchlist w ON w.user_id = u.id
		LEFT JOIN status_watchlist sw ON sw.id = w.status_id
		LEFT JOIN country c ON c.id = u.country_id
	GROUP BY u.id, u.name, u.last_name, u.email, c.name
	ORDER BY total_reviews DESC;

/* Creation of the v_genre_by_user_preference view */
CREATE VIEW v_genre_by_user_preference AS
	SELECT
		u.name,
		u.last_name,
		g.name AS genre,
		COUNT(DISTINCT r.id) AS reviews_in_genre,
		ROUND(AVG(r.rating), 2) AS avg_rating_in_genre
	FROM app_user u
		JOIN review r ON r.user_id = u.id
		JOIN movie_genre mg ON mg.movie_id = r.movie_id
		JOIN genre g ON g.id = mg.genre_id
	GROUP BY u.id, u.name, u.last_name, g.id, g.name
	ORDER BY u.last_name, reviews_in_genre DESC;

/* Creation of the v_country_performance view */
CREATE VIEW v_country_performance AS
	SELECT
		c.name AS country,
		COUNT(DISTINCT m.id) AS movies_produced,
		COUNT(DISTINCT r.id) AS total_reviews,
		ROUND(AVG(r.rating), 2) AS avg_rating,
		COUNT(DISTINCT w.user_id) AS users_from_country,
		SUM(CASE WHEN ma.won THEN 1 ELSE 0 END) AS total_awards_won
	FROM country c
		LEFT JOIN movie m ON m.country_id = c.id
		LEFT JOIN review r ON r.movie_id = m.id
		LEFT JOIN watchlist w ON w.user_id IN (
			SELECT id FROM app_user WHERE country_id = c.id
			)
		LEFT JOIN movie_award ma ON ma.movie_id = m.id AND ma.won = TRUE
	GROUP BY c.id, c.name
	ORDER BY total_reviews DESC;

/* Creation of the v_streaming_reach view */
CREATE VIEW v_streaming_reach AS
	SELECT
		sp.name AS platform,
		COUNT(DISTINCT mp.movie_id) AS total_movies,
		COUNT(DISTINCT r.id) AS total_reviews,
		ROUND(AVG(r.rating), 2) AS avg_rating,
		GROUP_CONCAT(
			DISTINCT g.name
			ORDER BY g.name
			SEPARATOR ', '
		) AS top_genres
	FROM streaming_platform sp
		LEFT JOIN movie_platform mp ON mp.platform_id = sp.id
			AND (mp.available_until IS NULL OR mp.available_until > CURDATE())
		LEFT JOIN review r ON r.movie_id = mp.movie_id
		LEFT JOIN movie_genre mg ON mg.movie_id = mp.movie_id
		LEFT JOIN genre g ON g.id = mg.genre_id
	GROUP BY sp.id, sp.name
	ORDER BY total_movies DESC;