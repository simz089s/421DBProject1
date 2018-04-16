--Question 3: For each genre, how many movies were produced in the years 2015 and 2016

--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);
moviegenres = LOAD '/data/moviegenres.csv' USING PigStorage(',') AS (movieid:INT, genre:CHARARRAY);

movies1516 = FILTER movies BY year IN(2015,2016);

movies_of_interest = JOIN movies1516 by movieid, moviegenres by movieid;

grouped = GROUP movies_of_interest BY (genre,year);

counted = FOREACH grouped generate group.genre,group.year,COUNT($1);

ordered = ORDER counted by $0,$1;

dump ordered;