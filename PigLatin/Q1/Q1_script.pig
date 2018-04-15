--Question 1: How many movies were released in each year

--load the data from HDFS and define the schema
movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);

moviesperyear = Group movies by year;

-- Read only the attributes we are interested in.
yearcount = FOREACH moviesperyear GENERATE $0,COUNT(movies.movieid) as nummovies;

-- Order that by year.
ordered = ORDER yearcount BY $0;

STORE ordered INTO 'q1'
