USE sakila;

-- 1

SELECT DISTINCT title
	FROM film;
    
-- 2

SELECT title
	FROM film
    WHERE rating = "PG-13";
    
-- 3 

SELECT title, description -- NO FUNCIONA
	FROM film
    WHERE description = "amazing";
    

SELECT title, description -- COMPROBACIÓN
	FROM film
    WHERE description LIKE "%amazing%";
    
-- 4

SELECT title, length -- COMPROBACIÓN
	FROM film
    WHERE length > 120;
    
-- 5

SELECT first_name, last_name
	FROM actor;
    
-- 6 ESTOY EN LA DUDA, VOY A PONER LAS DOS, ME DAN EL MISMO RESULTADO

SELECT first_name, last_name  
	FROM actor
    WHERE last_name = "Gibson";
    
SELECT first_name, last_name
	FROM actor
    WHERE last_name LIKE "%Gibson%";
    
-- 7

SELECT first_name, last_name, actor_id -- COMPROBACIÓN
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
-- 8

SELECT title, rating -- COMPROBACIÓN
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
-- 9
   
SELECT rating, COUNT(film_id) AS TotalPelículas
	FROM film
    GROUP BY rating;
    
-- 10
    
SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS TotalPelicilasALquiladas
	FROM customer AS c
    INNER JOIN rental AS r
    ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
   
-- QUERIA VER LA DIFERENCIA

   SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS TotalPelicilasALquiladas
	FROM customer AS c
    LEFT JOIN rental AS r 
    ON c.customer_id = r.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
-- 11

SELECT name, COUNT(rental_id) AS TotalRecuento
	FROM category AS ca
    INNER JOIN film_category AS fc
		ON ca.category_id = fc.category_id
    INNER JOIN film AS f
		ON fc.film_id = f.film_id
    INNER JOIN inventory AS i
		ON f.film_id = i.film_id
    INNER JOIN rental AS r
		ON i.inventory_id = r.inventory_id
	GROUP BY name;
    
-- 12

SELECT rating, AVG(length)
	FROM film
    GROUP BY rating;
    
SELECT rating, ROUND(AVG(length), 2)-- MEJOR ASI
	FROM film
    GROUP BY rating;
    
-- 13

SELECT a.first_name, a.last_name, title -- COMPROBACIÓN
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    WHERE title = "Indian Love";
    
-- 14

SELECT title, description -- no se si agregar la descripccion. COMPROBACIÓN
	FROM film
    WHERE description LIKE "%dog%" OR description LIKE "%cat%";
    
-- 15

SELECT a.actor_id -- NO HAY NINGUNO
	FROM actor AS a
    LEFT JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id
    WHERE fa.film_id IS NULL;

-- 16

SELECT title, release_year -- COMPROBACIÓN
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
SELECT DISTINCT release_year-- COMPROBACIÓN
	FROM film;
    
-- 17

SELECT title, name -- nombre columna (name) para comprobar
	FROM film AS f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
    INNER JOIN category AS ca
		ON fc.category_id = ca.category_id
    WHERE ca.name = "Family";

-- 18

SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id)
	FROM actor AS a
    INNER JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, first_name, a.last_name
    HAVING COUNT(fa.film_id) > 10;
    
-- 19

SELECT title, rating, length -- COMPROBACIÓN
	FROM film
    WHERE rating = "R" AND length > 120;
    
-- 20

SELECT ca.name, AVG(length)
	FROM category AS ca
    INNER JOIN film_category AS fc
		ON ca.category_id = fc.category_id
    INNER JOIN film AS f
		ON fc.film_id = f.film_id
    GROUP BY ca.name
    HAVING AVG(length) > 120;
    
-- 21
    
SELECT a.actor_id, a.first_name, COUNT(fa.film_id)
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY a.actor_id, a.first_name
    HAVING COUNT(fa.film_id) >= 5
    ORDER BY COUNT(fa.film_id) ASC; -- COMPROBACIÓN
   
-- 22

SELECT film_id -- subconsulta
	  FROM film AS f
		  INNER JOIN inventory AS i
			  ON f.film_id = i.film_id
		  INNER JOIN rental AS r
			  ON i.inventory_id = r.inventory_id
		  WHERE DATEDIFF(r.return_date, r.rental_date) > 5;

SELECT DISTINCT title 
	FROM film
    WHERE film_id IN ( SELECT f.film_id
							  FROM film AS f
								  INNER JOIN inventory AS i
									  ON f.film_id = i.film_id
								  INNER JOIN rental AS r
									  ON i.inventory_id = r.inventory_id
								  WHERE DATEDIFF(r.return_date , r.rental_date) > 5); -- ESTO ES NUEVO, NO LO HEMOS VISTO EN CLASE
                                  
 

-- 23
          
SELECT a.first_name, a.last_name, name-- SUBCONSULTA + COMPROVACIÓN
	FROM actor AS a
	INNER JOIN film_actor AS fa
    ON a.actor_id = fa.actor_id
		INNER JOIN film AS f
			ON fa.film_id = f.film_id
		INNER JOIN film_category AS fc
			ON f.film_id = fc.film_id
		INNER JOIN category AS ca
			ON fc.category_id = ca.category_id
		WHERE ca.name = "Horror";
          
SELECT a.first_name, a.last_name -- SUBCONSULTA CORRELACIONADA
	FROM actor AS a
    WHERE NOT EXISTS ( SELECT *
							FROM film_actor AS fa2
								INNER JOIN film AS f2
									ON fa2.film_id = f2.film_id
								INNER JOIN film_category AS fc2
									ON f2.film_id = fc2.film_id
								INNER JOIN category AS ca2
									ON fc2.category_id = ca2.category_id
								WHERE ca2.name = "Horror" AND fa2.actor_id = a.actor_id);
                                
-- 24

SELECT f.title, f.length -- COMPROVACIÓN
	FROM film as f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
    INNER JOIN category AS ca
		ON fc.category_id = ca.category_id
	WHERE ca.name = "Comedy" AND f.length > 180;
    
        
						  
					



    
    