movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);

grouped_by_year = GROUP movies by year;

count_year = FOREACH grouped_by_year GENERATE $0,COUNT(movies);
count_year1 = FOREACH grouped_by_year GENERATE $0,COUNT(movies);

cogrouped_year = COGROUP count_year by $0, count_year1 by $0+1;

cogrouped_filtered = FILTER cogrouped_year BY not IsEmpty(count_year) and not IsEmpty(count_year1);

cogrouped_flat = FOREACH cogrouped_filtered GENERATE flatten(count_year.$0) as year,flatten(count_year.$1) 
as numthisyear,flatten(count_year1.$1) as numprevyear;

out = FILTER cogrouped_flat BY $1<$2;

--dump out;
STORE out INTO 'q4' USING PigStorage(',');