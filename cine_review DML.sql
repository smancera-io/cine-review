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