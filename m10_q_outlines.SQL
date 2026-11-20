USE RetailPro;

CREATE TABLE ventas_semana (
sucursal NVARCHAR (10),
ventas NUMERIC);

insert into ventas_semana (sucursal, ventas) VALUES
('Norte', 500), ('Norte', 510), ('Norte', 490), ('Norte', 505), ('Norte', 495),
('Sur', 100), ('Sur', 900), ('Sur', 50), ('Sur', 1200), ('Sur', 250);

SELECT 
sucursal, 
AVG (ventas) AS media, 
MAX (ventas) - MIN (ventas) AS rango
FROM ventas_semana
GROUP BY sucursal; 

Select 
sucursal, 
STDEV (ventas) AS desvio_muestral
FROM ventas_semana GROUP BY sucursal; 

SELECT DISTINCT 
AVG (CAST (MontoTotal AS FLOAT)) OVER () AS media, 
PERCENTILE_CONT (0.5) WITHIN GROUP (ORDER BY MontoTotal) OVER () AS mediana
FROM Ventas;

WITH q AS (
SELECT
PERCENTILE_CONT (0.25) WITHIN GROUP (ORDER BY MontoTotal) OVER () AS q1,
PERCENTILE_CONT (0.75) WITHIN GROUP (ORDER BY MontoTotal) OVER () AS q3
FROM ventas)
SELECT 
q1, q3, 
(q3 - q1) AS iqr,
q1 - 1.5* (q3 - q1) AS limite_inferior,
q3 + 1.5* (q3 - q1) AS limite_superior
FROM q; 

WITH q AS (
SELECT DISTINCT
PERCENTILE_CONT (0.25) WITHIN GROUP (ORDER BY MontoTotal) OVER () AS q1,
PERCENTILE_CONT (0.75) WITHIN GROUP (ORDER BY MontoTotal) OVER () AS q3
FROM Ventas)
SELECT v.*
FROM ventas v, q
WHERE v.MontoTotal < q.q1 - 1.5* (q.q3 - q.q1)
OR v.MontoTotal > q.q3 + 1.5* (q.q3 - q.q1);
