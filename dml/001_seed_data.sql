/* Insertion of values into the country table */
SET @co = UUID(); 
SET @us = UUID(); 
SET @kr = UUID();
SET @uk = UUID(); 
SET @fr = UUID(); 
SET @mx = UUID();
SET @ca = UUID(); 
SET @jp = UUID(); 
SET @de = UUID();
INSERT INTO 
    country (id, name) 
VALUES
	(@co, 'Colombia'),
	(@us, 'United States'),
	(@kr, 'South Korea'),
	(@uk, 'United Kingdom'),
	(@fr, 'France'),
	(@mx, 'Mexico'),
	(@ca, 'Canada'),
	(@jp, 'Japan'),
	(@de, 'Germany');

/* Insertion of values into the genre table */
SET @g_scifi = UUID(); 
SET @g_drama = UUID(); 
SET @g_thriller = UUID();
SET @g_horror = UUID(); 
SET @g_comedy = UUID(); 
SET @g_action = UUID();
SET @g_anim = UUID(); 
SET @g_doc = UUID(); 
SET @g_romance = UUID();
SET @g_bio = UUID();
INSERT INTO
    genre (id, name) 
VALUES
	(@g_scifi, 'Science Fiction'),
	(@g_drama, 'Drama'),
	(@g_thriller, 'Thriller'),
	(@g_horror, 'Horror'),
	(@g_comedy, 'Comedy'),
	(@g_action, 'Action'),
	(@g_anim, 'Animation'),
	(@g_doc, 'Documentary'),
	(@g_romance, 'Romance'),
	(@g_bio, 'Biography');

/* Insertion of values into the award_category table */
SET @ac_film = UUID(); 
SET @ac_dir = UUID(); 
SET @ac_actor = UUID();
SET @ac_act = UUID(); 
SET @ac_scrpt = UUID(); 
SET @ac_photo = UUID();
SET @ac_intl = UUID();
INSERT INTO 
    award_category (id, name) 
VALUES
	(@ac_film, 'Best Picture'),
	(@ac_dir, 'Best Director'),
	(@ac_actor, 'Best Actor'),
	(@ac_act, 'Best Actress'),
	(@ac_scrpt, 'Best Original Screenplay'),
	(@ac_photo, 'Best Cinematography'),
	(@ac_intl, 'Best International Feature');

/* Insertion of values into the directing_style table */
SET @ds_epic = UUID(); 
SET @ds_neo = UUID(); 
SET @ds_psych = UUID();
SET @ds_social = UUID(); 
SET @ds_sci = UUID(); 
SET @ds_dark = UUID();
INSERT INTO 
    directing_style (id, name) 
VALUES
	(@ds_epic, 'Epic Cinema'),
	(@ds_neo, 'Neorealism'),
	(@ds_psych, 'Psychological Thriller'),
	(@ds_social, 'Social Drama'),
	(@ds_sci, 'Conceptual Science Fiction'),
	(@ds_dark, 'Dark Comedy');

/* Insertion of values into the acting_method table */
SET @am_stan = UUID(); 
SET @am_meis = UUID(); 
SET @am_brec = UUID();
INSERT INTO 
    acting_method (id, name) 
VALUES
	(@am_stan, 'Stanislavski Method'),
	(@am_meis, 'Meisner Technique'),
	(@am_brec, 'Brechtian Epic Theatre');

/* Insertion of values into the user_role table */
SET @r_admin = UUID(); 
SET @r_user = UUID();
INSERT INTO 
    user_role (id, name) 
VALUES
	(@r_admin, 'ADMIN'),
	(@r_user, 'USER');

/* Insertion of values into the subscription_type table */
SET @st_sub = UUID(); 
SET @st_rent = UUID();
SET @st_free = UUID(); 
SET @st_buy = UUID();
INSERT INTO 
    subscription_type (id, name) 
VALUES
	(@st_sub, 'SUBSCRIPTION'),
	(@st_rent, 'RENT'),
	(@st_free, 'FREE'),
	(@st_buy, 'PURCHASE');

/* Insertion of values into the classification table */
SET @cl_g = UUID(); 
SET @cl_pg = UUID(); 
SET @cl_pg13 = UUID();
SET @cl_r = UUID(); 
SET @cl_nc17 = UUID();
INSERT INTO 
    classification (id, classification_system, name, description, min_age) 
VALUES
	(@cl_g, 'MPAA', 'G', 'General audiences', 0),
	(@cl_pg, 'MPAA', 'PG', 'Parental guidance suggested', 8),
	(@cl_pg13, 'MPAA', 'PG-13', 'Inappropriate for children under 13', 13),
	(@cl_r, 'MPAA', 'R', 'Requires accompanying adult for under 17', 17),
	(@cl_nc17, 'MPAA', 'NC-17', 'Adults only', 18);

/* Insertion of values into the company_role table */
SET @cr_prod = UUID(); 
SET @cr_dist = UUID();
SET @cr_co = UUID(); 
SET @cr_exec = UUID();
INSERT INTO 
    company_role (id, name) 
VALUES
	(@cr_prod, 'PRODUCER'),
	(@cr_dist, 'DISTRIBUTOR'),
	(@cr_co, 'CO_PRODUCER'),
	(@cr_exec, 'EXECUTIVE_PRODUCER');

/* Insertion of values into the director_role table */
SET @dr_dir = UUID(); 
SET @dr_codir = UUID(); 
SET @dr_2nd = UUID();
INSERT INTO 
    director_role (id, name) 
VALUES
	(@dr_dir, 'DIRECTOR'),
	(@dr_codir, 'CO_DIRECTOR'),
	(@dr_2nd, 'SECOND_UNIT_DIRECTOR');

/* Insertion of values into the status_watchlist table */
SET @ws_pend = UUID(); 
SET @ws_wtch = UUID();
SET @ws_done = UUID(); 
SET @ws_drop = UUID();
INSERT INTO 
    status_watchlist (id, name) 
VALUES
	(@ws_pend, 'PENDING'),
	(@ws_wtch, 'WATCHING'),
	(@ws_done, 'WATCHED'),
	(@ws_drop, 'DROPPED');

/* Insertion of values into the award table */
SET @aw_oscar = UUID(); 
SET @aw_bafta = UUID();
SET @aw_cannes = UUID(); 
SET @aw_fcc = UUID();
INSERT INTO 
    award (id, name, country_id, founded_year) 
VALUES
	(@aw_oscar, 'Academy Awards', @us, 1929),
	(@aw_bafta, 'BAFTA', @uk, 1947),
	(@aw_cannes, 'Cannes Film Festival', @fr, 1946),
	(@aw_fcc, 'Cartagena Film Festival', @co, 1960);

/* Insertion of values into the production_company table */
SET @pc_wb = UUID(); 
SET @pc_a24 = UUID(); 
SET @pc_cj = UUID();
SET @pc_legend = UUID(); 
SET @pc_nflx = UUID(); 
SET @pc_neon = UUID();
SET @pc_param = UUID(); 
SET @pc_focus = UUID();
INSERT INTO 
    production_company (id, name, country_id, founded_year) 
VALUES
	(@pc_wb, 'Warner Bros. Pictures', @us, 1923),
	(@pc_a24, 'A24', @us, 2012),
	(@pc_cj, 'CJ ENM', @kr, 1995),
	(@pc_legend, 'Legendary Pictures', @us, 2000),
	(@pc_nflx, 'Netflix Studios', @us, 2005),
	(@pc_neon, 'NEON', @us, 2017),
	(@pc_param, 'Paramount Pictures', @us, 1912),
	(@pc_focus, 'Focus Features', @us, 2002);

/* Insertion of values into the streaming_platform table */
SET @sp_nflx = UUID(); 
SET @sp_hbo = UUID();
SET @sp_amazon = UUID(); 
SET @sp_mubi = UUID();
INSERT INTO 
    streaming_platform (id, name, country_id, subscription_type_id) 
VALUES
	(@sp_nflx, 'Netflix', @us, @st_sub),
	(@sp_hbo, 'HBO Max', @us, @st_sub),
	(@sp_amazon, 'Amazon Prime Video', @us, @st_sub),
	(@sp_mubi, 'Mubi', @uk, @st_sub);

/* Insertion of values into the person table */
SET @p_nolan = UUID(); 
SET @p_bong = UUID(); 
SET @p_vil = UUID();
SET @p_gerwig = UUID(); 
SET @p_cuaron = UUID(); 
SET @p_inarr = UUID();
SET @p_jenkins = UUID(); 
SET @p_sciamma = UUID(); 
SET @p_guerra = UUID();
SET @p_dan_k = UUID(); 
SET @p_chazelle = UUID(); 
SET @p_mendes = UUID();
SET @p_dicap = UUID(); 
SET @p_kangho = UUID(); 
SET @p_chalm = UUID();
SET @p_cotil = UUID(); 
SET @p_sodam = UUID(); 
SET @p_ali = UUID();
SET @p_hardy = UUID(); 
SET @p_adams = UUID(); 
SET @p_zend = UUID();
SET @p_gosling = UUID(); 
SET @p_murphy = UUID(); 
SET @p_yeoh = UUID();
INSERT INTO 
    person (id, name, last_name, birth_date, country_id) 
VALUES
	(@p_nolan, 'Christopher', 'Nolan', '1970-07-30', @uk),
	(@p_bong, 'Bong', 'Joon-ho', '1969-09-14', @kr),
	(@p_vil, 'Denis', 'Villeneuve', '1967-10-03', @ca),
	(@p_gerwig, 'Greta', 'Gerwig', '1983-08-04', @us),
	(@p_cuaron, 'Alfonso', 'Cuarón', '1961-11-28', @mx),
	(@p_inarr, 'Alejandro', 'Iñárritu', '1963-08-15', @mx),
	(@p_jenkins, 'Barry', 'Jenkins', '1979-11-19', @us),
	(@p_sciamma, 'Céline', 'Sciamma', '1978-11-12', @fr),
	(@p_guerra, 'Ciro', 'Guerra', '1981-02-06', @co),
	(@p_dan_k, 'Daniel', 'Kwan', '1988-02-14', @us),
	(@p_chazelle, 'Damien', 'Chazelle', '1985-01-19', @us),
	(@p_mendes, 'Sam', 'Mendes', '1965-08-01', @uk),
	(@p_dicap, 'Leonardo', 'DiCaprio', '1974-11-11', @us),
	(@p_kangho, 'Song', 'Kang-ho', '1967-01-17', @kr),
	(@p_chalm, 'Timothée', 'Chalamet', '1995-12-27', @us),
	(@p_cotil, 'Marion', 'Cotillard', '1975-09-30', @fr),
	(@p_sodam, 'Park', 'So-dam', '1991-09-08', @kr),
	(@p_ali, 'Mahershala', 'Ali', '1974-02-16', @us),
	(@p_hardy, 'Tom', 'Hardy', '1977-09-15', @uk),
	(@p_adams, 'Amy', 'Adams', '1974-08-20', @us),
	(@p_zend, 'Zendaya', 'Coleman', '1996-09-01', @us),
	(@p_gosling, 'Ryan', 'Gosling', '1980-11-12', @ca),
	(@p_murphy, 'Cillian', 'Murphy', '1976-05-25', @uk),
	(@p_yeoh, 'Michelle', 'Yeoh', '1962-08-06', @us);

/* Insertion of values into the director table */
INSERT INTO 
    director (id, directing_style_id) 
VALUES
	(@p_nolan, @ds_epic),
	(@p_bong, @ds_social),
	(@p_vil, @ds_sci),
	(@p_gerwig, @ds_neo),
	(@p_cuaron, @ds_social),
	(@p_inarr, @ds_psych),
	(@p_jenkins, @ds_neo),
	(@p_sciamma, @ds_neo),
	(@p_guerra, @ds_neo),
	(@p_dan_k, @ds_dark),
	(@p_chazelle, @ds_neo),
	(@p_mendes, @ds_epic);

/* Insertion of values into the actor table */
INSERT INTO 
    actor (id, acting_method_id) 
VALUES
	(@p_dicap, @am_stan),
	(@p_kangho, @am_meis),
	(@p_chalm, @am_stan),
	(@p_cotil, @am_meis),
	(@p_sodam, @am_stan),
	(@p_ali, @am_meis),
	(@p_hardy, @am_stan),
	(@p_adams, @am_stan),
	(@p_zend, @am_meis),
	(@p_gosling, @am_meis),
	(@p_murphy, @am_stan),
	(@p_yeoh, @am_meis);

/* Insertion of values into the app_user table */
SET @u_admin = UUID(); 
SET @u_carlos = UUID(); 
SET @u_laura = UUID();
SET @u_minjun = UUID(); 
SET @u_jiwoo = UUID();
INSERT INTO 
    app_user (id, role_id, name, last_name, country_id, birth_date, email, password_hash) 
VALUES
	(@u_admin, @r_admin, 'Admin', 'System', @co, '1990-01-01', 'admin@cinereview.com','$2a$12$KIXkJ8Q1HgZ5mN3tWvP0XOdY7RjA4sLbCuFqEwMnTzGpHyVxIaD2'),
	(@u_carlos, @r_user, 'Carlos', 'Rodríguez', @co, '1995-03-15', 'carlos.rodriguez@email.com', '$2a$12$AbCdEfGhIjKlMnOpQrStUvWxYz01234567890AbCdEfGhIjKlMnOp'),
	(@u_laura, @r_user, 'Laura', 'Martínez', @mx, '1998-07-22', 'laura.martinez@email.com', '$2a$12$ZyXwVuTsRqPoNmLkJiHgFeDcBa9876543210ZyXwVuTsRqPoNmLk'),
	(@u_minjun, @r_user, 'Min-jun', 'Lee', @kr, '2000-11-05', 'minjun.lee@email.com', '$2a$12$1A2B3C4D5E6F7G8H9I0JkLmNoPqRsTuVwXyZaAbBcCdDeEfFgGhH'),
	(@u_jiwoo,  @r_user, 'Ji-woo', 'Kim', @kr, '2002-04-20', 'jiwoo.kim@email.com', '$2a$12$MnOpQrStUvWxYz0123456789AbCdEfGhIjKlMnOpQrStUvWxYzAb');

/* Insertion of values into the movie table */
SET @mv_inception = UUID(); 
SET @mv_parasite = UUID();
SET @mv_stellar = UUID(); 
SET @mv_dune = UUID();
SET @mv_roma = UUID(); 
SET @mv_barbie = UUID();
SET @mv_abrazo = UUID(); 
SET @mv_knight = UUID();
SET @mv_arrival = UUID(); 
SET @mv_moonlight = UUID();
SET @mv_blade = UUID(); 
SET @mv_eeaao = UUID();
INSERT INTO 
    movie (id, country_id, classification_id, title, release_year, synopsis, tmdb_id) 
VALUES
	(@mv_inception, @uk, @cl_pg13, 'Inception', 2010, 'A thief steals corporate secrets through shared-dream technology and attempts to plant an idea instead.', 27205),
	(@mv_parasite, @kr, @cl_r, 'Parasite', 2019, 'The Kim family infiltrates the lives of the wealthy Park family, with unforeseeable consequences.', 496243),
	(@mv_stellar, @uk, @cl_pg13, 'Interstellar', 2014, 'A team of astronauts travels through a wormhole in search of a new home for humanity.', 157336),
	(@mv_dune, @us, @cl_pg13, 'Dune: Part One', 2021, 'Paul Atreides leads the tribes of the planet Arrakis in a war to avenge his family.', 438631),
	(@mv_roma, @mx, @cl_r, 'Roma', 2018, 'A live-in housekeeper faces upheaval within a middle-class family in 1970s Mexico.', 508442),
	(@mv_barbie, @us, @cl_pg13, 'Barbie', 2023, 'Barbie and Ken travel from Barbieland to the real world, triggering an existential crisis.', 346698),
	(@mv_abrazo, @co, @cl_r, 'Embrace of the Serpent', 2015, 'Two scientific expeditions through the Colombian Amazon, told from an Indigenous perspective.', NULL),
	(@mv_knight, @uk, @cl_pg13, 'The Dark Knight', 2008, 'Batman faces the Joker, a criminal who challenges Gotham with a plan of absolute chaos.', 155),
	(@mv_arrival, @ca, @cl_pg13, 'Arrival', 2016, 'A linguist is recruited to communicate with extraterrestrials who have landed on Earth.', 329865),
	(@mv_moonlight, @us, @cl_r, 'Moonlight', 2016, 'A young Black man explores his identity and sexuality across three stages of his life.', 376867),
	(@mv_blade, @us, @cl_r, 'Blade Runner 2049', 2017, 'A blade runner uncovers a secret that could plunge humanity into chaos.', 335984),
	(@mv_eeaao, @us, @cl_r, 'Everything Everywhere All at Once', 2022, 'A laundromat owner is pulled into an interdimensional adventure to save the multiverse.', 545611);

/* Insertion of values into the movie_director table */
INSERT INTO 
    movie_director (movie_id, director_id, role_id) 
VALUES
	(@mv_inception, @p_nolan, @dr_dir),
	(@mv_parasite, @p_bong, @dr_dir),
	(@mv_stellar, @p_nolan, @dr_dir),
	(@mv_dune, @p_vil, @dr_dir),
	(@mv_roma, @p_cuaron, @dr_dir),
	(@mv_barbie, @p_gerwig, @dr_dir),
	(@mv_abrazo, @p_guerra, @dr_dir),
	(@mv_knight, @p_nolan, @dr_dir),
	(@mv_arrival, @p_vil, @dr_dir),
	(@mv_moonlight, @p_jenkins, @dr_dir),
	(@mv_blade, @p_vil, @dr_dir),
	(@mv_eeaao, @p_dan_k, @dr_dir);

/* Insertion of values into the movie_genre table */
INSERT INTO 
    movie_genre (movie_id, genre_id) 
VALUES
	(@mv_inception, @g_scifi), (@mv_inception, @g_action), (@mv_inception, @g_thriller),
	(@mv_parasite, @g_drama), (@mv_parasite, @g_thriller), (@mv_parasite, @g_comedy),
	(@mv_stellar, @g_scifi), (@mv_stellar, @g_drama),
	(@mv_dune, @g_scifi), (@mv_dune, @g_action),
	(@mv_roma, @g_drama), (@mv_roma, @g_doc),
	(@mv_barbie, @g_comedy), (@mv_barbie, @g_drama),
	(@mv_abrazo, @g_drama), (@mv_abrazo, @g_doc),
	(@mv_knight, @g_action), (@mv_knight, @g_thriller),
	(@mv_arrival, @g_scifi), (@mv_arrival, @g_drama), (@mv_arrival, @g_thriller),
	(@mv_moonlight, @g_drama),
	(@mv_blade, @g_scifi), (@mv_blade, @g_thriller),
	(@mv_eeaao, @g_scifi), (@mv_eeaao, @g_action), (@mv_eeaao, @g_comedy);

/* Insertion of values into the movie_actor table */
INSERT INTO 
    movie_actor (movie_id, actor_id, character_name, is_lead) 
VALUES
	(@mv_inception, @p_dicap, 'Dom Cobb', TRUE),
	(@mv_inception, @p_cotil, 'Mal Cobb', FALSE),
	(@mv_inception, @p_hardy, 'Eames', FALSE),
	(@mv_parasite, @p_kangho, 'Ki-taek', TRUE),
	(@mv_parasite, @p_sodam, 'Ki-jung', FALSE),
	(@mv_dune, @p_chalm, 'Paul Atreides', TRUE),
	(@mv_dune, @p_zend, 'Chani', FALSE),
	(@mv_moonlight, @p_ali, 'Juan', TRUE),
	(@mv_blade, @p_gosling, 'K / Joe', TRUE),
	(@mv_arrival, @p_adams, 'Louise Banks', TRUE),
	(@mv_eeaao, @p_yeoh, 'Evelyn Wang', TRUE),
	(@mv_knight, @p_murphy, 'Jonathan Crane', FALSE);

/* Insertion of values into the movie_company table */
INSERT INTO 
    movie_company (movie_id, company_id, role_id) 
VALUES
	(@mv_inception, @pc_wb, @cr_prod),
	(@mv_inception, @pc_legend, @cr_co),
	(@mv_parasite, @pc_cj, @cr_prod),
	(@mv_stellar, @pc_wb, @cr_prod),
	(@mv_stellar, @pc_legend, @cr_co),
	(@mv_dune, @pc_wb, @cr_prod),
	(@mv_dune, @pc_legend, @cr_co),
	(@mv_roma, @pc_nflx, @cr_prod),
	(@mv_barbie, @pc_wb, @cr_prod),
	(@mv_knight, @pc_wb, @cr_prod),
	(@mv_knight, @pc_legend, @cr_co),
	(@mv_arrival, @pc_param, @cr_prod),
	(@mv_moonlight, @pc_a24, @cr_prod),
	(@mv_blade, @pc_wb, @cr_prod),
	(@mv_eeaao, @pc_a24, @cr_prod);

/* Insertion of values into the movie_platform table */
INSERT INTO 
    movie_platform (movie_id, platform_id, available_since, available_until) 
VALUES
	(@mv_inception, @sp_hbo, '2021-01-01', NULL),
	(@mv_parasite, @sp_nflx, '2020-04-08', NULL),
	(@mv_stellar, @sp_amazon, '2020-01-01', '2023-12-31'),
	(@mv_stellar, @sp_nflx, '2024-01-01', NULL),
	(@mv_dune, @sp_hbo, '2021-10-22', NULL),
	(@mv_roma, @sp_nflx, '2018-12-14', NULL),
	(@mv_barbie, @sp_hbo, '2023-09-12', '2024-09-11'),
	(@mv_abrazo, @sp_mubi, '2022-03-01', NULL),
	(@mv_knight, @sp_hbo, '2020-06-01', NULL),
	(@mv_arrival, @sp_amazon, '2021-03-15', NULL),
	(@mv_moonlight, @sp_nflx,'2021-07-01', NULL),
	(@mv_blade, @sp_amazon, '2022-01-01', NULL),
	(@mv_eeaao, @sp_amazon, '2022-08-01', NULL);

/* Insertion of values into the review table */
INSERT INTO 
    review (user_id, movie_id, rating, body) 
VALUES
	(@u_carlos, @mv_inception, 9, 'A layered narrative built with surgical precision.'),
	(@u_carlos, @mv_stellar, 10,'The ocean planet scene is one of the most unsettling in modern cinema.'),
	(@u_carlos, @mv_parasite, 10, 'Masterful in every aspect. Bong Joon-ho at his absolute best.'),
	(@u_carlos, @mv_knight, 10, 'Heath Ledger redefines what a villain can be.'),
	(@u_carlos, @mv_arrival, 9, 'The final twist recontextualizes the entire film.'),
	(@u_carlos, @mv_moonlight, 9, 'Visual poetry. Jenkins turns the intimate into the universal.'),
	(@u_carlos, @mv_roma, 10, 'Cuarón elevates the everyday into the transcendent.'),
	(@u_carlos, @mv_eeaao, 8, 'Chaotic and beautiful all at once. A triumph of independent cinema.'),
	(@u_laura, @mv_parasite, 9, 'Social critique wrapped in a razor-precise thriller.'),
	(@u_laura, @mv_inception, 8, 'Visually stunning, though the ending raises more questions than it answers.'),
	(@u_laura, @mv_roma, 9, 'Deeply human. One of the best films to come out of Latin American cinema.'),
	(@u_laura, @mv_dune, 8, 'A spectacular visual epic, though it plays more like a prologue.'),
	(@u_laura,  @mv_blade, 7, 'Atmospheric and gorgeous, but the pacing can test your patience.'),
	(@u_minjun, @mv_parasite, 10, 'A perfect film. A point of pride for Korean cinema.'),
	(@u_minjun, @mv_stellar, 9, 'Scientifically rigorous and emotionally devastating.'),
	(@u_minjun, @mv_dune, 8, 'Stunning visual scale. Part two promised even more.'),
	(@u_minjun, @mv_moonlight, 10, 'One of the most important films of the last decade.'),
	(@u_jiwoo,  @mv_arrival, 10, 'Language is the key to time itself. Brilliant.'),
	(@u_jiwoo,  @mv_eeaao, 9, 'Absurd, emotional, and profound. Completely unlike anything else.');

/* Insertion of values into the watchlist table */
INSERT INTO 
    watchlist (user_id, movie_id, status_id) 
VALUES
	(@u_carlos, @mv_roma, @ws_done),
	(@u_carlos, @mv_barbie, @ws_pend),
	(@u_carlos, @mv_abrazo, @ws_pend),
	(@u_laura, @mv_dune, @ws_wtch),
	(@u_laura, @mv_abrazo, @ws_pend),
	(@u_laura, @mv_knight, @ws_done),
	(@u_minjun, @mv_barbie, @ws_pend),
	(@u_minjun, @mv_blade, @ws_done),
	(@u_jiwoo, @mv_inception, @ws_done),
	(@u_jiwoo, @mv_parasite,  @ws_done);

/* Insertion of values into the movie_award table */
INSERT INTO 
    movie_award (movie_id, award_id, category_id, year, won) 
VALUES
	(@mv_parasite, @aw_oscar, @ac_film, 2020, TRUE),
	(@mv_parasite, @aw_oscar, @ac_dir, 2020, TRUE),
	(@mv_parasite, @aw_oscar, @ac_intl, 2020, TRUE),
	(@mv_parasite, @aw_cannes, @ac_film, 2019, TRUE),
	(@mv_inception, @aw_oscar, @ac_film, 2011, FALSE),
	(@mv_inception, @aw_oscar, @ac_photo, 2011, TRUE),
	(@mv_roma, @aw_oscar, @ac_dir, 2019, TRUE),
	(@mv_roma, @aw_oscar, @ac_intl, 2019, TRUE),
	(@mv_dune, @aw_oscar, @ac_photo, 2022, TRUE),
	(@mv_knight, @aw_bafta, @ac_film, 2009, FALSE),
	(@mv_moonlight, @aw_oscar, @ac_film, 2017, TRUE),
	(@mv_moonlight, @aw_oscar, @ac_scrpt, 2017, FALSE),
	(@mv_eeaao, @aw_oscar, @ac_film, 2023, TRUE),
	(@mv_eeaao, @aw_oscar, @ac_dir, 2023, TRUE),
	(@mv_arrival, @aw_oscar, @ac_film, 2017, FALSE),
	(@mv_arrival, @aw_oscar, @ac_dir, 2017, FALSE);

/* Insertion of values into the person_award table */
INSERT INTO 
    person_award (person_id, award_id, category_id, year, won) 
VALUES
	(@p_bong, @aw_oscar, @ac_dir, 2020, TRUE),
	(@p_cuaron, @aw_oscar, @ac_dir, 2019, TRUE),	
	(@p_jenkins, @aw_oscar, @ac_scrpt, 2017, TRUE),
	(@p_dicap, @aw_oscar, @ac_actor, 2016, TRUE),
	(@p_cotil, @aw_oscar, @ac_act, 2008, TRUE),
	(@p_ali, @aw_oscar, @ac_actor, 2017, TRUE),
	(@p_dan_k, @aw_oscar, @ac_dir, 2023, TRUE),
	(@p_yeoh, @aw_oscar, @ac_act, 2023, TRUE);