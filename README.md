#Proyecto de Evaluación SQL: Base de Datos Sakila

Este repositorio contiene la resolución de la Evaluación del Módulo 2 de SQL. 
El objetivo es realizar un análisis exhaustivo de la base de datos Sakila, una base de datos de ejemplo 
que simula el funcionamiento de una tienda de alquiler de películas.

A lo largo de los ejercicios se aplican conceptos desde consultas básicas hasta técnicas avanzadas como 
subconsultas correlacionadas, funciones de agregación y uniones de múltiples tablas (JOINs).

##Tecnologías y Herramientas
Lenguaje: SQL

Base de Datos: Sakila (MySQL)

Temas cubiertos: * Consultas de selección y filtrado (SELECT, DISTINCT, WHERE, LIKE, BETWEEN).

Agrupación y funciones de agregado (GROUP BY, HAVING, COUNT, AVG, ROUND).

Uniones de tablas (INNER JOIN, LEFT JOIN).

Subconsultas (IN, NOT EXISTS).

Funciones de fecha (DATEDIFF).

## Ejemplo
Aquí un ejemplo de una consulta en la que había que encontrar las categorias de las peliculas que tienen un promedio de duracion superior a 120 minutos y tenía que mostrar el nombre de la categoria junto con el promedio de duracion.

SELECT ca.name AS Categoria, AVG(length) AS PromedioDuracionPelicula
	FROM category AS ca
    INNER JOIN film_category AS fc
		ON ca.category_id = fc.category_id
    INNER JOIN film AS f
		ON fc.film_id = f.film_id
    GROUP BY ca.name
    HAVING AVG(length) > 120;
