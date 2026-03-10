-- EJERCICIO BONUS

/* 25.Encuentra todos los actores que han actuado juntos en al menos una película. 
La consulta debe mostrar el nombre y apellido de los actores y el número de películas en las que han actuado juntos. */

SELECT a1.first_name, a1.last_name, a2.first_name, a2.last_name, COUNT(fa1.film_id) AS total_peliculas -- QUERY FINAL 
	FROM film_actor AS fa1 
    INNER JOIN film_actor AS fa2
		ON fa1.film_id = fa2.film_id
		AND fa1.actor_id < fa2.actor_id 
    INNER JOIN actor AS a1
		ON fa1.actor_id = a1.actor_id
    INNER JOIN actor AS a2
		ON fa2.actor_id = a2.actor_id
    GROUP BY fa1.actor_id, a1.first_name, a1.last_name, fa2.actor_id, a2.first_name, a2.last_name
    HAVING COUNT(fa1.film_id) >= 1
    ORDER BY total_peliculas DESC;

