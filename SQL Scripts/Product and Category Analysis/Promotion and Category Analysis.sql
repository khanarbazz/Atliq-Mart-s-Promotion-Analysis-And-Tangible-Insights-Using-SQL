                                                 #########  PRODUCT AND CATEGORY ANALYSIS  ###############


use atliq_mart_db;


##1  Which product categories saw the most significant lift in sales from the promotions?


                                                                     ##In terms of Revenue
select  P.Category,
        concat(round((avg(`Incremental Revenue`)/1000000),3),' ','M') as `Avg IR`
from events_updated as E
inner join products_cleand as P
on P.product_code=E.Product_code
		group by P.category
		order by avg(`Incremental Revenue`)desc ;
        
                                                                     ##In terms of Unit Sold
select  P.Category,
        avg(`Incremental Sold Units`) as `Avg IR`
from events_updated as E
inner join products_cleand as P
on P.product_code=E.Product_code
		group by P.category
		order by avg(`Incremental Sold Units`)desc ;
        
        
##2  What is the correlation between product category and promotion type effectiveness?

select P.category as Category,
       promo_type as `Promo Type`,
       avg(`quantity_sold(after_promo)`) as `Qty Sold After (AVG)`,
       avg(`quantity_sold(before_promo)`) as `Qty Sold Before (AVG)`,
       avg(`Incremental Sold Units`) as `ISU (AVG)`,
       concat(round(avg(`Revenue After`)/1000,0),' ','K') as `Revenue After (AVG)`,
       concat(round(avg(`Revenue Before`)/1000,0),' ','K') as `Revenue Before (AVG)`,
       concat(round(avg(`Incremental Revenue`)/1000,0),' ','K') as  `IR (AVG)`,
       count(*) as Frequency
from events_updated as E
inner join products_cleand as P
on E.Product_code=P.product_code
	group by category,promo_type;


##3  Are there specific products that respond exceptionally well or poorly to promotions?
select * from events_updated;
select * from products_cleand;


select Product_name,
       concat(round((sum(`Incremental Revenue`)/1000000),0),' ','M')                      ##Product Performing Extremly Good
from events_updated as E
inner join products_cleand as P
	on E.product_code=P.product_code
Group by product_name
	order by sum(`Incremental Revenue`) desc
    limit 1;
    
select Product_name,
       concat(round((sum(`Incremental Revenue`)/1000000),0),' ','M')                         ##Product Performing Extremly Poor
from events_updated as E
inner join products_cleand as P
	on E.product_code=P.product_code
Group by product_name
	order by sum(`Incremental Revenue`) asc
    limit 1;
