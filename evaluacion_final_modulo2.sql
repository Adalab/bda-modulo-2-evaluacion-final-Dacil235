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
   En esta consulta utilizamos el operador LIKE porque permite más opciones al buscar.*/
   
SELECT first_name AS Nombre, last_name AS Apellido
	FROM actor
    WHERE last_name LIKE "Gibson";
    
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