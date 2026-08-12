/*
*   Sample queries against the 7 views defined in ddl/003_views.sql.
*   See that file for what each view computes and why.
*
*   Run after dml/001_seed_data.sql and dml/003_procedures_driven_data.sql have populated the schema. Otherwise these return empty or near-empty result sets, 
*   not errors.
*/
SELECT * FROM v_movie_ranking;
SELECT * FROM v_genre_popularity;
SELECT * FROM v_watchlist_popularity;
SELECT * FROM v_user_activity;
SELECT * FROM v_genre_by_user_preference;
SELECT * FROM v_country_performance;
SELECT * FROM v_streaming_reach;