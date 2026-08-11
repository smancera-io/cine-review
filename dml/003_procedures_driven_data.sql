/*
*	Additional demo data inserted through the stored procedures (see 002_stored_procedures.sql), rather than direct INSERT.
*	Exercises all 8 procedures with realistic calls: creates new movies, people, and users. Besides, it gives that new content activity (watchlist, platform availability, 
*	reviews) alongside existing users and existing movies. On the other hand, exercises the update/delete procedures against baseline data from 001_seed_data.sql, this file
*	runs the two read-only procedures last.
*
*	Mixes CALL with direct INSERT because there is no sp_insert_review or sp_insert_watchlist among the 8 procedures. Those tables can only be populated by hand, 
*	procedures or not.
*	Run after 001_seed_data.sql. The SET block below re-establishes, via SELECT lookups, the 51 variables this file needs from that baseline data. Seeing 001_seed_data.sql 
*	for what each one is.
*
*	None of these procedures use OUT parameters, each returns its result as a SELECT result set instead. A plain SQL script can't capture a result set into a variable, 
*	so after each CALL that creates a new row, this file re-queries that row's id by tmdb_id/email for the brand-new rows just created here, or by the (user_id, movie_id) 
*	unique constraint for existing review/watchlist rows this file didn't create itself.
*/

/* 
*	Variables inherited from 001_seed_data.sql 
*	Get inherited county ids
*/
SET @co = (SELECT id FROM country WHERE name = 'Colombia');
SET @mx = (SELECT id FROM country WHERE name = 'Mexico');
SET @kr = (SELECT id FROM country WHERE name = 'South Korea');
SET @fr = (SELECT id FROM country WHERE name = 'France');
SET @uk = (SELECT id FROM country WHERE name = 'United Kingdom');
SET @us = (SELECT id FROM country WHERE name = 'United States');
/* 
*	Get inherited genre ids
*/
SET @g_action = (SELECT id FROM genre WHERE name = 'Action');
SET @g_bio = (SELECT id FROM genre WHERE name = 'Biography');
SET @g_comedy = (SELECT id FROM genre WHERE name = 'Comedy');
SET @g_drama = (SELECT id FROM genre WHERE name = 'Drama');
SET @g_romance = (SELECT id FROM genre WHERE name = 'Romance');
SET @g_scifi = (SELECT id FROM genre WHERE name = 'Science Fiction');
SET @g_thriller = (SELECT id FROM genre WHERE name = 'Thriller');
/*
*	Get inherited classification ids
*/
SET @cl_nc17 = (SELECT id FROM classification WHERE classification_system = 'MPAA' AND name = 'NC-17');
SET @cl_pg13 = (SELECT id FROM classification WHERE classification_system = 'MPAA' AND name = 'PG-13');
SET @cl_r = (SELECT id FROM classification WHERE classification_system = 'MPAA' AND name = 'R');
/*
*	Get inherited style ids 
*/
SET @am_meis = (SELECT id FROM acting_method WHERE name = 'Meisner Technique');
SET @am_stan = (SELECT id FROM acting_method WHERE name = 'Stanislavski Method');
SET @ds_psych = (SELECT id FROM directing_style WHERE name = 'Psychological Thriller');
SET @dr_dir = (SELECT id FROM director_role WHERE name = 'DIRECTOR');
/*
*	Get inherited role id 
*/
SET @r_user = (SELECT id FROM user_role WHERE name = 'USER');
/*
*	Get inherited streaming platform ids
*/
SET @sp_amazon = (SELECT id FROM streaming_platform WHERE name = 'Amazon Prime Video');
SET @sp_hbo = (SELECT id FROM streaming_platform WHERE name = 'HBO Max');
SET @sp_mubi = (SELECT id FROM streaming_platform WHERE name = 'Mubi');
SET @sp_nflx = (SELECT id FROM streaming_platform WHERE name = 'Netflix');
/*
*	Get inherited status watchlist ids
*/
SET @ws_done = (SELECT id FROM status_watchlist WHERE name = 'WATCHED');
SET @ws_drop = (SELECT id FROM status_watchlist WHERE name = 'DROPPED');
SET @ws_pend = (SELECT id FROM status_watchlist WHERE name = 'PENDING');
SET @ws_wtch = (SELECT id FROM status_watchlist WHERE name = 'WATCHING');
/*
*	Get inherited movie ids
*/
SET @mv_arrival = (SELECT id FROM movie WHERE title = 'Arrival');
SET @mv_barbie = (SELECT id FROM movie WHERE title = 'Barbie');
SET @mv_blade = (SELECT id FROM movie WHERE title = 'Blade Runner 2049');
SET @mv_dune = (SELECT id FROM movie WHERE title = 'Dune: Part One');
SET @mv_eeaao = (SELECT id FROM movie WHERE title = 'Everything Everywhere All at Once');
SET @mv_inception = (SELECT id FROM movie WHERE title = 'Inception');
SET @mv_moonlight = (SELECT id FROM movie WHERE title = 'Moonlight');
SET @mv_parasite = (SELECT id FROM movie WHERE title = 'Parasite');
SET @mv_roma = (SELECT id FROM movie WHERE title = 'Roma');
SET @mv_stellar = (SELECT id FROM movie WHERE title = 'Interstellar');
/*
*	Get inherited person ids
*/
SET @p_bong = (SELECT id FROM person WHERE name = 'Bong' AND last_name = 'Joon-ho');
SET @p_chazelle = (SELECT id FROM person WHERE name = 'Damien' AND last_name = 'Chazelle');
SET @p_cuaron = (SELECT id FROM person WHERE name = 'Alfonso' AND last_name = 'Cuarón');
SET @p_mendes = (SELECT id FROM person WHERE name = 'Sam' AND last_name = 'Mendes');
SET @p_nolan = (SELECT id FROM person WHERE name = 'Christopher' AND last_name = 'Nolan');
SET @p_sciamma = (SELECT id FROM person WHERE name = 'Céline' AND last_name = 'Sciamma');
SET @p_vil = (SELECT id FROM person WHERE name = 'Denis' AND last_name = 'Villeneuve');
/*
*	Get inherited app user ids
*/
SET @u_admin = (SELECT id FROM app_user WHERE email = 'admin@cinereview.com');
SET @u_carlos = (SELECT id FROM app_user WHERE email = 'carlos.rodriguez@email.com');
SET @u_jiwoo = (SELECT id FROM app_user WHERE email = 'jiwoo.kim@email.com');
SET @u_laura = (SELECT id FROM app_user WHERE email = 'laura.martinez@email.com');
SET @u_minjun = (SELECT id FROM app_user WHERE email = 'minjun.lee@email.com');

/*
*	Create new catalog content: New movies, new industry people (a director and two actors), and new app users, created via CALL rather than direct INSERT so this
*	file also exercises sp_insert_movie, sp_insert_person, and sp_register_user against real arguments, not just empty schemas.
*/
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
CALL sp_insert_person('Paul Thomas', 'Anderson', '1970-06-26', @us, 'DIRECTOR', @ds_psych);
CALL sp_insert_person('Florence', 'Pugh', '1996-01-03', @uk, 'ACTOR', @am_stan);
CALL sp_insert_person('Ke Huy', 'Quan', '1971-08-20', @us, 'ACTOR', @am_meis);
CALL sp_register_user('Sofía', 'González', 'sofia.gonzalez@email.com',
    '$2a$12$SoFiAhAsHeDpAsSwOrD1234567890AbCdEfGhIjKlMnOpQrStUv', @co, '1993-06-12', @r_user);
CALL sp_register_user('James', 'Park', 'james.park@email.com',
    '$2a$12$JaMeSpArKhAsHeDpAsS1234567890AbCdEfGhIjKlMnOpQrSt', @kr, '1997-09-30', @r_user);
CALL sp_register_user('Marie', 'Dupont', 'marie.dupont@email.com',
    '$2a$12$MaRiEdUpOnThAsHeDpAs1234567890AbCdEfGhIjKlMnOpQr', @fr, '2001-03-18', @r_user);

/*
*	Recovers the ids MySQL generated inside the 3 procedures above. Movies are looked up by tmdb_id (unique, and known ahead of time from the CALL arguments), while users 
*	are looked up by email.
*/
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

/*
*	Give the new content activity: Mixes new movies/users from section 1 with existing ones from 001_seed_data.sql in both directions, existing users reviewing
*	new movies (e.g. @u_carlos on @mv_oppen) and new users reviewing existing movies (e.g. @u_sofia on @mv_inception), so the new content is woven into the existing dataset, 
*	not left isolated. Direct INSERT: no sp_insert_watchlist exists.
*/
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

/* 
*	Direct INSERT: no sp_insert_platform_availability exists either. 
*/
INSERT INTO movie_platform (movie_id, platform_id, available_since, available_until) VALUES
	(@mv_oppen, @sp_hbo, '2023-11-01', NULL),
	(@mv_tenet, @sp_hbo, '2021-01-01', NULL),
	(@mv_dune2, @sp_hbo, '2024-05-21', NULL),
	(@mv_portrait, @sp_mubi, '2020-06-01', NULL),
	(@mv_snow, @sp_nflx, '2020-01-01', NULL),
	(@mv_1917, @sp_amazon, '2020-04-01', NULL),
	(@mv_whip, @sp_nflx, '2020-01-01', NULL),
	(@mv_sicario, @sp_amazon, '2020-01-01', NULL);

/* 
*	Direct INSERT: no sp_insert_review exists: Reviews are only ever created this way; sp_update_review only edits ones that already exist, it doesn't create them. 
*/
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

/*
*	Exercise update/delete on existing data: Everything from here on operates on rows already seeded in 001_seed_data.sql, none of it touches the new content from
*	sections 1-2. This deliberately tests the write procedures against the original baseline dataset, as a separate concern from populating new catalog entries.
*	Review and watchlist rows have no single natural key column to look them up by (unlike movie.title or app_user.email) their identity comes from the UNIQUE(user_id, movie_id) 
*	constraint on each table, so that composite pair is what recovers their id here.
*/

SET @rv_carlos_inception = (SELECT id FROM review WHERE user_id = @u_carlos AND movie_id = @mv_inception);
SET @rv_laura_roma = (SELECT id FROM review WHERE user_id = @u_laura  AND movie_id = @mv_roma);
SET @rv_minjun_dune = (SELECT id FROM review WHERE user_id = @u_minjun AND movie_id = @mv_dune);
CALL sp_update_review(@rv_carlos_inception, @u_carlos, 10,
    'Actualización: narrativa perfecta en todos los sentidos. El trompo sigue girando.');
CALL sp_update_review(@rv_laura_roma, @u_laura, 10,
    'Actualización: con el tiempo entiendo que es una obra maestra absoluta.');
CALL sp_update_review(@rv_minjun_dune, @u_minjun, 9,
    'Actualización: la segunda parte me convenció de subir la calificación.');
SET @wl_carlos_barbie = (SELECT id FROM watchlist WHERE user_id = @u_carlos AND movie_id = @mv_barbie);
SET @wl_laura_dune = (SELECT id FROM watchlist WHERE user_id = @u_laura  AND movie_id = @mv_dune);
SET @wl_minjun_barbie = (SELECT id FROM watchlist WHERE user_id = @u_minjun AND movie_id = @mv_barbie);
CALL sp_update_watchlist_status(@wl_carlos_barbie, @u_carlos, @ws_done);
CALL sp_update_watchlist_status(@wl_laura_dune, @u_laura, @ws_done);
CALL sp_update_watchlist_status(@wl_minjun_barbie, @u_minjun, @ws_wtch);

/*
*	sp_delete_review's 3 calls deliberately cover both authorization branches: @u_jiwoo and @u_laura each delete their own review ('USER' role, self-delete), while 
*	@u_admin deletes @u_minjun's review under 'ADMIN' — the owner-or-admin rule would go untested if every call here were a self-delete.
*/

SET @rv_jiwoo_eeaao = (SELECT id FROM review WHERE user_id = @u_jiwoo AND movie_id = @mv_eeaao);
SET @rv_laura_blade = (SELECT id FROM review WHERE user_id = @u_laura AND movie_id = @mv_blade);
SET @rv_minjun_stellar = (SELECT id FROM review WHERE user_id = @u_minjun AND movie_id = @mv_stellar);
CALL sp_delete_review(@rv_jiwoo_eeaao, @u_jiwoo, 'USER');
CALL sp_delete_review(@rv_laura_blade, @u_laura, 'USER');
CALL sp_delete_review(@rv_minjun_stellar, @u_admin, 'ADMIN');

/*
*	Read-only calls: Run last so there's a full dataset (original + new content + post-update/delete state) behind them.
*/
CALL sp_get_movie_detail(@mv_parasite);
CALL sp_get_movie_detail(@mv_inception);
CALL sp_get_user_watchlist(@u_carlos);
CALL sp_get_user_watchlist(@u_laura);
CALL sp_get_user_watchlist(@u_minjun);
CALL sp_get_user_watchlist(@u_jiwoo);