--Question 7: For all the movies released in 2016, output the movieid, title, number
--of genres to which the movie belongs and the number of user ratings it has received

movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:int, title:chararray, year:int);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:int, movieid:int, rating:double, TIMESTAMP);
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:int, genre:chararray);

movies2016 = FILTER movies BY year == 2016;

grouped_genres = GROUP moviegenres BY movieid;
counted_genres = FOREACH grouped_genres GENERATE $0,COUNT($1);

grouped_ratings = GROUP ratings BY movieid;
counted_ratings = FOREACH grouped_ratings GENERATE $0,COUNT($1);

genres_ratings = JOIN counted_genres BY $0, counted_ratings BY $0;

all_joined = JOIN movies2016 BY $0, genres_ratings BY $0;

out = FOREACH all_joined GENERATE $0,$1,$4,$6;

STORE out INTO 'q7' USING PigStorage(',');
