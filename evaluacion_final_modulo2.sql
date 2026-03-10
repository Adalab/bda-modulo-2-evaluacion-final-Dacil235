-- Comando USE para acceder a la base de datos.

USE sakila;

-- EJERCICIOS EVALUACIÓN MÓDULO 2. SQL.

-- En ninguno de los ejercicios me indica que ponga un alias, pero voy a ponerlos para que mi ejercicio sea mas visual.

/* 1.Selecciona todos los nombres de las películas sin que aparezcan duplicados.
   En este ejercicio usamos DISTINCT ya que se utiliza para seleccionar valores unicos y asi no aparacen datos duplicados.*/

SELECT DISTINCT title AS TitulosPeliculas
	FROM film;
    
/* 2. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".
   En este consulta necesitamos agregar una condición, con el operador de condición WHERE.*/
   
SELECT title AS TitulosPeliculas
	FROM film
    WHERE rating = "PG-13";
    
/* 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.
   En esta consulta en la condición usamos el operador LIKE, porque el valor esta en una cadena de texto, % por ambos 
   lados porque la palabra puede estar al principio, final o en medio de la frase.*/

SELECT title AS TitulosPeliculas, description AS DescripcionPelicula
	FROM film
    WHERE description LIKE "%amazing%";
    
/* 4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.
   En esta consulta, en la condición usamos el operador de comparación mayor que.*/
   
SELECT title AS TitulosPEliculas
	FROM film
    WHERE length > 120;
    
/* 5.Recupera los nombres de todos los actores.
   En esta conculta usamos el comando básico, ya que nos pide solo información de una tabla sin condiciones.*/
   
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor;
    
/* 6.Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
   En esta consulta voy a poner dos soluciones.*/
   
SELECT first_name AS Nombre, last_name AS Apellidos
	FROM actor
    WHERE last_name = "Gibson"; -- que sea igual a Gibson
   
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name LIKE "Gibson"; -- que contenga Gibson
    
/* 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
   En este ejercicio usamos la cláusula BETWEEN ya que nos dan un rango de busqueda.*/
   
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE actor_id BETWEEN 10 AND 20;
    
/*8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a suclasificación.
  En esta consulta usamos NOT IN ya que usamos más de un valor.*/
  
SELECT title AS TitulosPeliculas
	FROM film
    WHERE rating NOT IN ("R", "PG-13");
    
/* 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.
   En esta consulta utilizamos un COUNT y un GROUP BY para contar todas la peliculas y agruparlas por la clasificación.*/
   
SELECT rating AS Categorias, COUNT(film_id) AS TotalPelículas
	FROM film
    GROUP BY rating;
    
/* 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido 
   junto con la cantidad de películas alquiladas. 
   En este ejercicio usamos la misma lógica que en ejercicio 9 pero los datos están en diferentes tablas entonces utilizamos un JOIN.*/
   
SELECT c.customer_id AS id_Cliente, c.first_name AS NombreCliente, c.last_name AS ApellidosCliente, COUNT(r.rental_id) AS TotalPelicilasALquiladas
	FROM customer AS c
    INNER JOIN rental AS r 
		ON c.customer_id = r.customer_id -- He decidido utilizar un INNER ya que no me especifica si han alquilado alguna vez o no.
    GROUP BY c.customer_id, c.first_name, c.last_name;
    
/* 11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
    Esta consulta sigue la misma lógica que el ejercicio anteriror pero uniendo 5 tablas*/
    
SELECT name AS Categoria, COUNT(rental_id) AS TotalRecuento
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
    
/* 12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la 
   clasificación junto con el promedio de duración.
   En esta consulta usamos la función de agregacion AVG para calcular el promedio de duración y GROUP BY para que lo calcule por cada categoria*/
   
SELECT rating AS Categoria, ROUND(AVG(length), 2) AS PromedioDuracionPelicula -- redondedo para que solo salgan dos decimales y sea mas limpio.
	FROM film
    GROUP BY rating;
    
/* 13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
   En esta consulta utilizamos la misma lógica que en el ejercicio 2 pero uniendo tablas porque los datos están en diferentes tablas.*/
   
SELECT a.first_name AS Nombre, a.last_name AS Apellidos 
	FROM actor AS a -- Uso alias para especificar cada tabla.
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
    WHERE title = "Indian Love";
    
/* 14.Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
    En este ejercicio usamos la misma lógica que en el ejercicio 3 pero como son dos datos incluimos OR.*/
    
SELECT title AS TitulosPeliculas
	FROM film
    WHERE description LIKE "%dog%" OR description LIKE "%cat%";
    
/* 15.Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
   En este ejercicio usamos un LEFT JOIN porque queremos saber si un dato es nulo y asi comprobar si el actor o la actriz
   no aparecen en la película.*/
   
SELECT a.actor_id AS id_Actor
	FROM actor AS a
    LEFT JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    WHERE fa.film_id IS NULL;
    
/* 16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
   En este ejercicio usamos la misma lógica que en el ejercicio 7.*/
   
SELECT title AS TitulosPeliculas
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;
    
/* 17.Encuentra el título de todas las películas que son de la misma categoría que "Family".
   Ejercicio que usa la misma lógica que el ejercicio 2, pero uniendo tablas.*/
   
SELECT title AS TitulosPeliculas
	FROM film AS f
    INNER JOIN film_category AS fc -- Uso INNER para evitar valores nulos, ya que en este ejercicio yo lo interpreto asi.
		ON f.film_id = fc.film_id
    INNER JOIN category AS ca
		ON fc.category_id = ca.category_id
    WHERE ca.name = "Family";
    
/* 18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
   Esta consulta sigue la lógica de varios ejercicios anteriores pero con la diferencia del HAVING.*/

SELECT a.first_name AS Nombre, a.last_name AS Apellido, COUNT(fa.film_id) AS TotalPeliculas
	FROM actor AS a
    INNER JOIN film_actor AS fa 
		ON a.actor_id = fa.actor_id
	GROUP BY a.actor_id, first_name, a.last_name
    HAVING COUNT(fa.film_id) > 10; -- Despues de agrupar los datos los filtramos para que cumplan la condición > 10.
    
/* 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
   Misma lógica que en el ejercicio 2 pero añadiendole un AND para cumplir las dos condicones*/

SELECT title AS TitulosPeliculas
	FROM film
    WHERE rating = "R" AND length > 120;
    
/* 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
   muestra el nombre de la categoría junto con el promedio de duración.
   En es ejercicio usamos la misma lógica que en el ejercicio 18.*/

SELECT ca.name AS Categoria, AVG(length) AS PromedioDuracionPelicula
	FROM category AS ca
    INNER JOIN film_category AS fc
		ON ca.category_id = fc.category_id
    INNER JOIN film AS f
		ON fc.film_id = f.film_id
    GROUP BY ca.name -- agrupados por el nombre de la categoria
    HAVING AVG(length) > 120; -- condicion sobre la función agregada, resultado promedio duracion sobre cada categoria.
    
/* 21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
   con la cantidad de películas en las que han actuado.
   Misma lógica que el ejercicio anterior*/
   
SELECT a.first_name AS Nombre, COUNT(fa.film_id) AS TotalPeliculas
	FROM actor AS a
    INNER JOIN film_actor AS fa
		ON a.actor_id = fa.actor_id
    INNER JOIN film AS f
		ON fa.film_id = f.film_id
	GROUP BY a.actor_id -- lo agrupe por id por si habian actores o actrices con el mismo nombre.
    HAVING COUNT(fa.film_id) >= 5;
    
/* 22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
   subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
   películas correspondientes.
   En este ejercicio utilizamos una subconsulta, en la que buscamos los alquileres superiore a 5 días y en la consulta principal buscamos los
   títulos de las péliculas.*/
   
SELECT DISTINCT title AS TitulosPeliculas -- utilizo DISTINCT para que no se repitan las películas.
	FROM film
    WHERE film_id IN ( SELECT film_id
							  FROM inventory AS i
							  INNER JOIN rental AS r
								ON i.inventory_id = r.inventory_id
							   WHERE DATEDIFF(r.return_date , r.rental_date) > 5); /* Utilizo DATEDIFF que no lo hemos dado en clase pero me lo 
																						recomendaba la IA ya que lo que estaba intentando hacer podia 
                                                                                        darme datos equivocados, es para calcular la diferencia de 
                                                                                        tiempo entre dos fechas.*/
                                                                                        
/* 23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
   "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
   categoría "Horror" y luego exclúyelos de la lista de actores.
   En este ejercicio usamos una subconsulta correlativa*/
   
SELECT a.first_name AS Nombre, a.last_name AS Apellidos
	FROM actor AS a
    WHERE NOT EXISTS ( SELECT * -- NOT EXISTS filtro inverso para que me devuelva los actores o actrices que cumplan la condición de la subconsulta.
							FROM film_actor AS fa2
								INNER JOIN film AS f2
									ON fa2.film_id = f2.film_id
								INNER JOIN film_category AS fc2 -- identificar la tabla en la subconsulta, al comparar los datos es necesario.
									ON f2.film_id = fc2.film_id
								INNER JOIN category AS ca2
									ON fc2.category_id = ca2.category_id
								WHERE ca2.name = "Horror" AND fa2.actor_id = a.actor_id);/*primero que cumpla la condición de categoria y segundo que itere
                                                                                          por los datos como un bucle.
                                                                                          
/* 24.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla film.
Este ejercicio utiliza la misma lógica que el ejercicio 19 pero uniendo tablas con JOIN*/

SELECT f.title AS TitulosPeliculas
	FROM film as f
    INNER JOIN film_category AS fc
		ON f.film_id = fc.film_id
    INNER JOIN category AS ca
		ON fc.category_id = ca.category_id
	WHERE ca.name = "Comedy" AND f.length > 180;