--Question 6: Find the 5 Sci-Fi movies from 2015 with the maximum number of user ratings

movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:int, title:chararray, year:int);
ratings = LOAD '/data/ratings.csv' USING PigStorage(',') AS (userid:int, movieid:int, rating:double, timestamp:long);

movies15 = FILTER movies BY year == 2015;

movie_ratings = JOIN movies15 BY movieid, ratings BY movieid;

--grouped = GROUP movie_ratings BY movies15.movieid;

--ratingcount = FOREACH grouped GENERATE flatten(movie_ratings.title),COUNT(movie_ratings.rating) as numratings;

--orderratings = ORDER ratingcount BY ratings DESC;

--dump orderratings;
