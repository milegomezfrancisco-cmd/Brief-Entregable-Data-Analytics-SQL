CREATE DATABASE Ventas_Tech_DB; 

DROP TABLE IF EXISTS Ventas; 
DROP TABLE IF EXISTS Clientes; 
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Categorías;

CREATE TABLE Categorias (
id_categoria INT PRIMARY KEY,
tipo NVARCHAR (50) NOT NULL,
descripción NVARCHAR (200));

CREATE TABLE Clientes (
id_cliente INT PRIMARY KEY,
nombre NVARCHAR (50),
email NVARCHAR (50) UNIQUE, 
ciudad NVARCHAR (50),
fecha_registro DATE NOT NULL);

CREATE TABLE Productos (
id_producto INT PRIMARY KEY,
nombre_producto NVARCHAR (50) NOT NULL,
id_categoria INT FOREIGN KEY REFERENCES Categorias(id_categoria),
precio DECIMAL (10, 2) NOT NULL,
stock INT DEFAULT 0,
activo BIT DEFAULT 1);

CREATE TABLE Ventas (
id_venta INT PRIMARY KEY,
id_cliente INT FOREIGN KEY REFERENCES Clientes (id_cliente),
id_producto INT FOREIGN KEY REFERENCES Productos (id_producto),
cantidad INT NOT NULL,
precio DECIMAL (10, 2) NOT NULL,
fecha_venta DATE NOT NULL);

INSERT INTO Categorias (id_categoria, tipo, descripción) VALUES 
(1,'Computación', 'Laptops, PC y monitories'),
(2, 'Accesorios', 'Periféricos y complementos'),
(3, 'Audio', 'Aurioculares y parlantes'),
(4, 'Almacenamiento', 'Discos y memorias');

INSERT INTO Clientes (id_cliente, nombre, email, ciudad, fecha_registro) VALUES
(1, 'María Lopez', 'maria@mail.com', 'Buenos Aires', '2024-01-05'),
(2, 'Carlos Ruiz', 'carlos@mail.com', 'Córdoba', '2024-01-10'),
(3, 'Ana Gomez', 'ana@mail.com', 'Rosario', '2024-02-01'),
(4, 'Pedro Sanz', 'pedro@mail.com', 'Mendoza', '2024-02-15'),
(5, 'Laura Torres', 'laura@mail.com', 'Tucumán', '2024-03-01');

INSERT INTO Productos (id_producto, nombre_producto, id_categoria, precio,stock, activo) VALUES
(1, 'Laptop Pro 15', 1, 120.00, 15, 1),
(2, 'Mouse Inalámbrico', 2, 28.00, 80, 1),
(3, 'Monitor 4K 27', 1, 450.00, 12, 1),
(4, 'Auriculares BT Pro', 3, 120.00, 35, 1),
(5, 'SSD Externo 1TB', 4, 130.00, 18, 1),
(6, 'Teclado Mecánico', 2, 95.00, 40, 1);

INSERT INTO Ventas (id_venta, id_cliente, id_producto, cantidad, precio,fecha_venta) VALUES
( 1, 1, 1, 2, 1200.00, '2024-03-05'),
( 2, 2, 2, 5,   28.00, '2024-03-06'),
( 3, 3, 3, 1,  450.00, '2024-03-07'),
( 4, 1, 4, 2,  120.00, '2024-03-08'),
( 5, 4, 5, 3,  130.00, '2024-03-10'),
( 6, 2, 6, 4,   95.00, '2024-03-11'),
( 7, 5, 1, 1, 1200.00, '2024-03-12'),
( 8, 3, 2, 8,   28.00, '2024-03-13'),
( 9, 4, 4, 1,  120.00, '2024-03-14'),
(10, 5, 3, 2,  450.00, '2024-03-15');

SELECT* FROM Categorias; 
SELECT*FROM Clientes;
SELECT*FROM Productos;
SELECT*FROM Ventas; 