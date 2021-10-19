/*
1. Mostrar el código, razón social de todos los clientes cuyo límite de crédito sea mayor o
igual a $ 1000 ordenado por código de cliente.
*/
SELECT * from Cliente

SELECT clie_codigo, clie_razon_social from Cliente
where clie_limite_credito >= 1000 ORDER BY clie_codigo 

/*2. Mostrar el código, detalle de todos los artículos vendidos en el año 2012 ordenados por
cantidad */

SELECT prod_codigo, prod_detalle
FROM Producto, Item_Factura, Factura
where prod_codigo = item_producto AND
fact_tipo = item_tipo AND
fact_sucursal = item_sucursal AND
fact_numero = item_numero AND
fact_fecha >= '2012-01-01 00:00:00' AND
fact_fecha < '2013-01-01 00:00:00'
ORDER BY item_cantidad 

select * from Factura

/*3. Realizar una consulta que muestre código de producto, nombre de producto y el stock
total, sin importar en que deposito se encuentre, los datos deben ser ordenados por
nombre del artículo de menor a mayor.*/

SELECT prod_codigo, prod_detalle FROM Producto 
JOIN STOCK 
ON prod_codigo = stoc_producto
GROUP BY prod_codigo, prod_detalle
ORDER BY prod_detalle 

/*4. Realizar una consulta que muestre para todos los artículos código, detalle y cantidad de
artículos que lo componen. Mostrar solo aquellos artículos para los cuales el stock
promedio por depósito sea mayor a 100.*/SELECT 
    p.prod_codigo as Codigo,
    p.prod_detalle as Detalle,
    isnull(SUM(c.comp_cantidad), 0) as Cantidad
FROM Producto p
INNER JOIN STOCK s
    ON s.stoc_producto = p.prod_codigo
LEFT JOIN Composicion c
    ON p.prod_codigo = c.comp_producto
GROUP BY p.prod_codigo, p.prod_detalle
HAVING AVG(s.stoc_cantidad) > 100
ORDER BY Cantidad desc;

