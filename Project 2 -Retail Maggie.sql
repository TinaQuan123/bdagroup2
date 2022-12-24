-------------------------------------------------------  PROJECT 2 RETAIL  -------------------------------------------------------------------

---------------------------------------- What price point is most effective at maximizing sales? --------------------------------

select Product, Price, [Sales $] as 'Sales'
from Retail 
where [Sales $] = (select max([Sales $]) from Retail where Product = 'Pantene')
UNION ALL
select Product, Price, [Sales $] as 'Sales'
from Retail
where [Sales $] = (select max([Sales $]) from Retail where Product = 'Aussie')

----------------------------------------- What price point is most effective at maximizing gross margin? ------------------------------
select Product, Price, [Gross Margin $] as 'Gross Margin'
from Retail
where [Gross Margin $] = (select max([Gross Margin $]) from Retail where Product = 'Pantene')
UNION ALL
select Product, Price, [Gross Margin $] as 'Gross Margin'
from Retail
where [Gross Margin $] = (select max([Gross Margin $]) from Retail where Product = 'Aussie')

------------------------------------------------ Is Shampoo Seasonal? ---------------------------------------------








------------------------------------------------  What is the cost per unit of each product? ----------------------------
select Product, avg(Cost) as 'Cost'
from Retail
group by Product

--------------------------------How would Pantene perform for units, sales and margin with a 25% and 60% discount? ----------------------

--Find the linear equation for the trend line of units and discount 

--SELECT ((Sy * Sxx) - (Sx * Sxy))
--    / ((N * (Sxx)) - (Sx * Sx)) AS a,
--    ((N * Sxy) - (Sx * Sy))
--    / ((N * Sxx) - (Sx * Sx)) AS b,
--    ((N * Sxy) - (Sx * Sy))
--    / SQRT(
--        (((N * Sxx) - (Sx * Sx))
--         * ((N * Syy - (Sy * Sy))))) AS r FROM (SELECT SUM(Discount) AS Sx, SUM(Units) AS Sy,
--        SUM(Discount * Discount) AS Sxx,
--        SUM(Discount * Units) AS Sxy,
--        SUM(Units * Units) AS Syy,
--        COUNT(*) AS N
--        FROM Retail where product = 'Pantene') sums

--select (5947 + 78867 * 0.25)  as '# of units in 25% discount'


--Find the linear equation for the trend line of sales and discount
--SELECT ((Sy * Sxx) - (Sx * Sxy))
--    / ((N * (Sxx)) - (Sx * Sx)) AS a,
--    ((N * Sxy) - (Sx * Sy))
--    / ((N * Sxx) - (Sx * Sx)) AS b,
--    ((N * Sxy) - (Sx * Sy))
--    / SQRT(
--        (((N * Sxx) - (Sx * Sx))
--         * ((N * Syy - (Sy * Sy))))) AS r FROM (SELECT SUM(Discount) AS Sx, SUM([Sales $]) AS Sy,
--        SUM(Discount * Discount) AS Sxx,
--        SUM(Discount * [Sales $]) AS Sxy,
--        SUM([Sales $] * [Sales $]) AS Syy,
--        COUNT(*) AS N
--        FROM Retail where product = 'Pantene') sums

--select (60967 + 268592 * 0.25)  as ' Avg Sales in 25% discount'

-- Find the linear equation for the trend line of Margin and discount
--SELECT ((Sy * Sxx) - (Sx * Sxy))
--    / ((N * (Sxx)) - (Sx * Sx)) AS a,
--    ((N * Sxy) - (Sx * Sy))
--    / ((N * Sxx) - (Sx * Sx)) AS b,
--    ((N * Sxy) - (Sx * Sy))
--    / SQRT(
--        (((N * Sxx) - (Sx * Sx))
--         * ((N * Syy - (Sy * Sy))))) AS r FROM (SELECT SUM(Discount) AS Sx, SUM([Gross Margin $]) AS Sy,
--        SUM(Discount * Discount) AS Sxx,
--        SUM(Discount * [Gross Margin $]) AS Sxy,
--        SUM([Gross Margin $] * [Gross Margin $]) AS Syy,
--        COUNT(*) AS N
--        FROM Retail where product = 'Pantene') sums

--select (36585 - 54763 * 0.25)  as ' Avg margin in 25% discount'

----- Sum up -------
select (5947 + 78867 * 0.25)  as '# of units, sales, margin in 25% discount of Pantene on avg'
union all
select (60967 + 268592 * 0.25)  
union all
select (36585 - 54763 * 0.25) 

------- units, sales, margin in 60% discount Pantene -------
select (5947 + 78867 * 0.60)  as '# of units, sales, margin in 60% discount of Pantene on avg'
union all
select (60967 + 268592 * 0.60)  
union all
select (36585 - 54763 * 0.60)  

------------------------------------------ What impact does being “On Flyer” have on performance? -------------------------------------
select [On Flyer?],sum([Units]) as 'Units sold',sum([Sales $]) as 'Sales', sum([Gross Margin $]) as 'Gross Margin'
from Retail
group by [On Flyer?]

----------------------------------------------- Q8 What price would you recommend for Aussie? (NotSure)------------------------------------------------


select Price, sum([Sales $]) as 'Total Sales', sum([Gross Margin $]) as 'Total Margins', sum([Sales $] - [Gross Margin $]) as ' Total Sales - Total Margin', sum([# Transactions that contained the product]) as ' Total # of transactions'
from Retail 
where Product = 'Aussie'
group by Price
order by sum([# Transactions that contained the product]) desc 

select Price, t.[Total Sales] from  
(select Price, sum([Sales $]) as 'Total Sales', sum([Gross Margin $]) as 'Total Margins', sum([Sales $] - [Gross Margin $]) as ' Total Sales - Total Margin'
from Retail 
where Product = 'Aussie'
group by Price) t
order by t.[Total Sales] desc

select Price, t.[Total Margins] from  
(select Price, sum([Sales $]) as 'Total Sales', sum([Gross Margin $]) as 'Total Margins', sum([Sales $] - [Gross Margin $]) as ' Total Sales - Total Margin'
from Retail 
where Product = 'Aussie'
group by Price) t
order by t.[Total Margins] desc

------------------------------------------ Is Aussie @ $2.49 an effective loss leader? Explain why or why not. (Unfinished) ----------------------------
select Price, sum(units) as 'Units', sum([Sales $]) as 'Sales',sum([Gross Margin $]) as 'Gross Margin',sum([# Transactions that contained the product]) as '# of transaction contained'
from retail
where product = 'Aussie' 
group by price
order by sum([Sales $]) desc