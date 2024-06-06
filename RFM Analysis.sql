-- Inspect the entire data

select * from [dbo].[sales_data_sample]

--CHecking unique values
select distinct status from [dbo].[sales_data_sample] --Nice to plot
select distinct year_id from [dbo].[sales_data_sample] --Nice to plot
select distinct PRODUCTLINE from [dbo].[sales_data_sample] ---Nice to plot
select distinct COUNTRY from [dbo].[sales_data_sample] ---Nice to plot
select distinct DEALSIZE from [dbo].[sales_data_sample] ---Nice to plot
select distinct TERRITORY from [dbo].[sales_data_sample] ---Nice to plot

---ANALYSIS
----Let's start by grouping sales by productline
select PRODUCTLINE, round(sum(sales),2) Revenue
from [dbo].[sales_data_sample]
group by PRODUCTLINE
order by 2 desc;

--by YEAR_ID, Which Year has the top revenue? 2004//
select YEAR_ID, round(sum(sales),2) REVENUE
from [dbo].[sales_data_sample]
group by YEAR_ID
order by 2 desc;

--by DEALSIZE
select  DEALSIZE, round(sum(sales),2) REVENUE
from [dbo].[sales_data_sample]
group by  DEALSIZE
order by 2 desc;

--by COUNTRY
select COUNTRY, round(sum(sales),2) Revenue
from [dbo].[sales_data_sample]
group by COUNTRY
order by 2 desc;

----What was the best month for sales in a specific year? How much was earned that month? November //
select  MONTH_ID, round(sum(sales),2) REVENUE, count(ORDERNUMBER) Frequency
from [dbo].[sales_data_sample]
where YEAR_ID = 2004 --change year to see the rest
group by  MONTH_ID
order by 2 desc;

-- what product do they sell in November? Classic//
select  MONTH_ID, PRODUCTLINE, sum(sales) REVENUE, count(ORDERNUMBER) FREQUENCY
from [dbo].[sales_data_sample]
where YEAR_ID = 2003 and MONTH_ID = 11 --change year to see the rest
group by  MONTH_ID, PRODUCTLINE
order by 3 desc;

----Who is our best customer? (this could be best answered with RFM)
DROP TABLE IF EXISTS rfm;

with rfm1 as 
(
	select 
		CUSTOMERNAME, 
		sum(sales) MonetaryValue,
		avg(sales) AvgMonetaryValue,
		count(ORDERNUMBER) Frequency,
		max(ORDERDATE) last_order_date,
		(select max(ORDERDATE) from [dbo].[sales_data_sample]) max_order_date,
		DATEDIFF(DD, max(ORDERDATE), (select max(ORDERDATE) from [dbo].[sales_data_sample])) Recency
	from [dbo].[sales_data_sample]
	group by CUSTOMERNAME),
rfm_calc as
(select r.*,
		NTILE(4) OVER (order by Recency desc) rfm_recency,
		NTILE(4) OVER (order by Frequency) rfm_frequency,
		NTILE(4) OVER (order by MonetaryValue) rfm_monetary
	from rfm1 r
)
select 
	c.*, rfm_recency+ rfm_frequency+ rfm_monetary as rfm_cell,
	cast(rfm_recency as varchar) + cast(rfm_frequency as varchar) + cast(rfm_monetary  as varchar)rfm_cell_string
into #rfm1
from rfm_calc c

select CUSTOMERNAME , rfm_recency, rfm_frequency, rfm_monetary,
	case 
		when rfm_cell_string in (111, 112 , 121, 122, 123, 132, 211, 212, 114, 141) then 'lost_customers'  --lost customers
		when rfm_cell_string in (133, 134, 143, 244, 334, 343, 344, 144) then 'slipping away, cannot lose' -- (Big spenders who haven’t purchased lately) slipping away
		when rfm_cell_string in (311, 411, 331) then 'new customers'
		when rfm_cell_string in (222, 223, 233, 322) then 'potential churners'
		when rfm_cell_string in (323, 333,321, 422, 332, 432) then 'active' --(Customers who buy often & recently, but at low price points)
		when rfm_cell_string in (433, 434, 443, 444) then 'loyal'
	end rfm_segment

from #rfm1

--What products are most often sold together? 
select * from [dbo].[sales_data_sample] where ORDERNUMBER =  10411;

select distinct OrderNumber, stuff((select ',' + PRODUCTCODE
	from [dbo].[sales_data_sample] p
	where ORDERNUMBER in 
		(select ORDERNUMBER
			from (
				select ORDERNUMBER, count(*) rn
				FROM [dbo].[sales_data_sample]
				where STATUS = 'Shipped'
				group by ORDERNUMBER
			)m
			where rn = 3
		)
		and p.ORDERNUMBER = s.ORDERNUMBER
		for xml path ('')), 1, 1, '') ProductCodes
		from [dbo].[sales_data_sample] s
      order by 2 desc
	  
	  --Which city has the highest number of sales in a specific country
select city, round(sum (sales),2) Revenue
from [dbo].[sales_data_sample]
where country = 'UK'
group by city
order by 2 desc;

---What is the best product in United States?
select country, YEAR_ID, PRODUCTLINE, sum(sales) Revenue
from [dbo].[sales_data_sample]
where country = 'USA'
group by  country, YEAR_ID, PRODUCTLINE
order by 4 desc;

---What is the best product in Singapore?
select country, YEAR_ID, PRODUCTLINE, ROUND(sum(sales),2) Revenue
from [dbo].[sales_data_sample]
where country = 'Singapore'
group by  country, YEAR_ID, PRODUCTLINE
order by 4 desc;