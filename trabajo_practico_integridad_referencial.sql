    -- Trabajo Práctico Integridad Referencial

    -- Introducción
    -- Este trabajo práctico tiene como objetivo explorar y comprender los conceptos y aplicaciones de la integridad referencial en una base de datos. Para ello, hemos creado una base de datos llamada "editoriales" que contiene tres tablas: editoriales, empleados y libros. Estas tablas están relacionadas entre sí mediante claves primarias y claves foráneas para garantizar la coherencia de los datos y la integridad referencial.

    -- Descripción de la Base de Datos
    -- Tabla editoriales
    -- La tabla editoriales almacena información sobre diferentes editoriales. Cada editorial tiene un identificador único (id_editorial) y un nombre (nombre_editorial). La clave primaria de esta tabla es id_editorial.

    -- Tabla empleados
    -- La tabla empleados contiene datos de los empleados de las editoriales. Cada empleado tiene un identificador único (id_empleado), un nombre (nombre_empleado) y una relación con la editorial a la que pertenece a través de la clave foránea id_editorial, que se relaciona con la clave primaria de la tabla editoriales. Debemos configurar la integridad referencial para que, en caso de que se elimine o actualice una editorial, los empleados relacionados se vean afectados en cascada.

    -- Tabla libros
    -- La tabla libros almacena información sobre los libros publicados por las editoriales. Cada libro tiene un identificador único (id_libro), un título (titulo_libro) y también una relación con la editorial correspondiente a través de la clave foránea id_editorial, que se relaciona con la clave primaria de la tabla editoriales. Al igual que en la tabla de empleados, debemos configurar la integridad referencial para que las acciones de eliminación o actualización en la tabla editoriales afecten a los libros relacionados en cascada.

    -- Nota: para agregar restricciones luego de haber creado las tablas proceder así:
    -- -- Agregar una clave primaria (PK) a una tabla existente:
    -- ALTER TABLE nombre_tabla
    -- ADD PRIMARY KEY (nombre_columna);


    -- -- Ejemplo para agregar una PK a la tabla editoriales:
    -- ALTER TABLE editoriales
    -- ADD PRIMARY KEY (id_editorial);


    -- -- Agregar una clave foránea (FK) a una tabla existente:
    -- ALTER TABLE nombre_tabla
    -- ADD CONSTRAINT nombre_fk
    -- FOREIGN KEY (nombre_columna_fk)
    -- REFERENCES nombre_tabla_referenciada (nombre_columna_referenciada)
    -- ON DELETE CASCADE ON UPDATE CASCADE;

    -- Crear la base de datos y las tablas con sus restricciones de PK y FK.
    -- Luego insertar los siguientes registros en cada tabla:

    CREATE DATABASE trabajo_practico_integridad_referencial
        DEFAULT CHARACTER SET = 'utf8mb4';

    use trabajo_practico_integridad_referencial;

    -- Crear la base de datos y las tablas con sus restricciones de PK y FK.
    CREATE TABLE IF NOT EXISTS editoriales (
        id_editorial INT NOT NULL,
        nombre_editorial VARCHAR(100),
        PRIMARY KEY (id_editorial)
    ) ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS empleados (
        id_empleado INT NOT NULL,
        nombre_empleado VARCHAR(100),
        id_editorial INT,
        PRIMARY KEY (id_empleado),
        CONSTRAINT fk_editorial_empleado
            FOREIGN KEY (id_editorial)
            REFERENCES editoriales (id_editorial)
            ON DELETE SET NULL
            ON UPDATE CASCADE
    ) ENGINE = INNODB;

    CREATE TABLE IF NOT EXISTS libros (
        id_libro INT NOT NULL,
        titulo_libro VARCHAR(200),
        id_editorial INT,
        PRIMARY KEY (id_libro),
        CONSTRAINT fk_editorial_libro
            FOREIGN KEY (id_editorial)
            REFERENCES editoriales (id_editorial)
            ON DELETE SET NULL
            ON UPDATE CASCADE
    ) ENGINE = INNODB;


    INSERT INTO editoriales (id_editorial, nombre_editorial)
    VALUES
        (1, 'Editorial Planeta'),
        (2, 'Editorial Santillana'),
        (3, 'Editorial Anaya'),
        (4, 'Editorial Alfaguara'),
        (5, 'Editorial SM'),
        (6, 'Editorial Fondo de Cultura Económica'),
        (7, 'Editorial Siglo XXI'),
        (8, 'Editorial Cátedra'),
        (9, 'Editorial Tecnos'),
        (10, 'Editorial Ariel');


    INSERT INTO empleados (id_empleado, nombre_empleado, id_editorial)
    VALUES
        (1, 'Juan Pérez', 1),
        (2, 'María Rodríguez', 1),
        (3, 'Pedro López', 2),
        (4, 'Ana Martínez', 2),
        (5, 'Carlos García', 3),
        (6, 'Laura González', 3),
        (7, 'Luis Fernández', 4),
        (8, 'Elena Sánchez', 4),
        (9, 'Javier Ruiz', 5),
        (10, 'Sofía Torres', 5);


    INSERT INTO libros (id_libro, titulo_libro, id_editorial)
    VALUES
        (1, 'Cien años de soledad', 1),
        (2, 'Don Quijote de la Mancha', 1),
        (3, 'La sombra del viento', 2),
        (4, 'Rayuela', 2),
        (5, 'Crónica de una muerte anunciada', 3),
        (6, 'Los detectives salvajes', 3),
        (7, 'Ficciones', 4),
        (8, 'La casa de los espíritus', 4),
        (9, 'La ciudad y los perros', 5),
        (10, 'Cien años de soledad', 5);

        -- 1.	Eliminar una editorial: Si se elimina una editorial de la tabla editoriales, ¿qué sucede con los libros asociados? Escriba una consulta SQL que elimine una editorial y sus libros relacionados.
    DELETE FROM editoriales WHERE id_editorial = 1;

    -- 2.  Actualizar el nombre de una editorial: Si se actualiza el nombre de una editorial en la tabla editoriales, ¿qué sucede con los libros relacionados?
    UPDATE editoriales SET nombre_editorial = 'Editorial Planeta Actualizada' WHERE id_editorial = 2;

    -- 3.	Eliminar un empleado: Si se elimina un empleado de la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
    DELETE FROM empleados WHERE id_empleado = 3;

    -- 4.	Actualizar el nombre de un empleado: Si se actualiza el nombre de un empleado en la tabla empleados, ¿qué sucede con los libros relacionados con esa editorial?
    UPDATE empleados SET nombre_empleado = 'María Rodríguez Actualizada' WHERE id_empleado = 2;

    -- 5.	Eliminar un libro: Si se elimina un libro de la tabla libros, ¿qué sucede con la relación con la editorial?
    DELETE FROM libros WHERE id_libro = 1;

    -- 6.	Cambiar la editorial de un libro: Si se cambia la editorial a la que está asociado un libro en la tabla libros, ¿qué sucede con la relación con la editorial anterior?
    UPDATE libros SET id_editorial = 3 WHERE id_libro = 2;

    -- 7.	Eliminar una editorial con empleados: Si se intenta eliminar una editorial que tiene empleados asociados, ¿qué sucede?
    DELETE FROM editoriales WHERE id_editorial = 2;

    -- 8.	Eliminar un empleado con libros: Si se intenta eliminar un empleado que tiene libros asociados, ¿qué sucede?
    DELETE FROM empleados WHERE id_empleado = 4;

    -- 9.	Eliminar una editorial y sus empleados: ¿Cómo se eliminaría una editorial y todos sus empleados?
    DELETE FROM editoriales WHERE id_editorial = 3;

    -- 10.	Eliminar una editorial y transferir sus empleados a otra editorial: ¿Cómo se eliminaría una editorial y reasignaría a sus empleados a otra editorial?
    UPDATE empleados SET id_editorial = 4 WHERE id_editorial = 4;
    DELETE FROM editoriales WHERE id_editorial = 4;
