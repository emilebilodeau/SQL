/* SQL Exercise
====================================================================
We will be working with database chinook.db
You can download it here: https://drive.google.com/file/d/0Bz9_0VdXvv9bWUtqM0NBYzhKZ3c/view?usp=sharing

 The Chinook Database is about an imaginary video and music store. Each track is stored using one of the digital formats and has a genre. The store has also some playlists, where a single track can be part of several playlists. Orders are recorded for customers, but are called invoices. Every customer is assigned a support employee, and Employees report to other employees.
*/


-- MAKE YOURSELF FAIMLIAR WITH THE DATABASE AND TABLES HERE





--==================================================================
/* TASK I
Which artists did not make any albums at all? Include their names in your answer.
*/

SELECT artists.name FROM artists WHERE artists.name NOT IN
(SELECT artists.name FROM artists
JOIN albums ON albums.ArtistId = artists.ArtistId); 

/* TASK II
Which artists recorded any tracks of the Latin genre?
*/

/* Lating genreId = 7, how to split up composers? */


/* TASK III
Which video track has the longest length?
*/

/* videofile MediaTypeId = 3 */

SELECT tracks.Name, tracks.Milliseconds FROM tracks
JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
WHERE tracks.MediaTypeId = 3
ORDER BY tracks.Milliseconds DESC;

/* TASK IV
Find the names of customers who live in the same city as the top employee (The one not managed by anyone).
*/

/* top employee ID is 1, lives in Edmonton */

SELECT customers.FirstName, customers.Lastname FROM customers
WHERE customers.city = "Edmonton";

/* TASK V
Find the managers of employees supporting Brazilian customers.
*/

SELECT employees.FirstName, employees.LastName FROM employees
JOIN (
SELECT employees.FirstName, employees.LastName, employees.ReportsTo 
FROM employees
JOIN customers ON customers.SupportRepId = employees.EmployeeId
WHERE customers.Country = 'Brazil') AS table2
ON table2.ReportsTo = employees.EmployeeId
GROUP BY employees.FirstName, employees.LastName;

/* TASK VI
Which playlists have no Latin tracks?
*/

SELECT playlists.Name FROM playlists
JOIN playlist_track ON playlist_track.PlaylistId = playlists.PlaylistId
WHERE playlist_track.TrackId NOT IN
(SELECT tracks.name FROM tracks
JOIN genres ON genres.GenreId = tracks.GenreId
WHERE genres.Name = 'Latin')
GROUP BY playlists.Name;

/* Not sure this one is working as intended, hard to see */