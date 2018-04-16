movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT); 
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:INT, movieid:INT, rating:DOUBLE, TIMESTAMP); 
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

movies2016 = FILTER movies BY year == 2016;

grouped_genres = GROUP moviegenres BY movieid ;
counted_genres = FOREACH grouped_genres GENERATE $0,COUNT($1);

grouped_ratings = GROUP ratings BY movieid;
counted_ratings = FOREACH grouped_ratings GENERATE $0,COUNT($1);

genres_ratings = JOIN counted_genres BY $0, counted_ratings bY $0;

all_joined = JOIN movies2016 by $0, genres_ratings BY $0;

out = FOREACH all_joined GENERATE $0,$1,$4,$6;

STORE out INTO 'q7' USING PigStorage(',');