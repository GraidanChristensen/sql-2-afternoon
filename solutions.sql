SELECT *
FROM invoice
JOIN invoice_line il ON il.invoice_id = invoice.invoice_id
WHERE il.unit_price > 0.99;

SELECT i.invoice_date, i.total, c.first_name, c.last_name
FROM invoice i
JOIN customer c ON i.customer_id = c.customer_id;

SELECT c.first_name, c.last_name, e.first_name, e.last_name
FROM customer c
JOIN employee e ON c.support_rep_id = e.employee_id;

SELECT album.title, artist.name
FROM album
JOIN artist ON album.artist_id = artist.artist_id;

SELECT pt.track_id
FROM playlist_track pt
JOIN playlist p ON p.playlist_id = pt.playlist_id
WHERE p.name = 'Music';

SELECT track.name
FROM track
JOIN playlist_track pt ON pt.track_id = track.track_id
WHERE pt.playlist_id = 5;

SELECT track.name, p.name
FROM track
JOIN playlist_track pt ON pt.track_id = track.track_id
JOIN playlist p on pt.playlist_id = p.playlist_id;

SELECT t.name, a.title
FROM track t
JOIN album a ON t.album_id = a.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Alternative & Punk';

SELECT *
FROM invoice
WHERE invoice_id
IN( SELECT invoice_id 
   FROM invoice_line
   WHERE unit_price > 0.99);

SELECT * 
FROM playlist_track
WHERE playlist_id
IN(
  SELECT playlist_id
  FROM playlist
  WHERE name = 'Music'
  );

  SELECT name
FROM track
WHERE track_id
IN (
  SELECT track_id
  FROM playlist_track
  WHERE playlist_id = 5
  );

  SELECT *
FROM track
WHERE genre_id
IN (
  SELECT genre_id
  FROM genre
  WHERE name = 'Comedy'
  );

  SELECT * 
FROM track
WHERE album_id
IN (
  SELECT album_id
  FROM album
  WHERE title = 'Fireball'
  );

  SELECT * 
FROM track
WHERE album_id
IN (
  SELECT album_id
  FROM album
  WHERE artist_id
  IN (
    SELECT artist_id
    FROM artist
    WHERE name = 'Queen'
    )
  );

UPDATE customer
SET fax = null
WHERE fax IS NOT null;

UPDATE customer
SET company = 'Self'
WHERE company IS NULL;

UPDATE customer
SET last_name = 'Thompson'
WHERE first_name = 'Julia' AND last_name = 'Barnett';

UPDATE customer 
SET support_rep_id = 4
WHERE email = 'luisrojas@yahoo.cl';

UPDATE track
SET composer = 'The darkness around us'
WHERE genre_id = ( SELECT genre_id FROM genre WHERE name = 'Metal' )
AND composer IS null;

SELECT COUNT(*), g.name
FROM track
JOIN genre g ON track.genre_id = g.genre_id
GROUP BY g.name;

SELECT COUNT(*), g.name
FROM track
JOIN genre g ON track.genre_id = g.genre_id
WHERE g.name = 'Pop' OR g.name = 'Rock'
GROUP BY g.name;

SELECT COUNT(*), artist.name
FROM artist
JOIN album al ON artist.artist_id = al.artist_id
GROUP BY artist.name;

SELECT DISTINCT composer 
FROM track;

SELECT DISTINCT billing_postal_code
FROM invoice;

SELECT DISTINCT company
FROM customer;

DELETE 
FROM practice_delete 
WHERE type = 'bronze';

DELETE
FROM practice_delete 
WHERE type = 'silver';

DELETE 
FROM practice_delete
WHERE value = 150;



ECOMMERCE
CREATE TABLE users
(user_id SERIAL PRIMARY KEY, 
 name VARCHAR(50), 
 email VARCHAR(50)
 );

 CREATE TABLE products
(product_id SERIAL PRIMARY KEY,
 name VARCHAR(50),
 price INT
 );

CREATE TABLE orders
(
 order_id INT,
 user_id INT REFERENCES users(user_id),
 product_id INT REFERENCES products(product_id)
 );


INSERT INTO users
(name, email)
VALUES('Graidan', 'graidan@ggg')
INSERT INTO users
(name, email)
VALUES('Collin', 'collin@ccc');
INSERT INTO users
(name, email)
VALUES('Cole', 'cole@ccc');

INSERT INTO products
(name, price)
VALUES('Shirt', 15);
INSERT INTO products
(name, price)
VALUES('Pants', 30);
INSERT INTO products
(name, price)
VALUES('Hat', 15);

 INSERT INTO orders (order_id, user_id, product_id)
 VALUES(1, 1, 1),
 (1, 1, 3),
 (2, 2, 1),
 (3, 3, 1),
 (3, 3, 2);

SELECT o.order_id, p.name 
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_id = 1;

SELECT * FROM orders;

SELECT SUM(p.price), o.order_id
FROM orders o
JOIN products p ON p.product_id = o.product_id
WHERE o.order_id = 3
GROUP BY o.order_id;

SELECT o.*
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.user_id = 1;

SELECT count(*), u.user_id
FROM orders o
JOIN users u ON u.user_id = o.user_id
WHERE u.user_id = 3
GROUP BY u.user_id;