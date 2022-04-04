-- 1) Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in MySQL Workbench as you go.

-- 2) Use the albums_db database.

use albums_db;

-- 3) Explore the structure of the albums table.

describe albums;

    -- a. How many rows are in the albums table?
    
select *
from albums;
        -- 31 rows returned
    
    -- b. How many unique artist names are in the albums table?
    
select distinct artist
from albums;
        -- 23 rows returned 
    
    -- c. What is the primary key for the albums table?
    
describe albums;
        -- id is the primary key for the albums table
    
    -- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
    
select min(release_date), max(release_date)
from albums;
        -- 1967 is the oldest date
        -- 2011 is the most recent date
        
-- 4) Write queries to find the following information:

    -- a. The name of all albums by Pink Floyd
    
select name
from albums
where artist = 'Pink Floyd';

    -- b. The year Sgt. Pepper's Lonely Hearts Club Band was released

select release_date
from albums
where name = 'Sgt. Pepper\'s Lonely Hearts Club Band';

    -- c. The genre for the album Nevermind
    
select genre
from albums
where name = 'Nevermind';

    -- d. Which albums were released in the 1990s
    
select name
from albums
where release_date between 1990 and 1999;

    -- e. Which albums had less than 20 million certified sales
    
select name
from albums
where sales > 20;

    -- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
    
select *
from albums
where genre = 'Rock';
        -- This query will only find results where the genre is listed EXACTLY as "Rock" and will not accept any deviations
        
select *
from albums
where genre like '%Rock%';
        -- This query will find all results where the genre has the word "Rock" anywhere in it
        
-- 5) Be sure to add, commit, and push your work.

