-- Group 6: Zaitsev, Mahfoud, Frania

-- The software that was used: PostgreSQL, pgAdmin4.
-- All queries were run using QueryTool.
-- Before running the queries, make sure to create a database.
-- Total runtime: 306s (s=seconds).

-- Problem 1

-- Total runtime for Problem 1: 266s
-- Before running queries for Problem 1(a) make sure to change 'path_to_***.tsv' to respective .tsv files.

-- Problem 1 (a)

-- create table Ratings and copy data from title.ratings.tsv file into it
-- runtime: 2s
DROP TABLE IF EXISTS Ratings;
CREATE TABLE Ratings (
        tid char(10),
        avg_rating numeric,
        num_votes numeric);
COPY Ratings FROM 'path_to_title.ratings.tsv' WITH NULL '\N' ENCODING 'UTF8' DELIMITER E'\t' QUOTE E'\b' CSV HEADER;
SELECT * FROM Ratings LIMIT 100;

-- create table Principals and copy data from title.principals.tsv file into it
-- runtime: 92s
DROP TABLE IF EXISTS Principals;
CREATE TABLE Principals (
	tid char(10),
	ordering int,
	nid char(10),
	category varchar(32),
	job varchar(512),
	characters varchar(2048));
COPY Principals FROM 'path_to_title.principals.tsv' WITH NULL '\N' ENCODING 'UTF8' DELIMITER E'\t' QUOTE E'\b' CSV HEADER;
SELECT * FROM Principals LIMIT 100;

-- create table Persons and copy data from name.basics.tsv file into it
-- runtime: 22s
DROP TABLE IF EXISTS Persons;
CREATE TABLE Persons (
	nid char(10),
	primaryName varchar(128),
	birthYear int,
	deathYear int,
	primaryProfession varchar(128),
	knownForTitles varchar(128));
COPY Persons FROM 'path_to_name.basics.tsv' NULL '\N' ENCODING 'UTF8' DELIMITER E'\t' QUOTE E'\b' CSV HEADER;
SELECT * FROM Persons LIMIT 100;

-- create table Titles and copy data from title.basics.tsv file into it
-- runtime: 28s
DROP TABLE IF EXISTS Titles;
CREATE TABLE Titles (
	tid char(10),
	ttype varchar(12),
	primaryTitle varchar(1024),
	originalTitle varchar(1024),
	isAdult int,
	startYear int,
	endYear int,
	runtimeMinutes int,
	genres varchar(256));
COPY Titles FROM 'path_to_title.basics.tsv' NULL '\N' ENCODING 'UTF8' DELIMITER E'\t' QUOTE E'\b' CSV HEADER;
SELECT * FROM Titles LIMIT 100;

-- Problem 1 (b)

-- create table Movie with specific attributes as shown in E/R schema for Problem 1
DROP TABLE IF EXISTS Movie CASCADE;
CREATE TABLE Movie (
	tid char(10),
	title varchar(1024),
	year int,
	length int,
	rating numeric);

-- create table Directs with specific attributes as shown in E/R schema for Problem 1
DROP TABLE IF EXISTS Directs CASCADE;
CREATE TABLE Directs (
	nid char(10),
	tid char(10));

-- create table Director with specific attributes as shown in E/R schema for Problem 1
DROP TABLE IF EXISTS Director CASCADE;
CREATE TABLE Director (
	nid char(10),
	name varchar(128),
	birthYear int,
	deathYear int);

-- create table StarsIn with specific attributes as shown in E/R schema for Problem 1
DROP TABLE IF EXISTS StarsIn CASCADE;
CREATE TABLE StarsIn (
	nid char(10),
	tid char(10));

-- create table Actor with specific attributes as shown in E/R schema for Problem 1
DROP TABLE IF EXISTS Actor CASCADE;
CREATE TABLE Actor (
	nid char(10),
	name varchar(128),
	birthYear int,
	deathYear int);

-- Problem 1 (c)

-- here we join Titles and Ratings where Titles.tid=Ratings.tid
-- then make sure to insert only those titles where ttype='movie'
-- and number of votes for that movie num_votes >= 10000
-- then do descending sort and pick top 5000 movies from the join result
-- runtime: 3s
INSERT INTO Movie (
    SELECT DISTINCT
        t.tid,
        t.primaryTitle AS title, 
        t.startYear AS year,
        t.runtimeMinutes AS length,
        r.avg_rating AS rating
    FROM Titles AS t 
    JOIN Ratings AS r ON t.tid = r.tid
    WHERE t.ttype = 'movie' AND r.num_votes >= 10000
    ORDER BY r.avg_rating DESC 
    LIMIT 5000
);

-- here we join Persons and Principals where Persons.nid=Principals.nid
-- and then pick only those people whose Principals.category='actor' or Principals.category='actress'
-- and whose Principals.tid in Movie
-- we could not do that without the join, since Principals does not contain person's data, but Persons does
-- runtime: 62s
INSERT INTO Actor (
    SELECT DISTINCT 
        p1.nid, 
        p1.primaryName AS name,
        p1.birthYear,
        p1.deathYear
    FROM Persons AS p1
    JOIN Principals AS p2 ON p1.nid = p2.nid
    WHERE 
		(p2.category = 'actor' OR p2.category = 'actress') 
		AND 
		p2.tid IN (SELECT tid FROM Movie)
);

-- same steps here as in Actor
-- but Principals.category='director'
-- runtime: 54s
INSERT INTO Director (
    SELECT DISTINCT 
        p1.nid, 
        p1.primaryName AS name,
        p1.birthYear,
        p1.deathYear
    FROM Persons AS p1
    JOIN Principals AS p2 ON p1.nid = p2.nid
    WHERE
        p2.category = 'director'
        AND 
		p2.tid IN (SELECT tid FROM Movie)
);

-- here we select only those people whose Principals.category='director
-- and Principals.tid in Movie
-- Directs might contain duplicate nid or tid, but no duplicate combinations of nid and tid
-- runtime: 9s
INSERT INTO Directs (
    SELECT DISTINCT 
        nid, 
        tid
    FROM Principals
    WHERE
        category = 'director'
        AND 
		tid IN (SELECT tid FROM Movie)
);

-- here we select only those people whose Principals.category='actor' or Principals.category='actress'
-- and Principals.tid in Movie
-- StarsIn migth contain duplicate nid or tid, but no duplicate combinations of nid and tid
-- runtime: 12s
INSERT INTO StarsIn (
    SELECT DISTINCT 
        nid, 
        tid
    FROM Principals
    WHERE
        (category = 'actor' OR category='actress')
        AND 
		tid IN (SELECT tid FROM Movie)
);

-- check that Movie has only unique tid
-- runtime: <1s
SELECT Movie.tid, COUNT(*)
FROM Movie
GROUP BY Movie.tid
HAVING COUNT(*) > 1;

-- check that Actor has only unique nid
-- runtime: <1s
SELECT Actor.nid, COUNT(*)
FROM Actor
GROUP BY Actor.nid
HAVING COUNT(*) > 1;

-- check that Director has only unique nid
-- runtime: <1s
SELECT Director.nid, COUNT(*)
FROM Director
GROUP BY Director.nid
HAVING COUNT(*) > 1;

-- Problem 1 (d)

-- 1) Movie: 
--	  	Non-trivial FDs: 
--			{tid} -> {title, year, length, rating}
--			{title, year} -> {length, rating}
--			plus those derivable from the axioms
-- 		Keys: 
--			{tid} 
--			{title, year}
--		Normal Form: BCNF, since: 
--			1NF - all attributes are atomic (true)
--			2NF - for every non-trivial FD X -> Y it holds that X is not a proper subset of key of Movie (true)
--			3NF - for every non-trivial FD X -> Y it holds that X is a superkey of Movie (true)
--			BCNF - for every non-trivial FD X -> Y it holds that X is a superkey of Movie (true)
-- 2) Director:
--	  	Non-trivial FDs: 
--			{nid} -> {name, birthYear, deathYear}
--			plus those derivable from the axioms
-- 		Keys: 
--			{nid}
--		Normal Form: BCNF
-- 3) Actor: 
--	  	Non-trivial FDs: 
--			{nid} -> {name, birthYear, deathYear}
--			plus those derivable from the axioms
-- 		Keys: 
--			{nid}
--		Normal Form: BCNF 
-- 4) Directs:
--	  	Non-trivial FD: None
-- 		Keys: 
--			{nid, tid}
--		Normal Form: BCNF 
-- 5) StarsIn: 
--	  	Non-trivial FD: None
-- 		Keys: 
--			{nid, tid}
--		Normal Form: BCNF 

-- Problem 2 (a)

-- make tid as primary key as discussed in Problem 1 (d)
-- runtime: <1s
ALTER TABLE Movie
ADD PRIMARY KEY (tid);

-- make nid as primary key as discussed in Problem 1 (d)
-- runtime: <1s
ALTER TABLE Director
ADD PRIMARY KEY (nid);

-- make nid as primary key as discussed in Problem 1 (d)
-- runtime: <1s
ALTER TABLE Actor
ADD PRIMARY KEY (nid);

-- make combination (nid, tid) as primary key as discussed in Problem 1 (d)
-- then add foreign key constraint on nid pointing to Director
-- and another foreign key constraint on tid pointing to Movie
-- runtime: <1s
ALTER TABLE Directs
ADD PRIMARY KEY (nid, tid);
ALTER TABLE Directs
ADD FOREIGN KEY (nid) REFERENCES Director(nid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Directs
ADD FOREIGN KEY (tid) REFERENCES Movie(tid) ON UPDATE CASCADE ON DELETE CASCADE;

-- make combination (nid, tid) as primary key as discussed in Problem 1 (d)
-- then add foreign key constraint on nid pointing to Actor
-- and another foreign key constraint on tid pointing to Movie
-- runtime: <1s
ALTER TABLE StarsIn
ADD PRIMARY KEY (nid, tid);
ALTER TABLE StarsIn
ADD FOREIGN KEY (nid) REFERENCES Actor(nid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE StarsIn
ADD FOREIGN KEY (tid) REFERENCES Movie(tid) ON UPDATE CASCADE ON DELETE CASCADE;

-- drop unused tables to free memory
-- runtime: 3s
DROP TABLE IF EXISTS Ratings;
DROP TABLE IF EXISTS Principals;
DROP TABLE IF EXISTS Persons;
DROP TABLE IF EXISTS Titles;

-- Problem 2 (b)

-- runtime: <1s
SELECT nid FROM Director WHERE name = 'Steven Spielberg'; -- returns 'nm0000229'
SELECT nid, tid FROM Directs WHERE nid = 'nm0000229'; -- returns 26 tuples for nid='nm0000229'
UPDATE Director SET nid = '123456789' WHERE name = 'Steven Spielberg'; -- update Steven Spielberg's nid to '123456789'
SELECT nid FROM Director WHERE name = 'Steven Spielberg'; -- returns '123456789'
SELECT * FROM Directs WHERE nid = '123456789'; -- returns same 26 tid's for nid='123456789' as for nid='nm0000229' before the update, thus verifying the cascading behaviour of Directs nid foreign key

-- Problem 2 (с)

-- runtime: <1s
SELECT nid FROM Actor WHERE name = 'Robert De Niro'; -- returns 'nm0000134'
SELECT * FROM Directs WHERE nid = 'nm0000134'; -- empty return
SELECT * FROM StarsIn WHERE nid = 'nm0000134'; -- returns 33 tuples for nid='nm0000134'
DELETE FROM Actor WHERE name = 'Robert De Niro'; -- DELETE 1
DELETE FROM Director WHERE name = 'Robert De Niro'; -- DELETE 0
SELECT * FROM Directs WHERE nid = 'nm0000134'; -- empty return, not verifying anything, since his nid was not in Director table
SELECT * FROM StarsIn WHERE nid = 'nm0000134'; -- empty return, thus verifying the cascading behaviour of StarsIn nid foreign key

-- Problem 2 (d)

-- try to insert into Directs nid that exists in Director
-- and insert tid that does not exist in Movie
-- same for StarsIn, but with non-existing nid
-- runtime: <1s
INSERT INTO Directs (nid, tid) VALUES ('123456789', 'tt9999999'); -- get "Key (tid)=(tt9999999) is not present in table 'movie'" error, since tid='tt9999999' does not exist in Movie
INSERT INTO StarsIn (nid, tid) VALUES ('nm9999999', 'tt0068646'); -- get "Key (nid)=(nm9999999) is not present in table 'actor'" error, since nid='nm9999999' does not exist in Actor

-- Problem 2 (e)

-- try to change existing tid in Movie to non-existing one
-- runtime: <1s
UPDATE Directs 
SET 
	nid='123456789', 
	tid='9999999999'
WHERE nid='123456789' AND tid='tt0073195';
-- get "Key (tid)=(9999999999) is not present in table 'movie'" error, since tid='9999999999' does not exist in Movie

-- same for StarsIn, but with non-existing nid
-- runtime: <1s
UPDATE StarsIn 
SET 
	nid='123456780', 
	tid='tt0027125'
WHERE nid='nm0000001' AND tid='tt0027125';
-- get -- get "Key (nid)=(123456780) is not present in table 'actor'" error, since nid='123456780' does not exist in Actor

-- Problem 3 (a)
-- select the most popular directors based on how many movies they directed
-- stop after the top 25 directors with the most movie
-- and select only those directors who are not in StarsIn

-- we first select each director from Director and count how many movies they have directed using the Directs table 
-- we then sort the directors based on how many movies they have directed in descending order
-- finally we limit our results to the top 25
-- runtime: <1s
SELECT 
	d1.nid,
    d1.name,
    COUNT(d2.nid) AS moviesDirected
FROM
    Director AS d1
JOIN
    Directs AS d2
ON 
    d1.nid = d2.nid 
WHERE
    d1.nid NOT IN (SELECT nid FROM StarsIn)
GROUP BY
	d1.nid, d1.name
ORDER BY 
    moviesDirected DESC 
LIMIT 
    25;

-- Problem 3 (b)
-- select the top 25 pairs of actors that occur together in a same movie
-- ordered by the number of movies in which they co-occur

-- here we perform a self join of the StarsIn table on the title id of the movie
-- which will give us pairs of actors that have co-starred in a movie
-- we also join the Actor table to obtain the names of the actors
-- finally we aggregate the count of movies in which pairs of actors have costarred 
-- as seen above we sort and take the top 25 rows again
-- runtime: <1s
SELECT
    s1.nid,
    a1.name,
    s2.nid,
    a2.name,
    COUNT(*) costarringCount
FROM 
    StarsIn AS s1
JOIN
    StarsIn AS s2
ON 
    s1.tid = s2.tid
JOIN 
    Actor AS a1
ON 
    s1.nid = a1.nid
JOIN 
    Actor AS a2
ON
    s2.nid = a2.nid
WHERE
    s1.nid < s2.nid
GROUP BY
    1, 2, 3, 4
ORDER BY
    costarringCount DESC 
LIMIT 
    25;

-- Problem 3 (c)
-- find frequent 2-itemsets of actors or directors who occurred together in at least 4 movies

-- create an intermediate view where we have the actors and directors with their names using UNION and which we will for convenience call ArtistNames to refer to both actor and director
-- runtime: <1s
CREATE OR REPLACE VIEW ArtistNames AS (
    SELECT nid, name
    FROM Actor 
    UNION
    SELECT nid, name
    FROM Director
);

-- create an intermediate view where we have the actors and the movies they starred in + directors and the movies they directed using the UNION
-- runtime: <1s
CREATE OR REPLACE VIEW Artist AS (
    SELECT tid, nid
    FROM StarsIn 
    UNION
    SELECT tid, nid
    FROM Directs
);

-- here we check for frequent combinations of Movie, Actor/Director pairs
-- runtime: <1s
CREATE OR REPLACE VIEW Artist1 AS (
    SELECT tid, nid
    FROM Artist s 
    WHERE EXISTS (
        SELECT nid 
        FROM Artist s1 
        WHERE s1.nid = s.nid 
        GROUP BY s1.nid 
        HAVING COUNT(s1.tid)>=4)
    );
SELECT * FROM Artist1;

-- finally we find the frequent combinations of 2-itemsets of artists using the A-Priori algorithm and joining with the ArtistNames table to obtain the names of the Actors and Directors 
-- runtime: 1s
SELECT a1.name AS artist_name_1, a2.name AS artist_name_2
FROM Artist1 s1, Artist1 s2, ArtistNames a1, ArtistNames a2
WHERE s1.tid = s2.tid 
AND s1.nid < s2.nid
AND s1.nid = a1.nid 
AND s2.nid = a2.nid
GROUP BY a1.name, a2.name
HAVING COUNT(s1.tid)>=4; 

-- Problem 3 (d)
-- find frequent 3-itemsets of actors or directors who occurred together in at least 4 movies

-- here we check for frequent combinations of Movie, Actor/Director 3-itemsets
-- runtime: <1s
CREATE OR REPLACE VIEW Artist2 AS (
    SELECT s1.tid, s1.nid nid1, s2.nid AS nid2
    FROM Artist1 s1, Artist1 s2
    WHERE s1.tid = s2.tid 
    AND s1.nid < s2.nid
    AND EXISTS (
        SELECT s3.nid, s4.nid
        FROM Artist1 s3, Artist1 s4
        WHERE s3.tid = s4.tid 
            AND s1.nid = s3.nid
            AND s2.nid = s4.nid
            AND s3.nid < s4.nid
        GROUP BY  s3.nid, s4.nid
        HAVING COUNT(s3.tid)>=4
    )
  );

-- finally we find the frequent combinations of 3-itemsets of artists using the A-Priori algorithm and joining with the ArtistNames table to obtain the names of the Actors and Directors 
-- runtime: 11s
SELECT a1.name AS artist_name_1, a2.name AS artist_name_2, a3.name AS artist_name_3
FROM Artist2 s1, Artist2 s2, ArtistNames a1, ArtistNames a2, ArtistNames a3
WHERE s1.tid = s2.tid
    AND s1.nid1 = s2.nid1 
    AND s1.nid2 < s2.nid2
    AND s1.nid1 = a1.nid 
    AND s1.nid2 = a2.nid
    AND s2.nid2 = a3.nid
GROUP BY a1.name, a2.name, a3.name
HAVING COUNT(s1.tid)>=4;
