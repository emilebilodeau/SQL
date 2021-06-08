/* SQL Exercise
====================================================================
We will be working with database imdb.db
You can download it here: https://drive.google.com/file/d/1E3KQDdGJs4a0i1RoYb8DEq0PFxCgI6cN/view?usp=sharing
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
 Find the id's of movies that have been distributed by “Universal Pictures”.
*/

SELECT movies.title, distributors.name FROM movies
JOIN movie_distributors ON movie_distributors.movie_id = movies.movie_id
JOIN distributors ON distributors.distributor_id = movie_distributors.distributor_id
WHERE distributors.name = 'Universal Pictures';

/* TASK II
 Find the name of the companies that distributed movies released in 2006.
*/

SELECT distributors.name, movies.year FROM movies
JOIN movie_distributors ON movie_distributors.movie_id = movies.movie_id
JOIN distributors ON distributors.distributor_id = movie_distributors.distributor_id
WHERE movies.year = 2006;

/* TASK III
Find all pairs of movie titles released in the same year, after 2010.
hint: use self join on table movies.
*/

SELECT movies.title, pair.title, movies.year FROM movies
JOIN movies pair
ON movies.year = pair.year
WHERE movies.year > 2010 AND movies.title != pair.title AND movies.movie_id > pair.movie_id
ORDER BY movies.year;

/* TASK IV
 Find the names and movie titles of directors that also acted in their movies.
*/

SELECT people.name, movies.title FROM people
JOIN roles ON roles.person_id = people.person_id
JOIN directors ON directors.person_id = people.person_id
JOIN movies ON movies.movie_id = roles.movie_id
WHERE (directors.person_id = roles.person_id) AND (directors.movie_id = roles.movie_id);

/* TASK V
Find ALL movies realeased in 2011 and their aka titles.
hint: left join
*/

SELECT movies.title, aka_titles.title FROM movies
LEFT OUTER JOIN aka_titles ON aka_titles.movie_id = movies.movie_id
WHERE movies.year = 2011;


/* TASK VI
Find ALL movies realeased in 1976 OR 1977 and their composer's name.
*/

SELECT movies.title, people.name, movies.year FROM people
JOIN composers ON composers.person_id = people.person_id
JOIN movies ON movies.movie_id = composers.movie_id
WHERE movies.year = 1976 OR movies.year = 1977;



/* TASK VII
Find the most popular movie genres.
*/

SELECT genres.label, COUNT(genres.label) FROM genres
JOIN movie_genres ON movie_genres.genre_id = genres.genre_id
JOIN movies ON movies.movie_id = movie_genres.movie_id
GROUP BY genres.label;

/* TASK VIII
Find the people that achieved the 10 highest average ratings for the movies 
they cinematographed.
*/

SELECT people.name, AVG(movies.rating) AS average_rating FROM people
JOIN cinematographers ON cinematographers.person_id = people.person_id
JOIN movies ON movies.movie_id = cinematographers.movie_id
GROUP BY people.name
ORDER BY average_rating DESC;

/* TASK IX
Find all countries which have produced at least one movie with a rating higher than
8.5.
hint: subquery
*/

SELECT countries.name FROM countries
JOIN movie_countries ON movie_countries.country_id = countries.country_id
JOIN movies ON movies.movie_id = movie_countries.movie_id
WHERE movies.rating > 8.5
GROUP BY countries.name;

/* subquery is more expensive computing cost wise (has to iterate through the whole
joined table */

/* TASK X
Find the highest-rated movie, and report its title, year, rating, and country. There
can be ties; if so, you should report for each of them.
*/

SELECT movies.title, movies.year, MAX(movies.rating) AS movie_rating, countries.name FROM movies
JOIN movie_countries ON movie_countries.movie_id = movies.movie_id
JOIN countries ON countries.country_id = movie_countries.country_id
ORDER BY movies.rating DESC;

/* There's only one movie with rating 9.2? doesn't seem to be ties */

/* STRETCH BONUS
Find the pairs of people that have directed at least 5 movies and whose 
carees do not overlap (i.e. The release year of a director's last movie is 
lower than the release year of another director's first movie).
*/
