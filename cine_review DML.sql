/* Queries with relational operators */
/* Query of movies released after 2015 */
SELECT title, release_year
FROM movie
WHERE release_year > 2015
ORDER BY release_year DESC;

/* Query of reviews with rating greater than or equal to 9 */
SELECT id, rating, body
FROM review
WHERE rating >= 9
ORDER BY rating DESC;

/* Query of classifications restricting viewers over 12 */
SELECT classification_system, name, min_age
FROM classification
WHERE min_age > 12
ORDER BY min_age;

/* Query of movies with an assigned tmdb_id */
SELECT title, release_year, tmdb_id
FROM movie
WHERE tmdb_id IS NOT NULL
ORDER BY release_year DESC;

/* Query of expired platform availabilities */
SELECT movie_id, platform_id, available_since, available_until
FROM movie_platform
WHERE available_until IS NOT NULL
  AND available_until <= CURDATE();

/* Queries with grouping functions */
/* Query of global rating statistics */
SELECT MAX(rating) AS max_rating,
       MIN(rating) AS min_rating,
       ROUND(AVG(rating), 2) AS avg_rating,
       SUM(rating) AS sum_total,
       COUNT(*) AS total_reviews
FROM review;

/* Query of average rating per movie */
SELECT movie_id,
       ROUND(AVG(rating), 2) AS avg_rating,
       COUNT(*) AS review_count
FROM review
GROUP BY movie_id
ORDER BY avg_rating DESC;

/* Query of wins and nominations per movie */
SELECT movie_id,
       COUNT(*) AS total_nominations,
       SUM(won) AS total_wins,
       COUNT(*) - SUM(won) AS total_losses
FROM movie_award
GROUP BY movie_id
ORDER BY total_wins DESC;

/* Query of number of movies per genre */
SELECT g.name AS genre,
       COUNT(mg.movie_id) AS total_movies
FROM genre g
LEFT JOIN movie_genre mg ON mg.genre_id = g.id
GROUP BY g.id, g.name
ORDER BY total_movies DESC;

/* Query of reviewer activity */
SELECT user_id,
       COUNT(*) AS reviews_written,
       ROUND(AVG(rating), 2) AS avg_given_rating,
       MAX(rating) AS highest_given,
       MIN(rating) AS lowest_given
FROM review
GROUP BY user_id
ORDER BY reviews_written DESC;

/* Queries with dates */
/* Query of users registered in the current year */
SELECT name, last_name, email, created_at
FROM app_user
WHERE YEAR(created_at) = YEAR(CURDATE());

/* Query of monthly review distribution */
SELECT YEAR(created_at) AS year,
       MONTH(created_at) AS month,
       COUNT(*) AS reviews_count
FROM review
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY year, month;

/* Query of awards per year in the last decade */
SELECT ma.year,
       COUNT(*) AS total_nominations,
       SUM(ma.won) AS total_wins
FROM movie_award ma
WHERE ma.year >= 2015 AND ma.year <= 2025
GROUP BY ma.year
ORDER BY ma.year DESC;

/* Query of directors older than 50 years */
SELECT p.name, p.last_name, p.birth_date,
       TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) AS age
FROM person p
JOIN director d ON d.id = p.id
WHERE TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) > 50
ORDER BY age DESC;

/* Multi-table queries */
/* Query of movies with country of production and classification */
SELECT m.title, m.release_year,
       c.name AS country,
       cl.name AS classification,
       cl.min_age
FROM movie m
JOIN country c ON c.id = m.country_id
JOIN classification cl ON cl.id = m.classification_id
ORDER BY m.release_year DESC;

/* Query of movies with director, director nationality and directing style */
SELECT m.title, m.release_year,
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

/* Query of genres per movie */
SELECT m.title,
       GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
FROM movie m
JOIN movie_genre mg ON mg.movie_id = m.id
JOIN genre g ON g.id = mg.genre_id
GROUP BY m.id, m.title
ORDER BY m.title;

/* Query of lead actors with acting method */
SELECT m.title,
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

/* Query of reviews with full user and movie data */
SELECT u.name, u.last_name,
       m.title, r.rating, r.body, r.created_at
FROM review r
JOIN app_user u ON u.id = r.user_id
JOIN movie m ON m.id = r.movie_id
ORDER BY r.created_at DESC;

/* Query of movies currently available on streaming platforms */
SELECT m.title, m.release_year,
       sp.name AS platform,
       mp.available_since
FROM movie_platform mp
JOIN movie m ON m.id = mp.movie_id
JOIN streaming_platform sp ON sp.id = mp.platform_id
WHERE mp.available_until IS NULL
   OR mp.available_until > CURDATE()
ORDER BY sp.name, m.title;

/* Query of movies with their production companies */
SELECT m.title,
       pc.name AS company,
       cr.name AS company_role
FROM movie_company mc
JOIN movie m ON m.id = mc.movie_id
JOIN production_company pc ON pc.id = mc.company_id
JOIN company_role cr ON cr.id = mc.role_id
WHERE cr.name = 'PRODUCER'
ORDER BY m.title;

/* Query of award-winning movies */
SELECT m.title,
       a.name AS award,
       ac.name AS category,
       ma.year
FROM movie_award ma
JOIN movie m ON m.id = ma.movie_id
JOIN award a ON a.id = ma.award_id
JOIN award_category ac ON ac.id = ma.category_id
WHERE ma.won = TRUE
ORDER BY ma.year DESC;

/* Query of user watchlists with status */
SELECT u.name, u.last_name,
       m.title, sw.name AS status, w.added_at
FROM watchlist w
JOIN app_user u ON u.id = w.user_id
JOIN movie m ON m.id = w.movie_id
JOIN status_watchlist sw ON sw.id = w.status_id
ORDER BY u.last_name, w.added_at DESC;

/* Query of award-winning people */
SELECT p.name, p.last_name,
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

/* Query of movies with no reviews using LEFT JOIN */
SELECT m.title, m.release_year, c.name AS country
FROM movie m
LEFT JOIN review r ON r.movie_id = m.id
JOIN country c ON c.id = m.country_id
WHERE r.id IS NULL
ORDER BY m.release_year;

/* Query of directors with their number of movies in the catalog */
SELECT p.name, p.last_name,
       ds.name AS directing_style,
       COUNT(md.movie_id) AS movies_in_catalog
FROM director d
JOIN person p ON p.id = d.id
JOIN directing_style ds ON ds.id = d.directing_style_id
LEFT JOIN movie_director md ON md.director_id = d.id
GROUP BY d.id, p.name, p.last_name, ds.name
ORDER BY movies_in_catalog DESC;

/* Call to the sp_insert_movie stored procedure */
CALL sp_insert_movie('Oppenheimer', 2023, @uk, @cl_r,
    'J. Robert Oppenheimer lidera el Proyecto Manhattan para construir la primera bomba atómica.',
    872585, @p_nolan, @dr_dir, @g_bio, @g_drama, @g_thriller);
CALL sp_insert_movie('Tenet', 2020, @uk, @cl_pg13,
    'Un agente aprende a manipular el flujo del tiempo para prevenir la Tercera Guerra Mundial.',
    577922, @p_nolan, @dr_dir, @g_action, @g_scifi, @g_thriller);
CALL sp_insert_movie('Dune: Part Two', 2024, @us, @cl_pg13,
    'Paul Atreides se une a los Fremen y lidera una guerra santa para vengar a su familia.',
    693134, @p_vil, @dr_dir, @g_scifi, @g_action, NULL);
CALL sp_insert_movie('Portrait of a Lady on Fire', 2019, @fr, @cl_r,
    'Una pintora y su modelo desarrollan un romance apasionado en la Francia del siglo XVIII.',
    400617, @p_sciamma, @dr_dir, @g_drama, @g_romance, NULL);
CALL sp_insert_movie('Snowpiercer', 2013, @kr, @cl_r,
    'Los supervivientes de un apocalipsis climático viven en un tren que da la vuelta al mundo, divididos por clases.',
    144183, @p_bong, @dr_dir, @g_scifi, @g_action, @g_thriller);
CALL sp_insert_movie('Okja', 2017, @kr, @cl_pg13,
    'Una niña lucha para salvar a su mejor amiga, una enorme criatura, de una corporación multinacional.',
    396535, @p_bong, @dr_dir, @g_drama, @g_action, NULL);
CALL sp_insert_movie('1917', 2019, @uk, @cl_r,
    'Dos soldados tienen horas para entregar un mensaje que puede salvar 1600 vidas en la Primera Guerra Mundial.',
    530915, @p_mendes, @dr_dir, @g_drama, @g_action, NULL);
CALL sp_insert_movie('Whiplash', 2014, @us, @cl_r,
    'Un joven baterista se somete al brutal entrenamiento de un director de orquesta obsesionado con la perfección.',
    244786, @p_chazelle, @dr_dir, @g_drama, @g_thriller, NULL);
CALL sp_insert_movie('Sicario', 2015, @us, @cl_r,
    'Una agente del FBI es reclutada para una operación encubierta en la frontera narco entre México y Estados Unidos.',
    273481, @p_vil, @dr_dir, @g_thriller, @g_action, NULL);
CALL sp_insert_movie('Y tu mamá también', 2001, @mx, @cl_nc17,
    'Dos amigos adolescentes emprenden un viaje por carretera con una mujer mayor que cambiará sus vidas.',
    9069, @p_cuaron, @dr_dir, @g_drama, @g_comedy, NULL);

/* Call to the sp_insert_person stored procedure */
CALL sp_insert_person('Paul Thomas', 'Anderson', '1970-06-26', @us, 'DIRECTOR', @ds_psych);
CALL sp_insert_person('Florence', 'Pugh', '1996-01-03', @uk, 'ACTOR', @am_stan);
CALL sp_insert_person('Ke Huy', 'Quan', '1971-08-20', @us, 'ACTOR', @am_meis);

/* Call to the sp_register_user stored procedure */
CALL sp_register_user('Sofía', 'González', 'sofia.gonzalez@email.com',
    '$2a$12$SoFiAhAsHeDpAsSwOrD1234567890AbCdEfGhIjKlMnOpQrStUv', @co, '1993-06-12', @r_user);
CALL sp_register_user('James', 'Park', 'james.park@email.com',
    '$2a$12$JaMeSpArKhAsHeDpAsS1234567890AbCdEfGhIjKlMnOpQrSt', @kr, '1997-09-30', @r_user);
CALL sp_register_user('Marie', 'Dupont', 'marie.dupont@email.com',
    '$2a$12$MaRiEdUpOnThAsHeDpAs1234567890AbCdEfGhIjKlMnOpQr', @fr, '2001-03-18', @r_user);

/* Recovery of IDs from records inserted via stored procedures */
SET @mv_oppen = (SELECT id FROM movie WHERE tmdb_id = 872585);
SET @mv_tenet = (SELECT id FROM movie WHERE tmdb_id = 577922);
SET @mv_dune2 = (SELECT id FROM movie WHERE tmdb_id = 693134);
SET @mv_portrait = (SELECT id FROM movie WHERE tmdb_id = 400617);
SET @mv_snow = (SELECT id FROM movie WHERE tmdb_id = 144183);
SET @mv_okja = (SELECT id FROM movie WHERE tmdb_id = 396535);
SET @mv_1917 = (SELECT id FROM movie WHERE tmdb_id = 530915);
SET @mv_whip = (SELECT id FROM movie WHERE tmdb_id = 244786);
SET @mv_sicario = (SELECT id FROM movie WHERE tmdb_id = 273481);
SET @mv_ytumama = (SELECT id FROM movie WHERE tmdb_id = 9069);
SET @u_sofia = (SELECT id FROM app_user WHERE email = 'sofia.gonzalez@email.com');
SET @u_james = (SELECT id FROM app_user WHERE email = 'james.park@email.com');
SET @u_marie = (SELECT id FROM app_user WHERE email = 'marie.dupont@email.com');

/* Additional insertion of values into the watchlist table */
INSERT INTO watchlist (user_id, movie_id, status_id) VALUES
	(@u_carlos, @mv_oppen, @ws_done),
	(@u_carlos, @mv_dune2, @ws_wtch),
	(@u_carlos, @mv_1917, @ws_done),
	(@u_carlos, @mv_whip, @ws_pend),
	(@u_laura, @mv_portrait, @ws_done),
	(@u_laura, @mv_oppen, @ws_wtch),
	(@u_laura, @mv_snow, @ws_pend),
	(@u_laura, @mv_tenet, @ws_drop),
	(@u_minjun, @mv_dune2, @ws_done),
	(@u_minjun, @mv_snow, @ws_done),
	(@u_minjun, @mv_okja, @ws_done),
	(@u_minjun, @mv_tenet, @ws_wtch),
	(@u_jiwoo, @mv_oppen, @ws_done),
	(@u_jiwoo, @mv_dune2, @ws_done),
	(@u_jiwoo, @mv_portrait, @ws_pend),
	(@u_jiwoo, @mv_1917, @ws_wtch),
	(@u_sofia, @mv_inception, @ws_done),
	(@u_sofia, @mv_parasite, @ws_done),
	(@u_sofia, @mv_oppen, @ws_done),
	(@u_sofia, @mv_barbie, @ws_done),
	(@u_sofia, @mv_dune2, @ws_wtch),
	(@u_sofia, @mv_portrait, @ws_pend),
	(@u_sofia, @mv_whip, @ws_pend),
	(@u_sofia, @mv_sicario, @ws_drop),
	(@u_james, @mv_parasite, @ws_done),
	(@u_james, @mv_snow, @ws_done),
	(@u_james, @mv_okja, @ws_done),
	(@u_james, @mv_dune2, @ws_done),
	(@u_james, @mv_tenet, @ws_drop),
	(@u_james, @mv_arrival, @ws_done),
	(@u_james, @mv_moonlight, @ws_pend),
	(@u_marie, @mv_portrait, @ws_done),
	(@u_marie, @mv_barbie, @ws_done),
	(@u_marie, @mv_roma, @ws_done),
	(@u_marie, @mv_ytumama, @ws_wtch),
	(@u_marie, @mv_oppen, @ws_pend),
	(@u_marie, @mv_1917, @ws_pend),
	(@u_marie, @mv_blade, @ws_drop);

/* Additional insertion of values into the movie_platform table */
INSERT INTO movie_platform (movie_id, platform_id, available_since, available_until) VALUES
	(@mv_oppen, @sp_hbo, '2023-11-01', NULL),
	(@mv_tenet, @sp_hbo, '2021-01-01', NULL),
	(@mv_dune2, @sp_hbo, '2024-05-21', NULL),
	(@mv_portrait, @sp_mubi, '2020-06-01', NULL),
	(@mv_snow, @sp_nflx, '2020-01-01', NULL),
	(@mv_1917, @sp_amazon, '2020-04-01', NULL),
	(@mv_whip, @sp_nflx, '2020-01-01', NULL),
	(@mv_sicario, @sp_amazon, '2020-01-01', NULL);

/* Additional insertion of values into the review table */
INSERT INTO review (user_id, movie_id, rating, body) VALUES
	(@u_carlos, @mv_oppen, 10, 'Una obra monumental. Nolan en su cima narrativa y técnica.'),
	(@u_carlos, @mv_1917, 9, 'La ilusión del plano secuencia es un logro técnico impresionante.'),
	(@u_carlos, @mv_whip, 9, 'Brutal y adictiva. Fletcher es uno de los mejores villanos recientes.'),
	(@u_laura, @mv_portrait, 10, 'Sciamma construye una historia de amor con una precisión devastadora.'),
	(@u_laura, @mv_sicario, 8, 'Villeneuve domina la tensión sin necesidad de efectismo.'),
	(@u_laura, @mv_ytumama, 9, 'Cuarón captura México con una honestidad que pocas veces se ve.'),
	(@u_minjun, @mv_snow, 9, 'Alegoría de clases afilada. Bong ya mostraba aquí lo que haría en Parasite.'),
	(@u_minjun, @mv_okja, 8, 'Emotiva y provocadora. Bong usa el género de aventura para criticar el capitalismo.'),
	(@u_minjun, @mv_tenet, 7, 'Ambiciosa pero la mecánica temporal termina sofocando la narrativa.'),
	(@u_jiwoo, @mv_dune2, 10, 'Supera a la primera. Villeneuve consolida su mejor obra hasta la fecha.'),
	(@u_jiwoo, @mv_whip, 10, 'La batería final es una de las mejores secuencias de los últimos 20 años.'),
	(@u_jiwoo, @mv_oppen, 9, 'La trinidad del tiempo no lineal funciona perfectamente aquí.'),
	(@u_sofia, @mv_inception, 9, 'Nolan construye un laberinto del que no quieres salir.'),
	(@u_sofia, @mv_parasite, 10, 'Perfecta en ritmo, crítica y ejecución.'),
	(@u_sofia, @mv_oppen, 9, 'Densa pero absolutamente necesaria.'),
	(@u_james, @mv_parasite, 10, 'Orgullo coreano absoluto.'),
	(@u_james, @mv_dune2, 9, 'Épica visual sin igual en el cine reciente.'),
	(@u_james, @mv_snow, 8, 'Bong adelantó en 2013 todo lo que diría en Parasite.'),
	(@u_marie, @mv_portrait, 10, 'Sciamma redefine el cine romántico.'),
	(@u_marie, @mv_barbie, 8, 'Más profunda de lo que aparenta. Gerwig sorprende.'),
	(@u_marie, @mv_roma, 9, 'Una carta de amor al cine y a la memoria.');

/* Recovery of IDs of reviews to update */
SET @rv_carlos_inception = (SELECT id FROM review WHERE user_id = @u_carlos AND movie_id = @mv_inception);
SET @rv_laura_roma = (SELECT id FROM review WHERE user_id = @u_laura  AND movie_id = @mv_roma);
SET @rv_minjun_dune = (SELECT id FROM review WHERE user_id = @u_minjun AND movie_id = @mv_dune);

/* Call to the sp_update_review stored procedure */
CALL sp_update_review(@rv_carlos_inception, @u_carlos, 10,
    'Actualización: narrativa perfecta en todos los sentidos. El trompo sigue girando.');
CALL sp_update_review(@rv_laura_roma, @u_laura, 10,
    'Actualización: con el tiempo entiendo que es una obra maestra absoluta.');
CALL sp_update_review(@rv_minjun_dune, @u_minjun, 9,
    'Actualización: la segunda parte me convenció de subir la calificación.');

/* Recovery of IDs of watchlist entries to update */
SET @wl_carlos_barbie = (SELECT id FROM watchlist WHERE user_id = @u_carlos AND movie_id = @mv_barbie);
SET @wl_laura_dune = (SELECT id FROM watchlist WHERE user_id = @u_laura  AND movie_id = @mv_dune);
SET @wl_minjun_barbie = (SELECT id FROM watchlist WHERE user_id = @u_minjun AND movie_id = @mv_barbie);

/* Call to the sp_update_watchlist_status stored procedure */
CALL sp_update_watchlist_status(@wl_carlos_barbie, @u_carlos, @ws_done);
CALL sp_update_watchlist_status(@wl_laura_dune, @u_laura, @ws_done);
CALL sp_update_watchlist_status(@wl_minjun_barbie, @u_minjun, @ws_wtch);

/* Recovery of IDs of reviews to delete */
SET @rv_jiwoo_eeaao = (SELECT id FROM review WHERE user_id = @u_jiwoo AND movie_id = @mv_eeaao);
SET @rv_laura_blade = (SELECT id FROM review WHERE user_id = @u_laura AND movie_id = @mv_blade);
SET @rv_minjun_stellar = (SELECT id FROM review WHERE user_id = @u_minjun AND movie_id = @mv_stellar);

/* Call to the sp_delete_review stored procedure */
CALL sp_delete_review(@rv_jiwoo_eeaao, @u_jiwoo, 'USER');
CALL sp_delete_review(@rv_laura_blade, @u_laura, 'USER');
CALL sp_delete_review(@rv_minjun_stellar, @u_admin, 'ADMIN');

/* Call to the sp_get_movie_detail stored procedure */
CALL sp_get_movie_detail(@mv_parasite);
CALL sp_get_movie_detail(@mv_inception);

/* Call to the sp_get_user_watchlist stored procedure */
CALL sp_get_user_watchlist(@u_carlos);
CALL sp_get_user_watchlist(@u_laura);
CALL sp_get_user_watchlist(@u_minjun);
CALL sp_get_user_watchlist(@u_jiwoo);

/* View queries */
SELECT * FROM v_movie_ranking;
SELECT * FROM v_genre_popularity;
SELECT * FROM v_watchlist_popularity;
SELECT * FROM v_user_activity;
SELECT * FROM v_genre_by_user_preference;
SELECT * FROM v_country_performance;
SELECT * FROM v_streaming_reach;