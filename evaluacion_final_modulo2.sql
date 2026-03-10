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