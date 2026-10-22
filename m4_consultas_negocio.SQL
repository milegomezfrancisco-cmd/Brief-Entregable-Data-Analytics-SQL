--Motor utilizado; SQL Server.
USE Ventas_Tech_DB; 

--Consulta 1; Resumen ejecutivo mensual;

SELECT 
MONTH (fecha_venta) AS mes,
SUM (cantidad*precio_unitario) AS total_facturado,
COUNT(*) AS cantidad_pedidos,
SUM (cantidad*precio_unitario) / COUNT (*) AS ticket_promedio
FROM Ventas
GROUP BY MONTH (fecha_venta)
ORDER BY mes;

--Consulta 2; Ranking de productos;

SELECT TOP 5
id_producto,
SUM (cantidad) AS unidades_vendidas,
SUM (cantidad*precio_unitario) AS total_generado
FROM Ventas
GROUP BY id_producto
ORDER BY total_generado DESC; 

--Consulta 3; Clientes recurrentes; 

SELECT 
id_cliente,
COUNT (*) AS cantidad_pedidos,
SUM (cantidad*precio_unitario) AS total_gastado
FROM Ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1
ORDER BY cantidad_pedidos DESC;

--Consulta 4; Meses por encima / por debajo promedio; 
SELECT 
MONTH (fecha_venta) AS mes,
SUM (cantidad*precio_unitario) AS total_facturado_mes,
CASE
WHEN SUM (cantidad*precio_unitario) > (
SELECT AVG (total_mes)
FROM (
SELECT SUM (cantidad*precio_unitario) AS total_mes
FROM Ventas
GROUP BY MONTH (fecha_venta)
)AS subconsulta_promedio
)THEN 'Por encima' 
ELSE 'Por debajo'
END AS rendimiento_vs_promedio
FROM Ventas
GROUP BY MONTH (fecha_venta)
ORDER BY mes;

-- Hallazgos; 1. El producto ID 1. Laptop Pro 15, lidera el total de facturación generado.
-- 2. El cliente ID 1 es el consumidor más importante del período con un total de $2640, ya que no compró la misma cantidad que los demás, con 4 unidades en total. 
-- Se evidencia un comportamiento homogéneo de compras, con todos aquellos clientes recurrentes destacados registrando dos compras en el período. 
