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
SET @pc_param  = UUID(); SET @pc_focus  = UUID();