--TAREA EXTRA
--Alejandra Arredondo Hernandez 189744
--NOTA: como se recomendo en clase, Alejandra, Elisa y Yuliana compartimos nuestros conocimientos 
--después de haber elaborado de manera individual nuestra tarea, cada una sabe como hacer cada pregunta, 
--sin embargo, intercambiamos opiniones y formas de hacerlo para enriquecer nuestro conocimiento en la materia.

--PREGUNTA
--Una de las métricas para saber si un cliente es bueno, aparte de la suma y el promedio de sus pagos, 
--es si tenemos una progresión consistentemente creciente en los montos.

--Debemos calcular para cada cliente su promedio mensual de deltas en los pagos de sus órdenes en la 
--tabla order_details en la BD de Northwind, es decir, la diferencia entre el monto total de una orden 
--en tiempo t y el anterior en t-1, para tener la foto completa sobre el customer lifetime value de cada 
--miembro de nuestra cartera.

select customer_id, TO_CHAR(order_date,'MM-YYYY') as mes_anio,
AVG(prom) as promedio_mensual_deltas
from(select o.customer_id,o.order_date,
(od.discount)*(od.unit_price*od.quantity) - LAG((od.discount-1)*(od.unit_price*od.quantity))
over (partition by o.customer_id order by o.order_date) 
as prom from orders o join order_details od on o.order_id = od.order_id)
as x group by customer_id, mes_anio order by 2 desc;



