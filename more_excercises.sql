USE sakila;
SHOW tables;

-- 1.
-- a.
SELECT * FROM actor;
-- b.
SELECT last_name FROM actor;
-- c.
SELECT film_id, title, release_year FROM film;

-- 2.
-- a.
SELECT DISTINCT last_name FROM actor;
-- b.
SELECT DISTINCT postal_code FROM address;
-- c.
SELECT DISTINCT rating FROM film;

-- 3.
-- a.
SELECT title, description, rating, length FROM film
	WHERE length >= 60*3;
-- b.
SELECT payment_id, amount,payment_date FROM payment
	WHERE payment_date >= '2005-05-27';
-- c.
SELECT payment_id, amount, payment_date FROM payment
    WHERE payment_date >= '2005-05-27';
-- d.
SELECT * FROM customer
	WHERE last_name LIKE 'S%' 
		AND first_name LIKE '%n';
-- e.
SELECT * FROM customer
	WHERE active=1
		AND last_name LIKE 'M%';
-- f.
DESCRIBE category;
SELECT * FROM category
	WHERE category_id > 4
		AND (name LIKE 'C%'
        OR name LIKE 'S%'
        OR name LIKE 'T%');
-- g.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff
	WHERE password IS NULL;
-- h.
SELECT staff_id, first_name, last_name, address_id, picture, email, store_id, active, username, last_update FROM staff
	WHERE password IS NOT NULL;
    
-- 4.
-- a.
DESCRIBE address;
SELECT phone, district
	FROM address
    WHERE district IN ('California', 'England', 'Taipei', 'West Java');
-- b.
DESCRIBE payment;
SELECT * FROM payment;
SELECT payment_id, amount, payment_date 
	FROM payment
    WHERE DATE(payment_date) IN ('2005-05-25','2005-05-27','2005-05-29');
-- c.
SELECT * FROM film;
SELECT *
	FROM film
    WHERE rating IN ('G', 'PG-13', 'NC-17');

-- 5.
-- a.
SELECT * FROM payment
	WHERE payment_date 
		BETWEEN '2005-05-25 00:00:00' 
			AND '2005-05-26 23:59:59';
-- b.
SELECT film_id, title, description
	FROM film
    WHERE LENGTH(description) BETWEEN 100 AND 120;
    
-- 6.
-- a.
SELECT * FROM film
	WHERE description LIKE 'A Thoughtful%';
-- b.
SELECT * FROM film
	WHERE description LIKE '%Boat';
-- c.
SELECT * FROM film
	WHERE description LIKE '%Database%'
		AND length > 180;
        
-- 7.
-- a.
SELECT * FROM payment
	LIMIT 20;
-- b.
SELECT payment_date, amount FROM payment
	WHERE amount > 5 AND payment_id BETWEEN 1000 AND 2000;
-- c.
SELECT * FROM customer
	LIMIT 100 OFFSET 100;

-- 8.
-- a.
SELECT * FROM film
	ORDER BY length ASC;
-- b.
SELECT DISTINCT rating FROM film
	ORDER BY rating DESC;
-- c.
SELECT payment_date, amount FROM payment
	ORDER BY amount DESC
    LIMIT 20;
-- d.
SELECT * FROM film;
SELECT title, description, special_features, length, rental_duration FROM film
	WHERE special_features LIKE '%Behind the Scenes%'
		AND length<120
        AND rental_duration BETWEEN 5 AND 7
	ORDER BY length DESC;
    
-- 9. 
-- a.
DESCRIBE customer;
DESCRIBE actor;
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name as actor_first_name, a.last_name AS actor_last_name
	FROM customer AS c
		LEFT JOIN actor AS a ON c.last_name=a.last_name;

-- b.
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name as actor_first_name, a.last_name AS actor_last_name
	FROM customer AS c
		RIGHT JOIN actor AS a ON c.last_name=a.last_name;
        
-- c.
SELECT c.first_name AS customer_first_name, c.last_name AS customer_last_name, a.first_name as actor_first_name, a.last_name AS actor_last_name
	FROM customer AS c
		JOIN actor AS a ON c.last_name=a.last_name;

-- d.
DESCRIBE city;
DESCRIBE country;
SELECT city, country
	FROM city
		LEFT JOIN country USING (country_id);
        
-- e.
DESCRIBE film;
SELECT title, description, release_year, name
	FROM film
		LEFT JOIN language USING (language_id);
        
-- f.
DESCRIBE staff;
DESCRIBE address;
DESCRIBE city;
SELECT first_name, last_name, address, address2, city, district, postal_code
	FROM staff
		LEFT JOIN address USING (address_id)
        LEFT JOIN city USING (city_id);
        
-- part II
-- 1.
SELECT LOWER(first_name), LOWER(last_name)
	FROM actor;
    
-- 2.
DESCRIBE actor;
SELECT first_name, last_name, actor_id
	FROM actor
	WHERE first_name='Joe';
    
-- 3.
SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE '%gen%';
    
-- 4.
SELECT last_name, first_name
	FROM actor
    WHERE last_name LIKE '%li%'
    ORDER BY last_name, first_name;

-- 5.
SELECT country, country_id
	FROM country
    WHERE country IN ('Afghanistan', 'Bangladesh', 'China');
    
-- 6.
SELECT last_name, count(last_name)
	FROM actor
    GROUP BY last_name;
    
-- 7.
SELECT last_name, COUNT(last_name)
	FROM actor
    GROUP BY last_name
    HAVING COUNT(last_name)>=2;
    
-- 8.
SHOW CREATE TABLE address;

-- 9.
DESCRIBE staff;
DESCRIBE address;
SELECT first_name, last_name, address, address2
	FROM staff
	JOIN address USING (address_id);
    
-- 10.
SELECT CONCAT(first_name, ' ', last_name) AS staff_member, SUM(amount) AS total_sales
	FROM staff
    JOIN payment USING (staff_id)
    GROUP BY staff_id;

-- 11.
SELECT title, COUNT(actor_id) AS num_of_actors
	FROM film
    JOIN film_actor USING (film_id)
    GROUP BY film_id;
    
-- 12.
SELECT title, COUNT(film_id) AS num_copies
	FROM film
    JOIN inventory USING (film_id)
    GROUP BY film_id
    HAVING title='Hunchback Impossible';
    
-- 13.
SELECT title
	FROM film
    JOIN language USING (language_id)
    WHERE title LIKE 'K%' OR title LIKE 'Q%';
    
-- 14.
-- subquery to get the actor_id for all the cast of the film
SELECT actor_id
	FROM film_actor
		JOIN film USING (film_id)
	WHERE title='Alone Trip';
-- get the actor names using IN operator
SELECT first_name, last_name
	FROM actor
    WHERE actor_id IN (SELECT actor_id
							FROM film_actor
								JOIN film USING (film_id)
							WHERE title='Alone Trip');
                            
-- 15.
-- use a subquery to get all the city_id that are in canada
SELECT city_id
	FROM city
		JOIN country USING (country_id)
    WHERE country= 'Canada';
-- now get customer info
SELECT first_name, last_name, email
	FROM customer
		JOIN address USING (address_id)
	WHERE city_id IN (SELECT city_id
						FROM city
							JOIN country USING (country_id)
						WHERE country= 'Canada');

-- 16.
SELECT * from category;
-- get the film_id for family films
SELECT film_id
	FROM film_category
		JOIN category USING (category_id)
	WHERE name='Family';
-- now get film names 
SELECT title
	FROM film
    WHERE film_id IN (SELECT film_id
						FROM film_category
							JOIN category USING (category_id)
						WHERE name='Family');

-- 17.
-- get payment by staff_id
SELECT store_id, SUM(amount)
	FROM payment
		JOIN staff USING (staff_id)
    GROUP BY store_id;

-- 18.
SELECT store_id, city, country
	FROM store
		JOIN address USING (address_id)
        JOIN city USING (city_id)
        JOIN country USING (country_id);
        
-- 19.
-- get gross revenue per category_id
SELECT SUM(amount) AS revenue, name
	FROM payment
		JOIN rental USING (rental_id)
        JOIN inventory USING (inventory_id)
        JOIN film_category USING (film_id)
        JOIN category USING (category_id)
	GROUP BY category_id
    ORDER BY revenue DESC
    LIMIT 5;
		
-- part III

