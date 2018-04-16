--Question 6: Find the 5 Sci-Fi movies from 2015 with the maximum number of user ratings

movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:int, title:chararray, year:int);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:int, movieid:int, rating:double, timestamp);
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:int, genre:chararray);

ratings_grouped = GROUP ratings BY movieid;
ratings_counted = FOREACH ratings_grouped GENERATE $0,COUNT($1);

filtered_genres = FILTER moviegenres BY genre == 'Sci-Fi';

movies2015 = FILTER movies BY year == 2015;


pre_join_tables = JOIN movies2015 BY movieid LEFT, ratings_counted BY $0;

join_tables = JOIN pre_join_tables BY $0, filtered_genres BY $0;

null_replaced = FOREACH join_tables GENERATE $1,($4 is NULL ? 0L : $4);

ordered_count = ORDER null_replaced BY $1 DESC;

out5 = LIMIT ordered_count 5;

dump out5;
