/* Insertion of values into the country table */
SET @co = UUID(); SET @us = UUID(); SET @kr = UUID();
SET @uk = UUID(); SET @fr = UUID(); SET @mx = UUID();
SET @ca = UUID(); SET @jp = UUID(); SET @de = UUID();
INSERT INTO country (id, name) VALUES
	(@co, 'Colombia'),
	(@us, 'Estados Unidos'),
	(@kr, 'Corea del Sur'),
	(@uk, 'Reino Unido'),
	(@fr, 'Francia'),
	(@mx, 'México'),
	(@ca, 'Canadá'),
	(@jp, 'Japón'),
	(@de, 'Alemania');

/* Insertion of values into the genre table */
SET @g_scifi = UUID(); SET @g_drama = UUID(); SET @g_thriller = UUID();
SET @g_horror = UUID(); SET @g_comedy = UUID(); SET @g_action = UUID();
SET @g_anim = UUID(); SET @g_doc = UUID(); SET @g_romance = UUID();
SET @g_bio = UUID();
INSERT INTO genre (id, name) VALUES
	(@g_scifi, 'Ciencia Ficción'),
	(@g_drama, 'Drama'),
	(@g_thriller, 'Thriller'),
	(@g_horror, 'Terror'),
	(@g_comedy, 'Comedia'),
	(@g_action, 'Acción'),
	(@g_anim, 'Animación'),
	(@g_doc, 'Documental'),
	(@g_romance, 'Romance'),
	(@g_bio, 'Biográfico');

/* Insertion of values into the award_category table */
SET @ac_film = UUID(); SET @ac_dir = UUID(); SET @ac_actor = UUID();
SET @ac_act = UUID(); SET @ac_scrpt = UUID(); SET @ac_photo = UUID();
SET @ac_intl = UUID();
INSERT INTO award_category (id, name) VALUES
	(@ac_film, 'Mejor Película'),
	(@ac_dir, 'Mejor Director'),
	(@ac_actor, 'Mejor Actor Principal'),
	(@ac_act, 'Mejor Actriz Principal'),
	(@ac_scrpt, 'Mejor Guión Original'),
	(@ac_photo, 'Mejor Fotografía'),
	(@ac_intl, 'Mejor Película Internacional');

/* Insertion of values into the directing_style table */
SET @ds_epic = UUID(); SET @ds_neo = UUID(); SET @ds_psych = UUID();
SET @ds_social = UUID(); SET @ds_sci = UUID(); SET @ds_dark = UUID();
INSERT INTO directing_style (id, name) VALUES
	(@ds_epic, 'Cine Épico'),
	(@ds_neo, 'Neorrealismo'),
	(@ds_psych, 'Thriller Psicológico'),
	(@ds_social, 'Drama Social'),
	(@ds_sci, 'Ciencia Ficción Conceptual'),
	(@ds_dark, 'Comedia Oscura');

/* Insertion of values into the acting_method table */
SET @am_stan = UUID(); SET @am_meis = UUID(); SET @am_brec = UUID();
INSERT INTO acting_method (id, name) VALUES
	(@am_stan, 'Método Stanislavski'),
	(@am_meis, 'Técnica Meisner'),
	(@am_brec, 'Teatro Épico Brechtiano');

/* Insertion of values into the user_role table */
SET @r_admin = UUID(); SET @r_user = UUID();
INSERT INTO user_role (id, name) VALUES
	(@r_admin, 'ADMIN'),
	(@r_user, 'USER');

/* Insertion of values into the subscription_type table */
SET @st_sub = UUID(); SET @st_rent = UUID();
SET @st_free = UUID(); SET @st_buy = UUID();
INSERT INTO subscription_type (id, name) VALUES
	(@st_sub, 'SUBSCRIPTION'),
	(@st_rent, 'RENT'),
	(@st_free, 'FREE'),
	(@st_buy, 'PURCHASE');

/* Insertion of values into the classification table */
SET @cl_g = UUID(); SET @cl_pg = UUID(); SET @cl_pg13 = UUID();
SET @cl_r = UUID(); SET @cl_nc17 = UUID();
INSERT INTO classification (id, classification_system, name, description, min_age) VALUES
	(@cl_g, 'MPAA', 'G', 'Audiencia general', 0),
	(@cl_pg, 'MPAA', 'PG', 'Orientación parental sugerida', 8),
	(@cl_pg13, 'MPAA', 'PG-13', 'Inapropiada para menores de 13', 13),
	(@cl_r, 'MPAA', 'R', 'Requiere adulto para menores de 17', 17),
	(@cl_nc17, 'MPAA', 'NC-17', 'Solo adultos', 18);

/* Insertion of values into the company_role table */
SET @cr_prod = UUID(); SET @cr_dist = UUID();
SET @cr_co = UUID(); SET @cr_exec = UUID();
INSERT INTO company_role (id, name) VALUES
	(@cr_prod, 'PRODUCER'),
	(@cr_dist, 'DISTRIBUTOR'),
	(@cr_co, 'CO_PRODUCER'),
	(@cr_exec, 'EXECUTIVE_PRODUCER');

/* Insertion of values into the director_role table */
SET @dr_dir = UUID(); SET @dr_codir = UUID(); SET @dr_2nd = UUID();
INSERT INTO director_role (id, name) VALUES
	(@dr_dir, 'DIRECTOR'),
	(@dr_codir, 'CO_DIRECTOR'),
	(@dr_2nd, 'SECOND_UNIT_DIRECTOR');

/* Insertion of values into the status_watchlist table */
SET @ws_pend = UUID(); SET @ws_wtch = UUID();
SET @ws_done = UUID(); SET @ws_drop = UUID();
INSERT INTO status_watchlist (id, name) VALUES
	(@ws_pend, 'PENDING'),
	(@ws_wtch, 'WATCHING'),
	(@ws_done, 'WATCHED'),
	(@ws_drop, 'DROPPED');

/* Insertion of values into the award table */
SET @aw_oscar = UUID(); SET @aw_bafta = UUID();
SET @aw_cannes = UUID(); SET @aw_fcc = UUID();
INSERT INTO award (id, name, country_id, founded_year) VALUES
	(@aw_oscar, 'Academy Awards', @us, 1929),
	(@aw_bafta, 'BAFTA', @uk, 1947),
	(@aw_cannes, 'Cannes Film Festival', @fr, 1946),
	(@aw_fcc, 'Festival de Cine de Cartagena', @co, 1960);

/* Insertion of values into the production_company table */
SET @pc_wb = UUID(); SET @pc_a24 = UUID(); SET @pc_cj = UUID();
SET @pc_legend = UUID(); SET @pc_nflx = UUID(); SET @pc_neon = UUID();
SET @pc_param = UUID(); SET @pc_focus = UUID();
INSERT INTO production_company (id, name, country_id, founded_year) VALUES
	(@pc_wb, 'Warner Bros. Pictures', @us, 1923),
	(@pc_a24, 'A24', @us, 2012),
	(@pc_cj, 'CJ ENM', @kr, 1995),
	(@pc_legend, 'Legendary Pictures', @us, 2000),
	(@pc_nflx, 'Netflix Studios', @us, 2005),
	(@pc_neon, 'NEON', @us, 2017),
	(@pc_param, 'Paramount Pictures', @us, 1912),
	(@pc_focus, 'Focus Features', @us, 2002);

/* Insertion of values into the streaming_platform table */
SET @sp_nflx = UUID(); SET @sp_hbo = UUID();
SET @sp_amazon = UUID(); SET @sp_mubi = UUID();
INSERT INTO streaming_platform (id, name, country_id, subscription_type_id) VALUES
	(@sp_nflx, 'Netflix', @us, @st_sub),
	(@sp_hbo, 'HBO Max', @us, @st_sub),
	(@sp_amazon, 'Amazon Prime Video', @us, @st_sub),
	(@sp_mubi, 'Mubi', @uk, @st_sub);

/* Insertion of values into the person table */
SET @p_nolan = UUID(); SET @p_bong = UUID(); SET @p_vil = UUID();
SET @p_gerwig = UUID(); SET @p_cuaron = UUID(); SET @p_inarr = UUID();
SET @p_jenkins = UUID(); SET @p_sciamma = UUID(); SET @p_guerra = UUID();
SET @p_dan_k = UUID(); SET @p_chazelle = UUID(); SET @p_mendes = UUID();
SET @p_dicap = UUID(); SET @p_kangho = UUID(); SET @p_chalm = UUID();
SET @p_cotil = UUID(); SET @p_sodam = UUID(); SET @p_ali = UUID();
SET @p_hardy = UUID(); SET @p_adams = UUID(); SET @p_zend = UUID();
SET @p_gosling = UUID(); SET @p_murphy = UUID(); SET @p_yeoh = UUID();
INSERT INTO person (id, name, last_name, birth_date, country_id) VALUES
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
INSERT INTO director (id, directing_style_id) VALUES
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
INSERT INTO actor (id, acting_method_id) VALUES
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
SET @u_admin = UUID(); SET @u_carlos = UUID(); SET @u_laura = UUID();
SET @u_minjun = UUID(); SET @u_jiwoo = UUID();
INSERT INTO app_user (id, role_id, name, last_name, country_id, birth_date, email, password_hash) VALUES
	(@u_admin, @r_admin, 'Admin', 'Sistema', @co, '1990-01-01', 'admin@cinereview.com','$2a$12$KIXkJ8Q1HgZ5mN3tWvP0XOdY7RjA4sLbCuFqEwMnTzGpHyVxIaD2'),
	(@u_carlos, @r_user, 'Carlos', 'Rodríguez', @co, '1995-03-15', 'carlos.rodriguez@email.com', '$2a$12$AbCdEfGhIjKlMnOpQrStUvWxYz01234567890AbCdEfGhIjKlMnOp'),
	(@u_laura, @r_user, 'Laura', 'Martínez', @mx, '1998-07-22', 'laura.martinez@email.com', '$2a$12$ZyXwVuTsRqPoNmLkJiHgFeDcBa9876543210ZyXwVuTsRqPoNmLk'),
	(@u_minjun, @r_user, 'Min-jun', 'Lee', @kr, '2000-11-05', 'minjun.lee@email.com', '$2a$12$1A2B3C4D5E6F7G8H9I0JkLmNoPqRsTuVwXyZaAbBcCdDeEfFgGhH'),
	(@u_jiwoo,  @r_user, 'Ji-woo', 'Kim', @kr, '2002-04-20', 'jiwoo.kim@email.com', '$2a$12$MnOpQrStUvWxYz0123456789AbCdEfGhIjKlMnOpQrStUvWxYzAb');

/* Insertion of values into the movie table */
SET @mv_inception = UUID(); SET @mv_parasite = UUID();
SET @mv_stellar = UUID(); SET @mv_dune = UUID();
SET @mv_roma = UUID(); SET @mv_barbie = UUID();
SET @mv_abrazo = UUID(); SET @mv_knight = UUID();
SET @mv_arrival = UUID(); SET @mv_moonlight = UUID();
SET @mv_blade = UUID(); SET @mv_eeaao = UUID();
INSERT INTO movie (id, country_id, classification_id, title, release_year, synopsis, tmdb_id) VALUES
	(@mv_inception, @uk, @cl_pg13, 'Inception', 2010,
		'Un ladrón roba secretos corporativos mediante tecnología de sueños compartidos e intenta implantar una idea.',
		27205),
	(@mv_parasite, @kr, @cl_r, 'Parasite', 2019,
		'La familia Kim se infiltra en la vida de la acomodada familia Park con consecuencias imprevisibles.',
		496243),
	(@mv_stellar, @uk, @cl_pg13, 'Interstellar', 2014,
		'Un equipo de astronautas viaja por un agujero de gusano buscando un nuevo hogar para la humanidad.',
		157336),
	(@mv_dune, @us, @cl_pg13, 'Dune: Part One', 2021,
		'Paul Atreides lidera a las tribus del planeta Arrakis en una guerra para vengar a su familia.',
		438631),
	(@mv_roma, @mx, @cl_r, 'Roma', 2018,
		'Una empleada doméstica afronta cambios en una familia de clase media en el México de los 70.',
		508442),
	(@mv_barbie, @us, @cl_pg13, 'Barbie', 2023,
		'Barbie y Ken viajan desde Barbieland al mundo real desencadenando una crisis existencial.',
		346698),
	(@mv_abrazo, @co, @cl_r, 'El abrazo de la serpiente', 2015,
		'Dos expediciones científicas en la Amazonía colombiana narradas desde la perspectiva indígena.',
		NULL),
	(@mv_knight, @uk, @cl_pg13, 'The Dark Knight', 2008,
		'Batman enfrenta al Joker, un criminal que desafía a Gotham con un plan de caos absoluto.',
		155),
	(@mv_arrival, @ca, @cl_pg13, 'Arrival', 2016,
		'Una lingüista es reclutada para comunicarse con extraterrestres que han aterrizado en la Tierra.',
		329865),
	(@mv_moonlight, @us, @cl_r, 'Moonlight', 2016,
		'Un joven afroamericano explora su identidad y sexualidad en tres etapas de su vida.',
		376867),
	(@mv_blade, @us, @cl_r, 'Blade Runner 2049', 2017,
		'Un blade runner descubre un secreto que puede sumir a la humanidad en el caos.',
		335984),
	(@mv_eeaao, @us, @cl_r, 'Everything Everywhere All at Once', 2022,
		'Una lavandera es arrastrada a una aventura interdimensional para salvar el multiverso.',
		545611);

/* Insertion of values into the movie_director table */
INSERT INTO movie_director (movie_id, director_id, role_id) VALUES
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
INSERT INTO movie_genre (movie_id, genre_id) VALUES
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
INSERT INTO movie_actor (movie_id, actor_id, character_name, is_lead) VALUES
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
INSERT INTO movie_company (movie_id, company_id, role_id) VALUES
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
INSERT INTO movie_platform (movie_id, platform_id, available_since, available_until) VALUES
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
INSERT INTO review (user_id, movie_id, rating, body) VALUES
	(@u_carlos, @mv_inception, 9, 'Narrativa en capas construida con precisión quirúrgica.'),
	(@u_carlos, @mv_stellar, 10,'La escena del planeta oceánico es una de las más perturbadoras del cine moderno.'),
	(@u_carlos, @mv_parasite, 10, 'Magistral en todos los aspectos. Bong Joon-ho en su punto más alto.'),
	(@u_carlos, @mv_knight, 10, 'Heath Ledger redefine lo que un villano puede ser.'),
	(@u_carlos, @mv_arrival, 9, 'El giro narrativo final recontextualiza toda la película.'),
	(@u_carlos, @mv_moonlight, 9, 'Poesía visual. Jenkins hace de lo íntimo algo universal.'),
	(@u_carlos, @mv_roma, 10, 'Cuarón eleva lo cotidiano a lo trascendente.'),
	(@u_carlos, @mv_eeaao, 8, 'Caótico y hermoso a la vez. Un triunfo del cine independiente.'),
	(@u_laura, @mv_parasite, 9, 'Crítica social envuelta en un thriller de precisión milimétrica.'),
	(@u_laura, @mv_inception, 8, 'Visualmente impresionante, aunque el final genera más preguntas que respuestas.'),
	(@u_laura, @mv_roma, 9, 'Profundamente humana. Una de las mejores del cine latinoamericano.'),
	(@u_laura, @mv_dune, 8, 'Épica visual espectacular, aunque funciona más como prólogo.'),
	(@u_laura,  @mv_blade, 7, 'Atmosférica y hermosa, pero el ritmo puede desesperar.'),
	(@u_minjun, @mv_parasite, 10, 'Una película perfecta. Orgullo del cine coreano.'),
	(@u_minjun, @mv_stellar, 9, 'Científicamente rigurosa y emocionalmente devastadora.'),
	(@u_minjun, @mv_dune, 8, 'Impresionante escala visual. La segunda parte prometía aún más.'),
	(@u_minjun, @mv_moonlight, 10, 'Una de las películas más importantes de la última década.'),
	(@u_jiwoo,  @mv_arrival, 10, 'El lenguaje como clave del tiempo. Brillante.'),
	(@u_jiwoo,  @mv_eeaao, 9, 'Absurda, emotiva y profunda. Completamente única.');

/* Insertion of values into the watchlist table */
INSERT INTO watchlist (user_id, movie_id, status_id) VALUES
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
INSERT INTO movie_award (movie_id, award_id, category_id, year, won) VALUES
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
INSERT INTO person_award (person_id, award_id, category_id, year, won) VALUES
	(@p_bong, @aw_oscar, @ac_dir, 2020, TRUE),
	(@p_cuaron, @aw_oscar, @ac_dir, 2019, TRUE),	
	(@p_jenkins, @aw_oscar, @ac_scrpt, 2017, TRUE),
	(@p_dicap, @aw_oscar, @ac_actor, 2016, TRUE),
	(@p_cotil, @aw_oscar, @ac_act, 2008, TRUE),
	(@p_ali, @aw_oscar, @ac_actor, 2017, TRUE),
	(@p_dan_k, @aw_oscar, @ac_dir, 2023, TRUE),
	(@p_yeoh, @aw_oscar, @ac_act, 2023, TRUE);

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