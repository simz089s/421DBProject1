movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT); 
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP); 

ratings_grouped = GROUP ratings by movieid;
ratings_counted = FOREACH ratings_grouped GENERATE $0,COUNT($1);

join_tables = JOIN movies by movieid LEFT, ratings_counted by $0;

null_replaced = FOREACH join_tables GENERATE $1,($4 is NULL ? 0L : $4);

ordered_count = ORDER null_replaced BY $1 DESC;

out = LIMIT ordered_count 10;

dump out;