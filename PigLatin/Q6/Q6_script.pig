movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT); 
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP); 
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

ratings_grouped = GROUP ratings by movieid;
ratings_counted = FOREACH ratings_grouped GENERATE $0,COUNT($1);

filtered_genres = FILTER moviegenres BY genre == 'Sci-Fi' ;

movies_filtered = FILTER movies BY year == 2015;

pre_join_tables = JOIN movies_filtered by movieid LEFT, ratings_counted by $0;

join_tables = JOIN pre_join_tables by $0, filtered_genres by $0;

null_replaced = FOREACH join_tables GENERATE $1,($4 is NULL ? 0L : $4);

ordered_count = ORDER null_replaced BY $1 DESC;

out = LIMIT ordered_count 5;

dump out;