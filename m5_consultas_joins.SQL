--Motor utilizado; SQL Server.
USE Ventas_Tech_DB; 

--Consulta 1; INNER JOIN - vista base.
--Propósito; combinar tablas de ventas con tablas de clientes y productos.
SELECT
v.fecha_venta,
v.id_cliente,
c.nombre AS nombre_cliente,
p.nombre_producto AS descripcion_producto,
v.cantidad,
v.precio_unitario,
(v.cantidad*v.precio_unitario) AS total_venta
From Ventas v 
INNER JOIN clientes c ON v.id_cliente = c.id_cliente
INNER JOIN productos p ON v.id_producto = p.id_producto; 

--Hallazgo; se asociaron las tablas a partir de los IDS de clientes y de productos. 

--Consulta 2; LEFT JOIN - clientes sin ventas.
-- Propósito; identificar clientes que no compraron nada para contactarlos.
SELECT
c.nombre,
c.email,
c.fecha_registro
FROM clientes c 
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL; 
--Hallazgo; no hay ningún cliente que no haya realizado una venta, por lo que todos están activos.

--Consulta 3; LEFT JOIN - productos sin ventas.
--Propósito; identificar artículos del catálogo que no tienen movimientos.
SELECT
p.nombre_producto,
p.id_categoria,
p.precio_unitario
FROM Productos p
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL; 
--Hallazgo; no hay artículos del catálogo sin movimiento.

--Consulta 4; UNION ALL - consolidado por canal.
--Propósito; crear columna canal para unificar el origen de las ventas. 
SELECT 
canal, SUM (total) AS total_canal
FROM (
SELECT 
(cantidad*precio_unitario) AS total,
'Online' AS canal
FROM ventas
WHERE id_cliente = 1
UNION ALL
SELECT(cantidad*precio_unitario) AS total,
'Presencial' AS canal
FROM ventas 
WHERE id_cliente <> 1)
AS consolidado
GROUP BY canal
ORDER BY canal ASC; 
--Hallazgo; el canal presencial lidera las ventas con un total de 3804.00. 
