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

SET @g_scifi    = UUID(); SET @g_drama    = UUID(); SET @g_thriller = UUID();
SET @g_horror   = UUID(); SET @g_comedy   = UUID(); SET @g_action   = UUID();
SET @g_anim     = UUID(); SET @g_doc      = UUID(); SET @g_romance  = UUID();
SET @g_bio      = UUID();

INSERT INTO genre (id, name) VALUES
(@g_scifi,    'Ciencia Ficción'),
(@g_drama,    'Drama'),
(@g_thriller, 'Thriller'),
(@g_horror,   'Terror'),
(@g_comedy,   'Comedia'),
(@g_action,   'Acción'),
(@g_anim,     'Animación'),
(@g_doc,      'Documental'),
(@g_romance,  'Romance'),
(@g_bio,      'Biográfico');

SET @ac_film  = UUID(); SET @ac_dir   = UUID(); SET @ac_actor = UUID();
SET @ac_act   = UUID(); SET @ac_scrpt = UUID(); SET @ac_photo = UUID();
SET @ac_intl  = UUID();

INSERT INTO award_category (id, name) VALUES
(@ac_film,  'Mejor Película'),
(@ac_dir,   'Mejor Director'),
(@ac_actor, 'Mejor Actor Principal'),
(@ac_act,   'Mejor Actriz Principal'),
(@ac_scrpt, 'Mejor Guión Original'),
(@ac_photo, 'Mejor Fotografía'),
(@ac_intl,  'Mejor Película Internacional');

SET @ds_epic   = UUID(); SET @ds_neo    = UUID(); SET @ds_psych  = UUID();
SET @ds_social = UUID(); SET @ds_sci    = UUID(); SET @ds_dark   = UUID();

INSERT INTO directing_style (id, name) VALUES
(@ds_epic,   'Cine Épico'),
(@ds_neo,    'Neorrealismo'),
(@ds_psych,  'Thriller Psicológico'),
(@ds_social, 'Drama Social'),
(@ds_sci,    'Ciencia Ficción Conceptual'),
(@ds_dark,   'Comedia Oscura');

SET @am_stan = UUID(); SET @am_meis = UUID(); SET @am_brec = UUID();

INSERT INTO acting_method (id, name) VALUES
(@am_stan, 'Método Stanislavski'),
(@am_meis, 'Técnica Meisner'),
(@am_brec, 'Teatro Épico Brechtiano');

SET @r_admin = UUID(); SET @r_user = UUID();

INSERT INTO user_role (id, name) VALUES
(@r_admin, 'ADMIN'),
(@r_user,  'USER');

SET @st_sub  = UUID(); SET @st_rent = UUID();
SET @st_free = UUID(); SET @st_buy  = UUID();

INSERT INTO subscription_type (id, name) VALUES
(@st_sub,  'SUBSCRIPTION'),
(@st_rent, 'RENT'),
(@st_free, 'FREE'),
(@st_buy,  'PURCHASE');

SET @cl_g    = UUID(); SET @cl_pg   = UUID(); SET @cl_pg13 = UUID();
SET @cl_r    = UUID(); SET @cl_nc17 = UUID();

INSERT INTO classification (id, classification_system, name, description, min_age) VALUES
(@cl_g,    'MPAA', 'G',     'Audiencia general',                            0),
(@cl_pg,   'MPAA', 'PG',    'Orientación parental sugerida',                8),
(@cl_pg13, 'MPAA', 'PG-13', 'Inapropiada para menores de 13',             13),
(@cl_r,    'MPAA', 'R',     'Requiere adulto para menores de 17',         17),
(@cl_nc17, 'MPAA', 'NC-17', 'Solo adultos',                               18);

SET @cr_prod = UUID(); SET @cr_dist = UUID();
SET @cr_co   = UUID(); SET @cr_exec = UUID();

INSERT INTO company_role (id, name) VALUES
(@cr_prod, 'PRODUCER'),
(@cr_dist, 'DISTRIBUTOR'),
(@cr_co,   'CO_PRODUCER'),
(@cr_exec, 'EXECUTIVE_PRODUCER');

SET @dr_dir  = UUID(); SET @dr_codir = UUID(); SET @dr_2nd = UUID();

INSERT INTO director_role (id, name) VALUES
(@dr_dir,   'DIRECTOR'),
(@dr_codir, 'CO_DIRECTOR'),
(@dr_2nd,   'SECOND_UNIT_DIRECTOR');

SET @ws_pend = UUID(); SET @ws_wtch = UUID();
SET @ws_done = UUID(); SET @ws_drop = UUID();

INSERT INTO status_watchlist (id, name) VALUES
(@ws_pend, 'PENDING'),
(@ws_wtch, 'WATCHING'),
(@ws_done, 'WATCHED'),
(@ws_drop, 'DROPPED');

SET @aw_oscar  = UUID(); SET @aw_bafta  = UUID();
SET @aw_cannes = UUID(); SET @aw_fcc    = UUID();

INSERT INTO award (id, name, country_id, founded_year) VALUES
(@aw_oscar,  'Academy Awards',                @us, 1929),
(@aw_bafta,  'BAFTA',                         @uk, 1947),
(@aw_cannes, 'Cannes Film Festival',          @fr, 1946),
(@aw_fcc,    'Festival de Cine de Cartagena', @co, 1960);

SET @pc_wb     = UUID(); SET @pc_a24    = UUID(); SET @pc_cj     = UUID();
SET @pc_legend = UUID(); SET @pc_nflx   = UUID(); SET @pc_neon   = UUID();
SET @pc_param  = UUID(); SET @pc_focus  = UUID();

INSERT INTO production_company (id, name, country_id, founded_year) VALUES
(@pc_wb,     'Warner Bros. Pictures', @us, 1923),
(@pc_a24,    'A24',                   @us, 2012),
(@pc_cj,     'CJ ENM',               @kr, 1995),
(@pc_legend, 'Legendary Pictures',   @us, 2000),
(@pc_nflx,   'Netflix Studios',      @us, 2005),
(@pc_neon,   'NEON',                 @us, 2017),
(@pc_param,  'Paramount Pictures',   @us, 1912),
(@pc_focus,  'Focus Features',       @us, 2002);

SET @sp_nflx   = UUID(); SET @sp_hbo  = UUID();
SET @sp_amazon = UUID(); SET @sp_mubi = UUID();

INSERT INTO streaming_platform (id, name, country_id, subscription_type_id) VALUES
(@sp_nflx,   'Netflix',            @us, @st_sub),
(@sp_hbo,    'HBO Max',            @us, @st_sub),
(@sp_amazon, 'Amazon Prime Video', @us, @st_sub),
(@sp_mubi,   'Mubi',               @uk, @st_sub);

SET @p_nolan    = UUID(); SET @p_bong     = UUID(); SET @p_vil      = UUID();
SET @p_gerwig   = UUID(); SET @p_cuaron   = UUID(); SET @p_inarr    = UUID();
SET @p_jenkins  = UUID(); SET @p_sciamma  = UUID(); SET @p_guerra   = UUID();
SET @p_dan_k    = UUID(); SET @p_chazelle = UUID(); SET @p_mendes   = UUID();
SET @p_dicap    = UUID(); SET @p_kangho   = UUID(); SET @p_chalm    = UUID();
SET @p_cotil    = UUID(); SET @p_sodam    = UUID(); SET @p_ali      = UUID();
SET @p_hardy    = UUID(); SET @p_adams    = UUID(); SET @p_zend     = UUID();
SET @p_gosling  = UUID(); SET @p_murphy   = UUID(); SET @p_yeoh     = UUID();

INSERT INTO person (id, name, last_name, birth_date, country_id) VALUES
(@p_nolan,    'Christopher', 'Nolan',      '1970-07-30', @uk),
(@p_bong,     'Bong',        'Joon-ho',    '1969-09-14', @kr),
(@p_vil,      'Denis',       'Villeneuve', '1967-10-03', @ca),
(@p_gerwig,   'Greta',       'Gerwig',     '1983-08-04', @us),
(@p_cuaron,   'Alfonso',     'Cuarón',     '1961-11-28', @mx),
(@p_inarr,    'Alejandro',   'Iñárritu',   '1963-08-15', @mx),
(@p_jenkins,  'Barry',       'Jenkins',    '1979-11-19', @us),
(@p_sciamma,  'Céline',      'Sciamma',    '1978-11-12', @fr),
(@p_guerra,   'Ciro',        'Guerra',     '1981-02-06', @co),
(@p_dan_k,    'Daniel',      'Kwan',       '1988-02-14', @us),
(@p_chazelle, 'Damien',      'Chazelle',   '1985-01-19', @us),
(@p_mendes,   'Sam',         'Mendes',     '1965-08-01', @uk),
(@p_dicap,    'Leonardo',    'DiCaprio',   '1974-11-11', @us),
(@p_kangho,   'Song',        'Kang-ho',    '1967-01-17', @kr),
(@p_chalm,    'Timothée',    'Chalamet',   '1995-12-27', @us),
(@p_cotil,    'Marion',      'Cotillard',  '1975-09-30', @fr),
(@p_sodam,    'Park',        'So-dam',     '1991-09-08', @kr),
(@p_ali,      'Mahershala',  'Ali',        '1974-02-16', @us),
(@p_hardy,    'Tom',         'Hardy',      '1977-09-15', @uk),
(@p_adams,    'Amy',         'Adams',      '1974-08-20', @us),
(@p_zend,     'Zendaya',     'Coleman',    '1996-09-01', @us),
(@p_gosling,  'Ryan',        'Gosling',    '1980-11-12', @ca),
(@p_murphy,   'Cillian',     'Murphy',     '1976-05-25', @uk),
(@p_yeoh,     'Michelle',    'Yeoh',       '1962-08-06', @us);

INSERT INTO director (id, directing_style_id) VALUES
(@p_nolan,    @ds_epic),
(@p_bong,     @ds_social),
(@p_vil,      @ds_sci),
(@p_gerwig,   @ds_neo),
(@p_cuaron,   @ds_social),
(@p_inarr,    @ds_psych),
(@p_jenkins,  @ds_neo),
(@p_sciamma,  @ds_neo),
(@p_guerra,   @ds_neo),
(@p_dan_k,    @ds_dark),
(@p_chazelle, @ds_neo),
(@p_mendes,   @ds_epic);

INSERT INTO actor (id, acting_method_id) VALUES
(@p_dicap,   @am_stan),
(@p_kangho,  @am_meis),
(@p_chalm,   @am_stan),
(@p_cotil,   @am_meis),
(@p_sodam,   @am_stan),
(@p_ali,     @am_meis),
(@p_hardy,   @am_stan),
(@p_adams,   @am_stan),
(@p_zend,    @am_meis),
(@p_gosling, @am_meis),
(@p_murphy,  @am_stan),
(@p_yeoh,    @am_meis);

SET @u_admin  = UUID(); SET @u_carlos = UUID(); SET @u_laura  = UUID();
SET @u_minjun = UUID(); SET @u_jiwoo  = UUID();

INSERT INTO app_user (id, role_id, name, last_name, country_id, birth_date, email, password_hash) VALUES
(@u_admin,  @r_admin, 'Admin',   'Sistema',   @co, '1990-01-01',
    'admin@cinereview.com',       '$2a$12$KIXkJ8Q1HgZ5mN3tWvP0XOdY7RjA4sLbCuFqEwMnTzGpHyVxIaD2'),
(@u_carlos, @r_user,  'Carlos',  'Rodríguez', @co, '1995-03-15',
    'carlos.rodriguez@email.com', '$2a$12$AbCdEfGhIjKlMnOpQrStUvWxYz01234567890AbCdEfGhIjKlMnOp'),
(@u_laura,  @r_user,  'Laura',   'Martínez',  @mx, '1998-07-22',
    'laura.martinez@email.com',   '$2a$12$ZyXwVuTsRqPoNmLkJiHgFeDcBa9876543210ZyXwVuTsRqPoNmLk'),
(@u_minjun, @r_user,  'Min-jun', 'Lee',       @kr, '2000-11-05',
    'minjun.lee@email.com',       '$2a$12$1A2B3C4D5E6F7G8H9I0JkLmNoPqRsTuVwXyZaAbBcCdDeEfFgGhH'),
(@u_jiwoo,  @r_user,  'Ji-woo',  'Kim',       @kr, '2002-04-20',
    'jiwoo.kim@email.com',        '$2a$12$MnOpQrStUvWxYz0123456789AbCdEfGhIjKlMnOpQrStUvWxYzAb');

SET @mv_inception = UUID(); SET @mv_parasite  = UUID();
SET @mv_stellar   = UUID(); SET @mv_dune      = UUID();
SET @mv_roma      = UUID(); SET @mv_barbie    = UUID();
SET @mv_abrazo    = UUID(); SET @mv_knight    = UUID();
SET @mv_arrival   = UUID(); SET @mv_moonlight = UUID();
SET @mv_blade     = UUID(); SET @mv_eeaao     = UUID();

INSERT INTO movie (id, country_id, classification_id, title, release_year, synopsis, tmdb_id) VALUES
(@mv_inception, @uk, @cl_pg13, 'Inception',        2010,
    'Un ladrón roba secretos corporativos mediante tecnología de sueños compartidos e intenta implantar una idea.',
    27205),
(@mv_parasite,  @kr, @cl_r,    'Parasite',          2019,
    'La familia Kim se infiltra en la vida de la acomodada familia Park con consecuencias imprevisibles.',
    496243),
(@mv_stellar,   @uk, @cl_pg13, 'Interstellar',      2014,
    'Un equipo de astronautas viaja por un agujero de gusano buscando un nuevo hogar para la humanidad.',
    157336),
(@mv_dune,      @us, @cl_pg13, 'Dune: Part One',    2021,
    'Paul Atreides lidera a las tribus del planeta Arrakis en una guerra para vengar a su familia.',
    438631),
(@mv_roma,      @mx, @cl_r,    'Roma',              2018,
    'Una empleada doméstica afronta cambios en una familia de clase media en el México de los 70.',
    508442),
(@mv_barbie,    @us, @cl_pg13, 'Barbie',            2023,
    'Barbie y Ken viajan desde Barbieland al mundo real desencadenando una crisis existencial.',
    346698),
(@mv_abrazo,    @co, @cl_r,    'El abrazo de la serpiente', 2015,
    'Dos expediciones científicas en la Amazonía colombiana narradas desde la perspectiva indígena.',
    NULL),
(@mv_knight,    @uk, @cl_pg13, 'The Dark Knight',   2008,
    'Batman enfrenta al Joker, un criminal que desafía a Gotham con un plan de caos absoluto.',
    155),
(@mv_arrival,   @ca, @cl_pg13, 'Arrival',           2016,
    'Una lingüista es reclutada para comunicarse con extraterrestres que han aterrizado en la Tierra.',
    329865),
(@mv_moonlight, @us, @cl_r,    'Moonlight',         2016,
    'Un joven afroamericano explora su identidad y sexualidad en tres etapas de su vida.',
    376867),
(@mv_blade,     @us, @cl_r,    'Blade Runner 2049', 2017,
    'Un blade runner descubre un secreto que puede sumir a la humanidad en el caos.',
    335984),
(@mv_eeaao,     @us, @cl_r,    'Everything Everywhere All at Once', 2022,
    'Una lavandera es arrastrada a una aventura interdimensional para salvar el multiverso.',
    545611);
    
    INSERT INTO movie_director (movie_id, director_id, role_id) VALUES
(@mv_inception, @p_nolan,    @dr_dir),
(@mv_parasite,  @p_bong,     @dr_dir),
(@mv_stellar,   @p_nolan,    @dr_dir),
(@mv_dune,      @p_vil,      @dr_dir),
(@mv_roma,      @p_cuaron,   @dr_dir),
(@mv_barbie,    @p_gerwig,   @dr_dir),
(@mv_abrazo,    @p_guerra,   @dr_dir),
(@mv_knight,    @p_nolan,    @dr_dir),
(@mv_arrival,   @p_vil,      @dr_dir),
(@mv_moonlight, @p_jenkins,  @dr_dir),
(@mv_blade,     @p_vil,      @dr_dir),
(@mv_eeaao,     @p_dan_k,    @dr_dir);

INSERT INTO movie_genre (movie_id, genre_id) VALUES
(@mv_inception, @g_scifi),    (@mv_inception, @g_action),   (@mv_inception, @g_thriller),
(@mv_parasite,  @g_drama),    (@mv_parasite,  @g_thriller),  (@mv_parasite,  @g_comedy),
(@mv_stellar,   @g_scifi),    (@mv_stellar,   @g_drama),
(@mv_dune,      @g_scifi),    (@mv_dune,      @g_action),
(@mv_roma,      @g_drama),    (@mv_roma,      @g_doc),
(@mv_barbie,    @g_comedy),   (@mv_barbie,    @g_drama),
(@mv_abrazo,    @g_drama),    (@mv_abrazo,    @g_doc),
(@mv_knight,    @g_action),   (@mv_knight,    @g_thriller),
(@mv_arrival,   @g_scifi),    (@mv_arrival,   @g_drama),    (@mv_arrival,   @g_thriller),
(@mv_moonlight, @g_drama),
(@mv_blade,     @g_scifi),    (@mv_blade,     @g_thriller),
(@mv_eeaao,     @g_scifi),    (@mv_eeaao,     @g_action),   (@mv_eeaao,     @g_comedy);

INSERT INTO movie_actor (movie_id, actor_id, character_name, is_lead) VALUES
(@mv_inception, @p_dicap,   'Dom Cobb',        TRUE),
(@mv_inception, @p_cotil,   'Mal Cobb',         FALSE),
(@mv_inception, @p_hardy,   'Eames',            FALSE),
(@mv_parasite,  @p_kangho,  'Ki-taek',          TRUE),
(@mv_parasite,  @p_sodam,   'Ki-jung',          FALSE),
(@mv_dune,      @p_chalm,   'Paul Atreides',    TRUE),
(@mv_dune,      @p_zend,    'Chani',            FALSE),
(@mv_moonlight, @p_ali,     'Juan',             TRUE),
(@mv_blade,     @p_gosling, 'K / Joe',          TRUE),
(@mv_arrival,   @p_adams,   'Louise Banks',     TRUE),
(@mv_eeaao,     @p_yeoh,    'Evelyn Wang',      TRUE),
(@mv_knight,    @p_murphy,  'Jonathan Crane',   FALSE);

INSERT INTO movie_company (movie_id, company_id, role_id) VALUES
(@mv_inception, @pc_wb,     @cr_prod),
(@mv_inception, @pc_legend, @cr_co),
(@mv_parasite,  @pc_cj,     @cr_prod),
(@mv_stellar,   @pc_wb,     @cr_prod),
(@mv_stellar,   @pc_legend, @cr_co),
(@mv_dune,      @pc_wb,     @cr_prod),
(@mv_dune,      @pc_legend, @cr_co),
(@mv_roma,      @pc_nflx,   @cr_prod),
(@mv_barbie,    @pc_wb,     @cr_prod),
(@mv_knight,    @pc_wb,     @cr_prod),
(@mv_knight,    @pc_legend, @cr_co),
(@mv_arrival,   @pc_param,  @cr_prod),
(@mv_moonlight, @pc_a24,    @cr_prod),
(@mv_blade,     @pc_wb,     @cr_prod),
(@mv_eeaao,     @pc_a24,    @cr_prod);

INSERT INTO movie_platform (movie_id, platform_id, available_since, available_until) VALUES
(@mv_inception, @sp_hbo,    '2021-01-01', NULL),
(@mv_parasite,  @sp_nflx,   '2020-04-08', NULL),
(@mv_stellar,   @sp_amazon, '2020-01-01', '2023-12-31'),
(@mv_stellar,   @sp_nflx,   '2024-01-01', NULL),
(@mv_dune,      @sp_hbo,    '2021-10-22', NULL),
(@mv_roma,      @sp_nflx,   '2018-12-14', NULL),
(@mv_barbie,    @sp_hbo,    '2023-09-12', '2024-09-11'),
(@mv_abrazo,    @sp_mubi,   '2022-03-01', NULL),
(@mv_knight,    @sp_hbo,    '2020-06-01', NULL),
(@mv_arrival,   @sp_amazon, '2021-03-15', NULL),
(@mv_moonlight, @sp_nflx,   '2021-07-01', NULL),
(@mv_blade,     @sp_amazon, '2022-01-01', NULL),
(@mv_eeaao,     @sp_amazon, '2022-08-01', NULL);

INSERT INTO review (user_id, movie_id, rating, body) VALUES
(@u_carlos, @mv_inception, 9,  'Narrativa en capas construida con precisión quirúrgica.'),
(@u_carlos, @mv_stellar,   10, 'La escena del planeta oceánico es una de las más perturbadoras del cine moderno.'),
(@u_carlos, @mv_parasite,  10, 'Magistral en todos los aspectos. Bong Joon-ho en su punto más alto.'),
(@u_carlos, @mv_knight,    10, 'Heath Ledger redefine lo que un villano puede ser.'),
(@u_carlos, @mv_arrival,   9,  'El giro narrativo final recontextualiza toda la película.'),
(@u_carlos, @mv_moonlight, 9,  'Poesía visual. Jenkins hace de lo íntimo algo universal.'),
(@u_carlos, @mv_roma,      10, 'Cuarón eleva lo cotidiano a lo trascendente.'),
(@u_carlos, @mv_eeaao,     8,  'Caótico y hermoso a la vez. Un triunfo del cine independiente.'),
(@u_laura,  @mv_parasite,  9,  'Crítica social envuelta en un thriller de precisión milimétrica.'),
(@u_laura,  @mv_inception, 8,  'Visualmente impresionante, aunque el final genera más preguntas que respuestas.'),
(@u_laura,  @mv_roma,      9,  'Profundamente humana. Una de las mejores del cine latinoamericano.'),
(@u_laura,  @mv_dune,      8,  'Épica visual espectacular, aunque funciona más como prólogo.'),
(@u_laura,  @mv_blade,     7,  'Atmosférica y hermosa, pero el ritmo puede desesperar.'),
(@u_minjun, @mv_parasite,  10, 'Una película perfecta. Orgullo del cine coreano.'),
(@u_minjun, @mv_stellar,   9,  'Científicamente rigurosa y emocionalmente devastadora.'),
(@u_minjun, @mv_dune,      8,  'Impresionante escala visual. La segunda parte prometía aún más.'),
(@u_minjun, @mv_moonlight, 10, 'Una de las películas más importantes de la última década.'),
(@u_jiwoo,  @mv_arrival,   10, 'El lenguaje como clave del tiempo. Brillante.'),
(@u_jiwoo,  @mv_eeaao,     9,  'Absurda, emotiva y profunda. Completamente única.');

INSERT INTO watchlist (user_id, movie_id, status_id) VALUES
(@u_carlos, @mv_roma,      @ws_done),
(@u_carlos, @mv_barbie,    @ws_pend),
(@u_carlos, @mv_abrazo,    @ws_pend),
(@u_laura,  @mv_dune,      @ws_wtch),
(@u_laura,  @mv_abrazo,    @ws_pend),
(@u_laura,  @mv_knight,    @ws_done),
(@u_minjun, @mv_barbie,    @ws_pend),
(@u_minjun, @mv_blade,     @ws_done),
(@u_jiwoo,  @mv_inception, @ws_done),
(@u_jiwoo,  @mv_parasite,  @ws_done);

INSERT INTO movie_award (movie_id, award_id, category_id, year, won) VALUES
(@mv_parasite,  @aw_oscar,  @ac_film,  2020, TRUE),
(@mv_parasite,  @aw_oscar,  @ac_dir,   2020, TRUE),
(@mv_parasite,  @aw_oscar,  @ac_intl,  2020, TRUE),
(@mv_parasite,  @aw_cannes, @ac_film,  2019, TRUE),
(@mv_inception, @aw_oscar,  @ac_film,  2011, FALSE),
(@mv_inception, @aw_oscar,  @ac_photo, 2011, TRUE),
(@mv_roma,      @aw_oscar,  @ac_dir,   2019, TRUE),
(@mv_roma,      @aw_oscar,  @ac_intl,  2019, TRUE),
(@mv_dune,      @aw_oscar,  @ac_photo, 2022, TRUE),
(@mv_knight,    @aw_bafta,  @ac_film,  2009, FALSE),
(@mv_moonlight, @aw_oscar,  @ac_film,  2017, TRUE),
(@mv_moonlight, @aw_oscar,  @ac_scrpt, 2017, FALSE),
(@mv_eeaao,     @aw_oscar,  @ac_film,  2023, TRUE),
(@mv_eeaao,     @aw_oscar,  @ac_dir,   2023, TRUE),
(@mv_arrival,   @aw_oscar,  @ac_film,  2017, FALSE),
(@mv_arrival,   @aw_oscar,  @ac_dir,   2017, FALSE);

INSERT INTO person_award (person_id, award_id, category_id, year, won) VALUES
(@p_bong,     @aw_oscar, @ac_dir,   2020, TRUE),
(@p_cuaron,   @aw_oscar, @ac_dir,   2019, TRUE),
(@p_jenkins,  @aw_oscar, @ac_scrpt, 2017, TRUE),
(@p_dicap,    @aw_oscar, @ac_actor, 2016, TRUE),
(@p_cotil,    @aw_oscar, @ac_act,   2008, TRUE),
(@p_ali,      @aw_oscar, @ac_actor, 2017, TRUE),
(@p_dan_k,    @aw_oscar, @ac_dir,   2023, TRUE),
(@p_yeoh,     @aw_oscar, @ac_act,   2023, TRUE);

-- Películas estrenadas después de 2015
SELECT title, release_year
FROM movie
WHERE release_year > 2015
ORDER BY release_year DESC;

-- Personas nacidas antes de 1975
SELECT name, last_name, birth_date
FROM person
WHERE birth_date < '1975-01-01'
ORDER BY birth_date;

-- Reseñas con calificación mayor o igual a 9
SELECT id, rating, body
FROM review
WHERE rating >= 9
ORDER BY rating DESC;

-- Clasificaciones que restringen a mayores de 12 años
SELECT classification_system, name, min_age
FROM classification
WHERE min_age > 12
ORDER BY min_age;

-- Compañías productoras fundadas entre 1990 y 2010
SELECT name, founded_year
FROM production_company
WHERE founded_year >= 1990 AND founded_year <= 2010
ORDER BY founded_year;

-- Películas con tmdb_id asignado
SELECT title, release_year, tmdb_id
FROM movie
WHERE tmdb_id IS NOT NULL
ORDER BY release_year DESC;

-- Películas sin vinculación TMDB
SELECT title, release_year
FROM movie
WHERE tmdb_id IS NULL;

-- Disponibilidades de plataforma ya vencidas
SELECT movie_id, platform_id, available_since, available_until
FROM movie_platform
WHERE available_until IS NOT NULL
  AND available_until <= CURDATE();
  
-- Estadísticas globales de ratings
SELECT MAX(rating)           AS max_rating,
       MIN(rating)           AS min_rating,
       ROUND(AVG(rating), 2) AS avg_rating,
       SUM(rating)           AS sum_total,
       COUNT(*)              AS total_reviews
FROM review;

-- Promedio de calificación por película
SELECT movie_id,
       ROUND(AVG(rating), 2) AS avg_rating,
       COUNT(*)              AS review_count
FROM review
GROUP BY movie_id
ORDER BY avg_rating DESC;

-- Victorias y nominaciones por película
SELECT movie_id,
       COUNT(*)            AS total_nominations,
       SUM(won)            AS total_wins,
       COUNT(*) - SUM(won) AS total_losses
FROM movie_award
GROUP BY movie_id
ORDER BY total_wins DESC;

-- Número de películas por género
SELECT g.name             AS genre,
       COUNT(mg.movie_id) AS total_movies
FROM genre g
LEFT JOIN movie_genre mg ON mg.genre_id = g.id
GROUP BY g.id, g.name
ORDER BY total_movies DESC;

-- Edades mínima y máxima por sistema de clasificación
SELECT classification_system,
       MIN(min_age) AS min_age_floor,
       MAX(min_age) AS max_age_ceiling
FROM classification
GROUP BY classification_system;

-- Actividad de reviewers
SELECT user_id,
       COUNT(*)              AS reviews_written,
       ROUND(AVG(rating), 2) AS avg_given_rating,
       MAX(rating)           AS highest_given,
       MIN(rating)           AS lowest_given
FROM review
GROUP BY user_id
ORDER BY reviews_written DESC;

-- Personas nacidas en el segundo semestre
SELECT name, last_name, birth_date
FROM person
WHERE MONTH(birth_date) >= 7
ORDER BY MONTH(birth_date), DAY(birth_date);

-- Usuarios registrados en el año en curso
SELECT name, last_name, email, created_at
FROM app_user
WHERE YEAR(created_at) = YEAR(CURDATE());

-- Distribución mensual de reseñas
SELECT YEAR(created_at)  AS year,
       MONTH(created_at) AS month,
       COUNT(*)          AS reviews_count
FROM review
GROUP BY YEAR(created_at), MONTH(created_at)
ORDER BY year, month;

-- Disponibilidades que vencen este año
SELECT m.title, sp.name AS platform, mp.available_until
FROM movie_platform mp
INNER JOIN movie              m  ON m.id  = mp.movie_id
INNER JOIN streaming_platform sp ON sp.id = mp.platform_id
WHERE YEAR(mp.available_until) = YEAR(CURDATE())
ORDER BY mp.available_until;

-- Directores mayores de 50 años
SELECT p.name, p.last_name, p.birth_date,
       TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) AS age
FROM person p
INNER JOIN director d ON d.id = p.id
WHERE TIMESTAMPDIFF(YEAR, p.birth_date, CURDATE()) > 50
ORDER BY age DESC;

-- Premios por año en la última década
SELECT ma.year,
       COUNT(*)     AS total_nominations,
       SUM(ma.won)  AS total_wins
FROM movie_award ma
WHERE ma.year >= 2015 AND ma.year <= 2025
GROUP BY ma.year
ORDER BY ma.year DESC;

-- Mes con más cumpleaños entre personas registradas
SELECT MONTH(birth_date) AS birth_month,
       COUNT(*)           AS total_persons
FROM person
GROUP BY MONTH(birth_date)
ORDER BY total_persons DESC;

-- Película con país de producción y clasificación
SELECT m.title, m.release_year,
       c.name  AS country,
       cl.name AS classification,
       cl.min_age
FROM movie m
INNER JOIN country        c  ON c.id  = m.country_id
INNER JOIN classification cl ON cl.id = m.classification_id
ORDER BY m.release_year DESC;

-- Película con director, país del director y estilo de dirección
SELECT m.title, m.release_year,
       p.name        AS director_name,
       p.last_name   AS director_last_name,
       c.name        AS director_nationality,
       ds.name       AS directing_style,
       dr.name       AS role_in_film
FROM movie_director md
INNER JOIN movie           m  ON m.id   = md.movie_id
INNER JOIN director        d  ON d.id   = md.director_id
INNER JOIN person          p  ON p.id   = d.id
INNER JOIN country         c  ON c.id   = p.country_id
INNER JOIN directing_style ds ON ds.id  = d.directing_style_id
INNER JOIN director_role   dr ON dr.id  = md.role_id
ORDER BY m.title;

-- Géneros por película
SELECT m.title,
       GROUP_CONCAT(g.name ORDER BY g.name SEPARATOR ', ') AS genres
FROM movie m
INNER JOIN movie_genre mg ON mg.movie_id = m.id
INNER JOIN genre       g  ON g.id        = mg.genre_id
GROUP BY m.id, m.title
ORDER BY m.title;

-- Actores protagonistas con método de actuación
SELECT m.title,
       p.name           AS actor_name,
       p.last_name,
       ma.character_name,
       am.name          AS acting_method
FROM movie_actor ma
INNER JOIN movie         m  ON m.id  = ma.movie_id
INNER JOIN actor         a  ON a.id  = ma.actor_id
INNER JOIN person        p  ON p.id  = a.id
INNER JOIN acting_method am ON am.id = a.acting_method_id
WHERE ma.is_lead = TRUE
ORDER BY m.title;

-- Reseñas con datos completos de usuario y película
SELECT u.name, u.last_name,
       m.title, r.rating, r.body, r.created_at
FROM review r
INNER JOIN app_user u ON u.id = r.user_id
INNER JOIN movie    m ON m.id = r.movie_id
ORDER BY r.created_at DESC;

-- Películas actualmente disponibles en streaming
SELECT m.title, m.release_year,
       sp.name          AS platform,
       mp.available_since
FROM movie_platform mp
INNER JOIN movie              m  ON m.id  = mp.movie_id
INNER JOIN streaming_platform sp ON sp.id = mp.platform_id
WHERE mp.available_until IS NULL
   OR mp.available_until > CURDATE()
ORDER BY sp.name, m.title;

-- Películas con compañías productoras
SELECT m.title,
       pc.name AS company,
       cr.name AS company_role
FROM movie_company mc
INNER JOIN movie              m  ON m.id  = mc.movie_id
INNER JOIN production_company pc ON pc.id = mc.company_id
INNER JOIN company_role       cr ON cr.id = mc.role_id
WHERE cr.name = 'PRODUCER'
ORDER BY m.title;

-- Películas ganadoras de premios
SELECT m.title,
       a.name  AS award,
       ac.name AS category,
       ma.year
FROM movie_award ma
INNER JOIN movie          m  ON m.id  = ma.movie_id
INNER JOIN award          a  ON a.id  = ma.award_id
INNER JOIN award_category ac ON ac.id = ma.category_id
WHERE ma.won = TRUE
ORDER BY ma.year DESC;

-- Watchlist de usuarios con estado
SELECT u.name, u.last_name,
       m.title, sw.name AS status, w.added_at
FROM watchlist w
INNER JOIN app_user         u  ON u.id  = w.user_id
INNER JOIN movie            m  ON m.id  = w.movie_id
INNER JOIN status_watchlist sw ON sw.id = w.status_id
ORDER BY u.last_name, w.added_at DESC;

-- Personas ganadoras de premios individuales
SELECT p.name, p.last_name,
       c.name  AS nationality,
       a.name  AS award,
       ac.name AS category,
       pa.year
FROM person_award pa
INNER JOIN person         p  ON p.id  = pa.person_id
INNER JOIN award          a  ON a.id  = pa.award_id
INNER JOIN award_category ac ON ac.id = pa.category_id
LEFT  JOIN country        c  ON c.id  = p.country_id
WHERE pa.won = TRUE
ORDER BY pa.year DESC;

-- LEFT JOIN: películas sin ninguna reseña
SELECT m.title, m.release_year, c.name AS country
FROM movie m
LEFT  JOIN review  r ON r.movie_id = m.id
INNER JOIN country c ON c.id       = m.country_id
WHERE r.id IS NULL
ORDER BY m.release_year;

-- Directores con número de películas en catálogo
SELECT p.name, p.last_name,
       ds.name             AS directing_style,
       COUNT(md.movie_id)  AS movies_in_catalog
FROM director d
INNER JOIN person          p  ON p.id  = d.id
INNER JOIN directing_style ds ON ds.id = d.directing_style_id
LEFT  JOIN movie_director  md ON md.director_id = d.id
GROUP BY d.id, p.name, p.last_name, ds.name
ORDER BY movies_in_catalog DESC;

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

CALL sp_register_user('Sofía',  'González', 'sofia.gonzalez@email.com',
    '$2a$12$SoFiAhAsHeDpAsSwOrD1234567890AbCdEfGhIjKlMnOpQrStUv', @co, '1993-06-12', @r_user);

CALL sp_register_user('James',  'Park',     'james.park@email.com',
    '$2a$12$JaMeSpArKhAsHeDpAsS1234567890AbCdEfGhIjKlMnOpQrSt', @kr, '1997-09-30', @r_user);

CALL sp_register_user('Marie',  'Dupont',   'marie.dupont@email.com',
    '$2a$12$MaRiEdUpOnThAsHeDpAs1234567890AbCdEfGhIjKlMnOpQr', @fr, '2001-03-18', @r_user);