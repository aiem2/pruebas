--PARTE 2 
--- REQUERIMIENTO 1: Crear el modelo en una base de datos llamada biblioteca, considerando las tablas definidas y sus atributos.

CREATE DATABASE biblioteca;
\c biblioteca;

CREATE TABLE socio ( rut VARCHAR(10), nombre VARCHAR(20) NOT NULL, apellido VARCHAR(20) NOT NULL, direccion VARCHAR, telefono VARCHAR(12) NOT NULL, PRIMARY KEY (rut));

CREATE TABLE autor (id SERIAL, nombre VARCHAR(20) NOT NULL, apellido VARCHAR(20) NOT NULL, fecha_nacimiento VARCHAR(4), fecha_fallecimiento VARCHAR(4), PRIMARY KEY (id));

CREATE TABLE libro (isbn VARCHAR(15), titulo VARCHAR NOT NULL, paginas SMALLINT NOT NULL, autores_id SERIAL, PRIMARY KEY (isbn));

CREATE TABLE registro_libro_autores (autores_id INT, isbn VARCHAR(15) REFERENCES libro(isbn), autor INT NOT NULL REFERENCES autor(id), tipo_autor VARCHAR(7));

CREATE TABLE prestamo (id SERIAL, socio VARCHAR(10) REFERENCES socio(rut), libro VARCHAR(15) REFERENCES libro(isbn),  fecha_inicio DATE NOT NULL, devolucion_teorica DATE NOT NULL, PRIMARY KEY (id));

CREATE TABLE devolucion (id SERIAL, prestamo INT REFERENCES prestamo(id), socio VARCHAR(10) REFERENCES socio(rut), libro VARCHAR(15) REFERENCES libro(isbn), fecha_inicio DATE, devolucion_teorica DATE, devolucion_real DATE,dias_atraso SMALLINT, multa SMALLINT);

--- REQUERIMIENTO 2: Se deben insertar los registros en las tablas correspondientes.
----INSERT SOCIOS
INSERT INTO socio (rut, nombre, apellido, direccion, telefono) VALUES ('1111111-1', 'Juan', 'Soto', 'Avenida 1, Santiago', '911111111');

INSERT INTO socio(rut, nombre, apellido, direccion, telefono) VALUES ('2222222-2', 'Ana', 'Perez', 'Pasaje 2, Santiago', '922222222');

INSERT INTO socio(rut, nombre, apellido, direccion, telefono) VALUES ('3333333-3', 'Sandra', 'Aguilar', 'Avenida 2, Santiago', '933333333');

INSERT INTO socio(rut, nombre, apellido, direccion, telefono) VALUES ('4444444-4', 'Esteban', 'Jerez', 'Avenida 3, Santiago', '944444444');

INSERT INTO socio(rut, nombre, apellido, direccion, telefono) VALUES ('5555555-5', 'Silvana', 'Munoz', 'Pasaje 3, Santiago', '955555555');

----INSERT AUTORES
INSERT INTO autor (id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento) VALUES (DEFAULT, 'Andres', 'Ulloa', (SELECT EXTRACT(YEAR FROM TIMESTAMP '1982-01-01 00:00:00')), '');

INSERT INTO autor (id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento) VALUES (DEFAULT, 'Sergio', 'Mardones', (SELECT EXTRACT(YEAR FROM TIMESTAMP '1950-01-01 00:00:00')), (SELECT EXTRACT(YEAR FROM TIMESTAMP '2012-01-01 00:00:00')));

INSERT INTO autor (id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento) VALUES (DEFAULT, 'Jose', 'Salgado', (SELECT EXTRACT(YEAR FROM TIMESTAMP '1968-01-01 00:00:00')), (SELECT EXTRACT(YEAR FROM TIMESTAMP '2020-01-01 00:00:00')));

INSERT INTO autor (id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento) VALUES (DEFAULT, 'Ana', 'Salgado', (SELECT EXTRACT(YEAR FROM TIMESTAMP '1972-01-01 00:00:00')), '');

INSERT INTO autor (id, nombre, apellido, fecha_nacimiento, fecha_fallecimiento) VALUES (DEFAULT, 'Martin', 'Porta', (SELECT EXTRACT(YEAR FROM TIMESTAMP '1976-01-01 00:00:00')), '');

----INSERT LIBROS

CREATE TABLE libro (isbn VARCHAR(15), titulo VARCHAR NOT NULL, paginas SMALLINT NOT NULL, autores_id SERIAL, PRIMARY KEY (isbn));

INSERT INTO libro (isbn, titulo, paginas, autores_id) VALUES ('111-1111111-111', 'Cuentos de Terror', 344, DEFAULT);

INSERT INTO libro (isbn, titulo, paginas, autores_id) VALUES ('222-2222222-222', 'Poesias contemporaneas', 167, DEFAULT);

INSERT INTO libro (isbn, titulo, paginas, autores_id) VALUES ('333-3333333-333', 'Historia de Asia', 511, DEFAULT);

INSERT INTO libro (isbn, titulo, paginas, autores_id) VALUES ('444-4444444-444', 'Manual de mecanica', 298, DEFAULT);

----INSERT REGISTRO_LIBRO_AUTORES

CREATE TABLE registro_libro_autores (autores_id INT, isbn VARCHAR(15) REFERENCES libro(isbn), autor INT NOT NULL REFERENCES autor(id), tipo_autor VARCHAR(7));

INSERT INTO registro_libro_autores (autores_id, isbn, autor, tipo_autor) VALUES (1, '111-1111111-111', 3, 'Autor');

INSERT INTO registro_libro_autores (autores_id, isbn, autor, tipo_autor) VALUES (1, '111-1111111-111', 4, 'Coautor');

INSERT INTO registro_libro_autores (autores_id, isbn, autor, tipo_autor) VALUES (2, '222-2222222-222', 1, 'Autor');

INSERT INTO registro_libro_autores (autores_id, isbn, autor, tipo_autor) VALUES (3, '333-3333333-333', 2, 'Autor');

INSERT INTO registro_libro_autores (autores_id, isbn, autor, tipo_autor) VALUES (4, '444-4444444-444', 5, 'Autor');

----INSERT PRESTAMOS
INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '1111111-1', '111-1111111-111', '2020-01-20', '2020-01-27');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '5555555-5', '222-2222222-222', '2020-01-20', '2020-01-27');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '3333333-3', '333-3333333-333', '2020-01-22', '2020-01-29');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '4444444-4', '444-4444444-444', '2020-01-23', '2020-01-30');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '2222222-2', '111-1111111-111', '2020-01-27', '2020-02-03');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '1111111-1', '444-4444444-444', '2020-01-31', '2020-02-07');

INSERT INTO prestamo (id, socio, libro, fecha_inicio, devolucion_teorica) VALUES (DEFAULT, '3333333-3', '222-2222222-222', '2020-01-31', '2020-02-07');

----INSERT DEVOLUCION

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 1, '1111111-1', '111-1111111-111', '2020-01-20', '2020-01-27', '2020-01-27', 0, 0);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 2, '5555555-5', '222-2222222-222', '2020-01-20', '2020-01-27', '2020-01-30', 3, 300);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 3, '3333333-3', '333-3333333-333', '2020-01-22', '2020-01-29', '2020-01-30', 1, 100);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 4, '4444444-4', '444-4444444-444', '2020-01-23', '2020-01-30', '2020-01-30', 0, 0);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 5, '2222222-2', '111-1111111-111', '2020-01-27', '2020-02-03', '2020-02_04', 1, 100);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 6, '1111111-1', '444-4444444-444', '2020-01-31', '2020-02-07', '2020-02-12', 5, 500);

INSERT INTO devolucion (id, prestamo, socio, libro, fecha_inicio, devolucion_teorica, devolucion_real, dias_atraso, multa) VALUES (DEFAULT, 7, '3333333-3', '222-2222222-222', '2020-01-31', '2020-02-07', '2020-02-12', 5, 500);

---REQUERIMIENTO 3: Realizar las siguientes consultas:
---- a. Mostrar todos los libros que posean menos de 300 páginas.
SELECT * FROM libro WHERE paginas < 300;

---- b. Mostrar todos los autores que hayan nacido después del 01-01-1970.
SELECT * FROM autor WHERE fecha_nacimiento > '1970-01-01';

---- c. ¿Cuál es el libro más solicitado?
SELECT libro, count(*) FROM prestamo GROUP BY libro;

---- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
SELECT * FROM devolucion WHERE multa > 0;

---DICCIONARIO TABLA
SELECT
t1.TABLE_NAME AS tabla_nombre,
t1.COLUMN_NAME AS columna_nombre,
t1.ORDINAL_POSITION AS position,
t1.IS_NULLABLE AS nulo,
t1.DATA_TYPE AS tipo_dato,
COALESCE(t1.NUMERIC_PRECISION,
t1.CHARACTER_MAXIMUM_LENGTH) AS longitud
FROM
INFORMATION_SCHEMA.COLUMNS t1
WHERE
t1.TABLE_SCHEMA = 'public'
ORDER BY
t1.TABLE_NAME, t1.ORDINAL_POSITION;
