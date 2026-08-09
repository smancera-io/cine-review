/*
*   Views: Read-only reporting layer.
*   These 7 views aggregate data from the schema defined in 001_tables.sql for analytics-style queries (rankings, activity summaries, performance by country/platform). 
*   They are not part of the app's transactional write path.
*
*   Requires 001_tables.sql to already exist MySQL resolves each view's columns against the underlying tables at CREATE VIEW time.
*
*   Convention used throughout: LEFT JOIN + COALESCE(..., 0), so an entity with no activity yet (an unreviewed movie, a country with no productions) still appears 
*   with 0 instead of disappearing from the ranking. The one deliberate exception is v_genre_by_user_preference, which uses INNER JOIN because a user
*   with no reviews has no genre preference to report at all.
*/

/*
*   View: movie_ranking.
*   Rank movies by average rating. Besides, it shows basic information (title, release year, classification, country), number of reviews and awards won.
* 
*   Use LEFT JOIN instead of INNER JOIN: A movie without any review yet must appear likewise in the ranking, doesn't disappear.
*   COALESCE (AVG(...), 0): Its function acts when a movie hasn't gotten any review and its rating is null, replacing null with 0. 
*   It's a decision about how to cope with 'movies unrated'.
*/
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

/* 
*   View: genre_popularity.
*   Rank genres by total reviews. Besides, it shows total movies and average rating by genre.
*
*   Use LEFT JOIN instead of INNER JOIN: A genre without any review or movie must appear likewise in the ranking, doesn't disappear.
*   COALESCE (AVG(...), 0): Its function acts when a genre hasn't gotten any review and its rating is null, replacing null with 0. 
*   It's a decision about how to cope with 'unrated genres'.
*/
CREATE VIEW v_genre_popularity AS
	SELECT
		g.name AS genre,
		COUNT(DISTINCT mg.movie_id) AS total_movies,
		COUNT(DISTINCT r.id) AS total_reviews,
		COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating
	FROM genre g
		LEFT JOIN movie_genre mg ON mg.genre_id = g.id
		LEFT JOIN review r ON r.movie_id = mg.movie_id
	GROUP BY g.id, g.name
	ORDER BY total_reviews DESC;

/* 
*   View: watchlist_popularity.
*   Rank movies by total users who have the movie in their watchlist. Besides, it shows basic movie information (title, release year and genres) and watchlist details.
*    
*   Use LEFT JOIN instead of INNER JOIN: Movies not appearing in watchlist must appear with all their watchlist statistics in 0, don't disappear.
*   Subquery LEFT JOIN g_list: It's a subquery which gets a list of genres by each movie using group concat to show them in a single cell separating by a comma.
*/
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

/*
*   View: user_activity.
*   Rank users by total reviews. Besides, it shows personal information (name, last name, email, country), average rating given, total movies in watchlist 
*   and movies watched.
*
*   Use LEFT JOIN instead of INNER JOIN: Users without any review must appear with all their information and statistics in 0, don't disappear.
*   COALESCE (AVG(...), 0): Its function acts when a user hasn't given any review and their rating given is null, replacing null with 0. 
*   It's a decision about how to cope with 'Passive user'.
*/
CREATE VIEW v_user_activity AS
	SELECT
		u.name,
		u.last_name,
		u.email,
		c.name AS country,
		COUNT(DISTINCT r.id) AS total_reviews,
		COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating_given,
		COUNT(DISTINCT w.id) AS total_watchlist,
		SUM(CASE WHEN sw.name = 'WATCHED' THEN 1 ELSE 0 END) AS movies_watched
	FROM app_user u
		LEFT JOIN review r ON r.user_id = u.id
		LEFT JOIN watchlist w ON w.user_id = u.id
		LEFT JOIN status_watchlist sw ON sw.id = w.status_id
		LEFT JOIN country c ON c.id = u.country_id
	GROUP BY u.id, u.name, u.last_name, u.email, c.name
	ORDER BY total_reviews DESC;

/* 
*   View: genre_by_user_preference.
*   Analyze user review metrics and average ratings across genres. Showing by each user-genre total reviews and average rating.
*
*   Use INNER JOIN instead of LEFT JOIN: Users without any activity yet must not appear because it's an analysis of users with activity.
*/
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

/*
*   View: country_performance.
*   Rank countries by total reviews associated with their movies. Besides, it shows statistics by country such as total movies produced, average rating, users from its 
*   and total awards won.
*
*   Use LEFT JOIN instead of INNER JOIN: Countries without any movie produced or review done must appear with all their statistics in 0, don't disappear.
*   Subquery common column LEFT JOIN IN: Its purpose is to get the list of users by country.
*   COALESCE (AVG(...), 0): Its function acts when a country hasn't gotten any review and its average rating is null, replacing null with 0. 
*   It's a decision about how to cope with 'Unrated countries'.
*/
CREATE VIEW v_country_performance AS
	SELECT
		c.name AS country,
		COUNT(DISTINCT m.id) AS movies_produced,
		COUNT(DISTINCT r.id) AS total_reviews,
		COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating,
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

/*
*   View: streaming_reach.
*   Rank streaming platforms by total reviews. Besides, it shows information about total movies, average rating and top genres.
*
*   Use LEFT JOIN instead of INNER JOIN: Platforms without any movie or statistic must appear with all their information in base values as 0 or 'Empty'.
*   GROUP CONCAT: Links distinct list of genres by a comma.
*   AND condition LEFT JOIN mp: Uses a second condition to ensure the movie statistics are based only on movies currently available.
*   COALESCE (AVG(...), 0): Its function acts when a platform hasn't had any movie or review and its average rating is null, replacing null with 0. 
*   It's a decision about how to cope with 'Unrated platforms'.
*/
CREATE VIEW v_streaming_reach AS
	SELECT
		sp.name AS platform,
		COUNT(DISTINCT mp.movie_id) AS total_movies,
		COUNT(DISTINCT r.id) AS total_reviews,
		COALESCE(ROUND(AVG(r.rating), 2), 0) AS avg_rating,
		COALESCE(GROUP_CONCAT(
			DISTINCT g.name
			ORDER BY g.name
			SEPARATOR ', '
		), 'Empty') AS top_genres
	FROM streaming_platform sp
		LEFT JOIN movie_platform mp ON mp.platform_id = sp.id
			AND (mp.available_until IS NULL OR mp.available_until > CURDATE())
		LEFT JOIN review r ON r.movie_id = mp.movie_id
		LEFT JOIN movie_genre mg ON mg.movie_id = mp.movie_id
		LEFT JOIN genre g ON g.id = mg.genre_id
	GROUP BY sp.id, sp.name
	ORDER BY total_movies DESC;