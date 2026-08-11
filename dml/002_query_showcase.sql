/*
*   Sample queries demonstrating SQL technique range across 4 groups: Relational operators, grouping/aggregate functions, date handling, and multi-table joins.
*   Run after 001_seed_data.sql (and, for the fullest result sets, after 003_procedures_driven_data.sql too), no variables used here, just needs the data to already exist. 
*/

/* 
*   Queries with relational operators.
*   Query of movies released after 2015.
*/
SELECT 
   title, 
   release_year
FROM movie
WHERE release_year > 2015
ORDER BY release_year DESC;

/* 
*   Query of reviews with rating greater than or equal to 9.
*/
SELECT 
   id, 
   rating, 
   body
FROM review
WHERE rating >= 9
ORDER BY rating DESC;

/* 
*   Query of classifications restricting viewers over 12.
*/
SELECT 
   classification_system, 
   name, 
   min_age
FROM classification
WHERE min_age > 12
ORDER BY min_age;

/* 
*   Query of movies with an assigned tmdb_id.
*/
SELECT 
   title, 
   release_year, 
   tmdb_id
FROM movie
WHERE tmdb_id IS NOT NULL
ORDER BY release_year DESC;

/* 
*   Query of expired platform availabilities.
*/
SELECT 
   movie_id, 
   platform_id, 
   available_since, 
   available_until
FROM movie_platform
WHERE available_until IS NOT NULL
   AND available_until <= CURDATE();

/* 
*   Queries with grouping functions.
*   Query of global rating statistics.
*/
SELECT  
   MAX(rating) AS max_rating,
   MIN(rating) AS min_rating,
   ROUND(AVG(rating), 2) AS avg_rating,
   SUM(rating) AS sum_total,
   COUNT(*) AS total_reviews
FROM review;

/* 
*   Query of average rating per movie, 
*/
SELECT 
   movie_id,
   ROUND(AVG(rating), 2) AS avg_rating,
   COUNT(*) AS review_count
FROM review
GROUP BY movie_id
ORDER BY avg_rating DESC;

/*
*   Query of wins and nominations per movie. SUM(won) works with no CAST: BOOLEAN is TINYINT(1) in MySQL, so this sums 1s and 0s directly. COUNT(*), SUM(won) derives losses
*   from that same sum instead of a second aggregate or CASE WHEN.
*/
SELECT 
   movie_id,
   COUNT(*) AS total_nominations,
   SUM(won) AS total_wins,
   COUNT(*) - SUM(won) AS total_losses
FROM movie_award
GROUP BY movie_id
ORDER BY total_wins DESC;

/* 
*   Query of number of movies per genre.
*/
SELECT 
   g.name AS genre,
   COUNT(mg.movie_id) AS total_movies
FROM genre g
LEFT JOIN movie_genre mg ON mg.genre_id = g.id
GROUP BY g.id, g.name
ORDER BY total_movies DESC;

/* 
*   Query of reviewer activity. 
*/
SELECT 
   user_id,
   COUNT(*) AS reviews_written,
   ROUND(AVG(rating), 2) AS avg_given_rating,
   MAX(rating) AS highest_given,
   MIN(rating) AS lowest_given
FROM review
GROUP BY user_id
ORDER BY reviews_written DESC;

/* 
*   Queries with dates.
*   Query of users registered in the current year.
*/
SELECT 
   name, 
   last_name, 
   email, 
   created_at
FROM app_user
WHERE YEAR(created_at) = YEAR(CURDATE());

/* 
*   Query of monthly review distribution. 
*/
SELECT 
   YEAR(created_at) AS year,
   MONTH(created_at) AS month,
   COUNT(*) AS reviews_count
FROM review
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY year, month;

/*
*   Query of awards per year in the last decade.
*   ma.year >= 2015 AND ma.year <= 2025 is equivalent to BETWEEN 2015 AND 2025 ther are written this way as a style choice here, not because BETWEEN doesn't apply.
*/
SELECT  
   ma.year,
   COUNT(*) AS total_nominations,
   SUM(ma.won) AS total_wins
FROM movie_award ma
WHERE ma.year >= 2015 AND ma.year <= 2025
GROUP BY ma.year
ORDER BY ma.year DESC;

/* 
*   Query of directors older than 50 years.
*/
SELECT 
   p.name, 
   p.last_name, 
   p.birth_date,
   TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) AS age
FROM person p
JOIN director d ON d.id = p.id
WHERE TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) > 50
ORDER BY age DESC;

/*
*   Multi-table queries.
*   Query of movies with country of production and classification.
*/
SELECT 
   m.title, 
   m.release_year,
   c.name AS country,
   cl.name AS classification,
   cl.min_age
FROM movie m
JOIN country c ON c.id = m.country_id
JOIN classification cl ON cl.id = m.classification_id
ORDER BY m.release_year DESC;

/* 
*   Query of movies with director, director nationality and directing style.
*/
SELECT 
   m.title, 
   m.release_year,
   p.name AS director_name,
   p.last_name AS director_last_name,
   c.name AS director_nationality,
   ds.name AS directing_style,
   dr.name AS role_in_film
FROM movie_director md
JOIN movie m ON m.id = md.movie_id
JOIN director d ON d.id = md.director_id
JOIN person p ON p.id = d.id
JOIN country c ON c.id = p.country_id
JOIN directing_style ds ON ds.id = d.directing_style_id
JOIN director_role dr ON dr.id = md.role_id
ORDER BY m.title;

/*
*   Query of genres per movie.
*   Same GROUP_CONCAT technique as v_watchlist_popularity, simpler here since there's no risk of fan-out from a second joined table in the same GROUP BY.
*/
SELECT 
   m.title,
   GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
FROM movie m
JOIN movie_genre mg ON mg.movie_id = m.id
JOIN genre g ON g.id = mg.genre_id
GROUP BY m.id, m.title
ORDER BY m.title;

/* 
*   Query of lead actors with acting method.
*/
SELECT 
   m.title,
   p.name AS actor_name,
   p.last_name,
   ma.character_name,
   am.name AS acting_method
FROM movie_actor ma
JOIN movie m ON m.id = ma.movie_id
JOIN actor a ON a.id = ma.actor_id
JOIN person p ON p.id = a.id
JOIN acting_method am ON am.id = a.acting_method_id
WHERE ma.is_lead = TRUE
ORDER BY m.title;

/* 
*   Query of reviews with full user and movie data. 
*/
SELECT 
   u.name, 
   u.last_name,
   m.title, 
   r.rating, 
   r.body, 
   r.created_at
FROM review r
JOIN app_user u ON u.id = r.user_id
JOIN movie m ON m.id = r.movie_id
ORDER BY r.created_at DESC;

/* 
*   Query of movies currently available on streaming platforms. 
*/
SELECT 
   m.title, 
   m.release_year,
   sp.name AS platform,
   mp.available_since
FROM movie_platform mp
JOIN movie m ON m.id = mp.movie_id
JOIN streaming_platform sp ON sp.id = mp.platform_id
WHERE mp.available_until IS NULL
   OR mp.available_until > CURDATE()
ORDER BY sp.name, m.title;

/* 
*   Query of movies with their production companies. 
*/
SELECT 
   m.title,
   pc.name AS company,
   cr.name AS company_role
FROM movie_company mc
JOIN movie m ON m.id = mc.movie_id
JOIN production_company pc ON pc.id = mc.company_id
JOIN company_role cr ON cr.id = mc.role_id
WHERE cr.name = 'PRODUCER'
ORDER BY m.title;

/* 
*   Query of award-winning movies.
*/
SELECT 
   m.title,
   a.name AS award,
   ac.name AS category,
   ma.year
FROM movie_award ma
JOIN movie m ON m.id = ma.movie_id
JOIN award a ON a.id = ma.award_id
JOIN award_category ac ON ac.id = ma.category_id
WHERE ma.won = TRUE
ORDER BY ma.year DESC;

/* 
*   Query of user watchlists with status.
*/
SELECT 
   u.name, 
   u.last_name,
   m.title, 
   sw.name AS status,
   w.added_at
FROM watchlist w
JOIN app_user u ON u.id = w.user_id
JOIN movie m ON m.id = w.movie_id
JOIN status_watchlist sw ON sw.id = w.status_id
ORDER BY u.last_name, w.added_at DESC;

/*
*   Query of award-winning people.
*   LEFT JOIN to country, unlike the plain JOINs elsewhere in this section: person.country_id is nullable. With a normal JOIN, a winner with an unset country_id would find 
*   no match and vanish from the results entirely, the wrong outcome for a query meant to list every award winner. LEFT JOIN keeps the row and leaves nationality blank instead.
*/
SELECT 
   p.name, 
   p.last_name,
   c.name AS nationality,
   a.name AS award,
   ac.name AS category,
   pa.year
FROM person_award pa
JOIN person p ON p.id = pa.person_id
JOIN award a ON a.id = pa.award_id
JOIN award_category ac ON ac.id = pa.category_id
LEFT JOIN country c ON c.id = p.country_id
WHERE pa.won = TRUE
ORDER BY pa.year DESC;

/*
*   Query of movies with no reviews using LEFT JOIN.
*   Anti-join pattern: LEFT JOIN review, then WHERE r.id IS NULL. A movie with no matching review row gets r.id = NULL in the joined result, so the WHERE clause keeps 
*   exactly the movies with zero reviews and nothing else.
*/
SELECT 
   m.title, 
   m.release_year, 
   c.name AS country
FROM movie m
LEFT JOIN review r ON r.movie_id = m.id
JOIN country c ON c.id = m.country_id
WHERE r.id IS NULL
ORDER BY m.release_year;

/*
*   Query of directors with their number of movies in the catalog.
*   LEFT JOIN to movie_director, same reasoning as v_genre_popularity: A director with zero movies assigned would find no match on a normal JOIN and disappear from the list 
*   entirely, indistinguishable from not existing. LEFT JOIN keeps the row; COUNT(md.movie_id) ignores the resulting NULL and correctly reports 0.
*/
SELECT 
   p.name, 
   p.last_name,
   ds.name AS directing_style,
   COUNT(md.movie_id) AS movies_in_catalog
FROM director d
JOIN person p ON p.id = d.id
JOIN directing_style ds ON ds.id = d.directing_style_id
LEFT JOIN movie_director md ON md.director_id = d.id
GROUP BY d.id, p.name, p.last_name, ds.name
ORDER BY movies_in_catalog DESC;