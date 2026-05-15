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