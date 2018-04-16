movies = LOAD '/data/movies.csv' USING PigStorage(',') AS (movieid:INT, title:CHARARRAY, year:INT);

grouped_by_year = GROUP movies by year;

--Create 2 instances of the same thing
count_year = FOREACH grouped_by_year GENERATE $0,COUNT(movies);
count_year1 = FOREACH grouped_by_year GENERATE $0,COUNT(movies);

--group them with year then year-1 through the +1 addition
cogrouped_year = COGROUP count_year by $0, count_year1 by $0+1;

--remove groups with empty fields on one end
cogrouped_filtered = FILTER cogrouped_year BY not IsEmpty(count_year) and not IsEmpty(count_year1);


cogrouped_flat = FOREACH cogrouped_filtered GENERATE flatten(count_year.$0) as year,flatten(count_year.$1) 
as numthisyear,flatten(count_year1.$1) as numprevyear;

--Check if the number of movies in year < than num movies year-1 
out = FILTER cogrouped_flat BY $1<$2;

--dump out;
STORE out INTO 'q4' USING PigStorage(',');