Use music_store;

Q1: who is the senior most employee based on the job title?;

select * from employee
order by levels desc
limit 1;

Q2: Which country have the most invoices?;

select billing_country, count(*) as invoices from invoice
group by billing_country
order by invoices desc
limit 1;

Q3: what are top 3 values of total invoices? ;

select * from invoice
order by total desc
limit 3;

Q4: Which city has the best customers? We would like to throw a promotional Music Festival in city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals.
return both the city name & sum of all the invoice totals.; 

select billing_city, sum(total) as sum_total from invoice
group by billing_city
order by sum_total desc
limit 1; 

Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer.
Write a query that returns the person who has spent ths most money.;
select * from customer;

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as sum_total
from customer
join invoice on customer.customer_id= invoice.customer_id
group by customer.customer_id,customer.first_name, customer.last_name
order by sum_total desc
limit 1;


Q6: Write query to return the email, first name & last name Where Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A.;

select customer.email, customer.first_name, customer.last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id= invoice_line.invoice_id
Where track_id in (
       select track.track_id from track 
	   join genre on track.genre_id= genre.genre_id
	   where genre.name = 'Rock'
       )
order by customer.email ;

Q7: Lets invite the artists who have written the most rock music in our dataset. 
Write a query that returns the Artist name and total track count of the top 10 rock bands.;

select artist.artist_id, artist.name, count(artist.artist_id) as no_of_songs
from track
join album2  on album2.album_id = track.album_id
join artist on  artist.artist_id = album2.artist_id
join genre on genre.genre_id = track.genre_id
Where genre.name = 'Rock' 
group by artist.artist_id, artist.name
order by no_of_songs desc
Limit 10;

Q8: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first.;

select name, milliseconds from track 
where milliseconds > (select avg(milliseconds) from track)
order by milliseconds desc;
