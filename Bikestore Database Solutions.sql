use Bikestores

select* from [production].[brands]
select* from[production].[categories]
select* from[production].[products]
select* from[production].[stocks]
select* from[sales].[customers]
select* from[sales].[order_items]
select* from[sales].[orders]
select* from[sales].[staffs]
select* from[sales].[stores]

----------------THE BIGGEST PROBLEM IS THOSE ORDERS WHICH WERE REJECTED,,MEANING THEIR MONEY SHOULD BE SUBTRACTED

--------1. Which bike is most expensive?
select [product_name] as 'The most expensive bike is' from[production].[products] 
where [list_price]=(select max([list_price]) from [production].[products])

----------2How many total customers does BikeStore have? 
---Would you consider people with order status 3 as customers substantiate your answer?
select count([customer_id]) as 'The number of custormers in Bikestore is' from[sales].[customers]


--------3 How many stores does BikeStore have?

select count([store_id]) as 'The number of stores Bikestores has is' from[sales].[stores]

-----4 What is the total price spent per order?..similar to how much was deposited per order at Absa

---Check for reversed Transactons
----Only where status is 4 from orders table,use join

-----You have to group by order_id because we have a aggreage column which make a function and non  aggregate column
---Group by Non aggregate column----what is the common table?,,,order_id

---4 What is the total price spent per order?
select sum([list_price]*[quantity]*(1-[discount])) as 'total price spent per order',[sales].[order_items].[order_id] 

from[sales].[order_items]

join[sales].[orders]
on [sales].[orders].[order_id]=[sales].[order_items].[order_id]
where [order_status]=4 --and month(order_date)=4
group by [sales].[order_items].[order_id] 
order by [total price spent per order] desc

----use method 2,set oders tables as I and another T

----Which/who spend the most? and show their address

----date,deposited anount,account....total amount deposited from 2016


----- Which customer spent the most?
select C.[customer_id],CONCAT(C.[first_name],' ',C.[last_name]) from [sales].[customers] as C

join [sales].[orders] as I
on C.[customer_id]=I.[customer_id]
where order_id =937

--where [total price spent per order]=(select max([total price spent per order]) from [sales].[orders])




---5The sales revenue per store?
select B.[store_name],sum([list_price]*[quantity]*(1-[discount])) as 'The store revenues are'
from[sales].[stores] as B

join[sales].[orders] as O
on B.[store_id]=O.[store_id]

join[sales].[order_items] as I
on I.[order_id]=O.[order_id]
where [order_status]=4
group by B.[store_name]


--6 which category is the most sold?
select C.[category_id],C.[category_name] from[production].[categories] as C
---Category is related tp Production Product table via Category id
join[production].[products] as P

on P.[category_id]=C.category_id
join [sales].[order_items] as I
on I.[product_id]=P.product_id
where I.order_id=937
--where [quantity]=(select MAX([quantity] )from [sales].[order_items])

---find the total Quantity
--7