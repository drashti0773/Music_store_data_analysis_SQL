drop database music_store;
create database music_store;
use music_store;
CREATE TABLE Genre (
	genre_id INT PRIMARY KEY,
	name VARCHAR(120)
);

CREATE TABLE MediaType (
	media_type_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 2. Employee
CREATE TABLE Employees (
	employee_id INT PRIMARY KEY,
	last_name VARCHAR(120),
	first_name VARCHAR(120),
	title VARCHAR(120),
	reports_to INT,
  levels VARCHAR(255),
	birthdate varchar(100),
	hire_date varchar(100),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100)
);

-- 3. Customer
CREATE TABLE Customerss (
	customer_id INT PRIMARY KEY,
	first_name VARCHAR(120),
	last_name VARCHAR(120),
	company VARCHAR(120),
	address VARCHAR(255),
	city VARCHAR(100),
	state VARCHAR(100),
	country VARCHAR(100),
	postal_code VARCHAR(20),
	phone VARCHAR(50),
	fax VARCHAR(50),
	email VARCHAR(100),
	support_rep_id INT,
	FOREIGN KEY (support_rep_id) REFERENCES Employees(employee_id)
);

-- 4. Artist
CREATE TABLE Artist (
	artist_id INT PRIMARY KEY,
	name VARCHAR(120)
);

-- 5. Album
CREATE TABLE Album (
	album_id INT PRIMARY KEY,
	title VARCHAR(160),
	artist_id INT,
	FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
);

-- 6. Track
CREATE TABLE Track (
	track_id INT PRIMARY KEY,
	name VARCHAR(200),
	album_id INT,
	media_type_id INT,
	genre_id INT,
	composer VARCHAR(220),
	milliseconds INT,
	bytes INT,
	unit_price DECIMAL(10,2),
	FOREIGN KEY (album_id) REFERENCES Album(album_id),
	FOREIGN KEY (media_type_id) REFERENCES MediaType(media_type_id),
	FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

-- 7. Invoice
CREATE TABLE Invoice (
	invoice_id INT PRIMARY KEY,
	customer_id INT,
	invoice_date DATE,
	billing_address VARCHAR(255),
	billing_city VARCHAR(100),
	billing_state VARCHAR(100),
	billing_country VARCHAR(100),
	billing_postal_code VARCHAR(20),
	total DECIMAL(10,2),
	FOREIGN KEY (customer_id) REFERENCES Customerss(customer_id)
);

-- 8. InvoiceLine
create table invoice_line ( invoice_line_id int,invoice_id int,track_id bigint,unit_price float,quantity int);



-- 9. Playlist
CREATE TABLE Playlist (
 	playlist_id INT PRIMARY KEY,
	name VARCHAR(255)
);

-- 10. PlaylistTrack
drop table Playlisttrack;
CREATE TABLE Playlisttrack (
	playlist_id INT,
	track_id INT);
	-- PRIMARY KEY (playlist_id, track_id),
	-- FOREIGN KEY (playlist_id) REFERENCES Playlist(playlist_id),
	-- FOREIGN KEY (track_id) REFERENCES Track(track_id));


select * from genre;
select * from MediaType;
select * from Employees;
select * from Customerss;
select * from Artist;
select * from Album;
select * from track;
select * from invoice;
select * from invoice_line;
select * from playlist;
select * from playlistTrack;

-- Task QUESTIONS
-- Q1 1. Who is the senior most employee based on job title? 
select title,levels from employees
order by levels desc
LIMIT 1;



-- Q2 2. Which countries have the most Invoices?

select count(invoice_id), billing_country from invoice
group by billing_country
order by count(invoice_id) desc;


-- Q3 What are the top 3 values of total invoice?
select total from invoice
order by total desc limit 3;

-- Q4  Which city has the best customers? - We would like to throw a promotional Music Festival in the city we made the most money. Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals

select city, count(invoice_id) as count_invoice
from customerss c
join invoice i on i.customer_id=c.customer_id
group by city
order by count_invoice desc;


-- Q5 Who is the best customer? - The customer who has spent the most money will be declared the best customer. Write a query that returns the person who has spent the most money
select first_name,last_name ,count(total) from customerss c join
invoice i on
c.customer_id=i.customer_id
group by first_name,last_name
order by count(total) desc;


-- Q6 Write a query to return the email, first name, last name, & Genre of all Rock Music listeners. Return your list ordered alphabetically by email starting with A
select  c.email,
c.first_name,
c.last_name ,g.name as genre
from customer c join
invoice i on c.customer_id=i.customer_id
join invoice_line ol on i.invoice_id=il.invoice_id
join track t on il.track_id=t.track_id
join genre g on t.genre_id=g.genre_id
where g.name="Rock"
order by c.emailASC;


-- Q7 Let's invite the artists who have written the most rock music in our dataset. Write a query that returns the Artist name and total track count of the top 10 rock bands 

SELECT a.name artist_name, COUNT(t.track_id) AS total
FROM artist a
JOIN album b ON a.artist_id = b.artist_id
JOIN track t ON b.album_id = t.album_id
WHERE lower(b.title) LIKE '%rock%'
GROUP BY a.name,b.title
ORDER BY total DESC
 LIMIT 10;
 
 -- Q8 . Return all the track names that have a song length longer than the average song length.- Return the Name and Milliseconds for each track. Order by the song length, with the longest songs listed first
select name,milliseconds  from track
where milliseconds> (select avg(milliseconds) from track)
order by milliseconds desc;




-- Q9  Find how much amount is spent by each customer on artists? Write a query to return customer name, artist name and total spent
SELECT 
CONCAT(c.first_name, ' ', c.last_name) customer_name,
ar.name  artist_name,
SUM(il.unit_price * il.quantity) AS total_spent
FROM customerss c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN album al ON t.album_id = al.album_id
JOIN artist ar ON al.artist_id = ar.artist_id
GROUP BY c.customer_id, ar.artist_id
ORDER BY total_spent DESC;


-- Q10  We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared, return all Genres
WITH genre_sales AS (
    SELECT 
        c.country,
        g.name AS genre,
        COUNT(il.invoice_line_id) AS purchase_count
    FROM customerss c
    JOIN invoice i ON c.customer_id = i.customer_id
    JOIN invoice_line il ON i.invoice_id = il.invoice_id
    JOIN track t ON il.track_id = t.track_id
    JOIN genre g ON t.genre_id = g.genre_id
    GROUP BY c.country, g.name
),
-- Step 2: Get the maximum purchase count per country
max_sales AS (
    SELECT 
        country,
        MAX(purchase_count) AS max_purchase
    FROM genre_sales
    GROUP BY country
)
-- Step 3: Join both to get top genre(s) per country
SELECT 
    gs.country,
    gs.genre,
    gs.purchase_count
FROM genre_sales gs
JOIN max_sales ms
  ON gs.country = ms.country AND gs.purchase_count = ms.max_purchase
ORDER BY gs.country;



-- Q11 Write a query that determines the customer that has spent the most on music for each country. Write a query that returns the country along with the top customer and how much they spent. For countries where the top amount spent is shared, provide all customers who spent this amount
select * from (
select c.first_name, c.country, sum(total) as total_amount_spent,
rank() over (partition by c.country order by sum(i.total) desc ) as rank1 
from customer c
join invoice i on i.customer_id = c.customer_id
group by c.first_name, c.country
) new1
where rank1 = 1;

