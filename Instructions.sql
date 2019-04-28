USE sakila;

SET SQL_SAFE_UPDATES = 0;

SELECT first_name, last_name
FROM actor;

SELECT CONCAT(first_name, ' ', last_name) as 'Actor Name'
FROM actor;

SELECT first_name, last_name
FROM actor
WHERE first_name LIKE '%Joe%';

SELECT first_name, last_name
FROM actor
WHERE last_name LIKE '%GEN%';

SELECT last_name, first_name
FROM actor
WHERE last_name LIKE '%Li%';

SELECT country_id, country
FROM country
WHERE country_id IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(last_name)As DupActor
FROM actor
GROUP BY last_name;

SELECT last_name, COUNT(last_name) AS Dup
FROM actor
GROUP By last_name
HAVING COUNT(last_name)>1;

UPDATE actor
SET first_name = 'HARPO'
WHERE first_name = 'GROUCHO';

UPDATE actor
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

SELECT last_name, first_name
FROM actor
WHERE last_name = 'WILLIAMS';

SHOW CREATE TABLE address;

SELECT st.first_name, st.last_name, addr.address
FROM staff st
JOIN  address addr
ON st.address_id = addr.address_id;

SELECT s.first_name, s.last_name, SUM(pay.amount) AS Total
FROM staff s 
JOIN payment pay
ON s.staff_id = pay.staff_id AND pay.payment_date LIKE '2005-08%'
GROUP BY s.last_name;

SELECT title, COUNT(actor_id)
FROM film_actor, film
WHERE film.film_id = film_actor.film_id
GROUP BY title;

SELECT COUNT(inventory.film_id) AS Copies
FROM inventory, film
WHERE film.film_id = inventory.film_id AND film.title = 'Hunchback Impossible';

SELECT COUNT first_name, last_name, SUM(amount)
FROM customer, payment
WHERE customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY last_name ASC;


SELECT title FROM film
WHERE language_id in
	(SELECT language_id 
	FROM language
	WHERE name = "English" )
AND (title LIKE "K%") OR (title LIKE "Q%");

SELECT last_name, first_name
FROM actor
WHERE actor_id in
	(SELECT actor_id FROM film_actor
	WHERE film_id in 
		(SELECT film_id FROM film
		WHERE title = "Alone Trip"));
        
SELECT country, last_name, first_name, email
FROM country c
LEFT JOIN customer cu
ON c.country_id = cu.customer_id
WHERE country = 'Canada';


SELECT title, category
FROM film_list
WHERE category = 'Family';

SELECT i.film_id, f.title, COUNT(r.inventory_id)
FROM inventory i
INNER JOIN rental r
ON i.inventory_id = r.inventory_id
INNER JOIN film_text f 
ON i.film_id = f.film_id
GROUP BY r.inventory_id
ORDER BY COUNT(r.inventory_id) DESC;
