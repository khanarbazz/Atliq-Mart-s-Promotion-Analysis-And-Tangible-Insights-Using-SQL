use Atliq_mart_db;

select * from events_cleaned;


##1 Provide a list of products with a base price greater than 500 and that are featured in promo type of 'BOGOF' (Buy One Get One Free).
#which can be useful for evaluating our pricing and promotion strategies.


select distinct(E.product_code),
	   product_name
from events_cleaned as E
inner join products_cleand as P
	on E.product_code=P.product_code
	where E.Promo_type='BOGOF'
	And E.base_price>500;


# This information will help us identify high-value products that are currently being heavily discounted


##2  Generate a report that provides an overview of the number of stores in each city.  
#The report includes two essential fields: city and store count, which will assist in optimizing our retail operations.


select count(store_id) as `Number Of Stores`,
	   city as City
from stores_cleaned
	group by city
	order by count(store_id) desc;


#The results will be sorted in descending order of store counts, allowing us to identify the cities with the highest store presence.


##3 Generate a report that displays each campaign along with the total revenue generated before and after the campaign? 
#The report includes three key fields: campaign_name, total_revenue (before_promotion), total_revenue(after_promotion). 


select campaign_name as Campaign,
       concat((round(sum(`Revenue Before`)/1000000,0)),' ','M') as `Revenue Before`,
       concat((round(sum(`Revenue After`)/1000000,0)),' ','M') as `Revenue After`
from events_updated as E
inner join campaigns_cleaned as C
	on E.campaign_id=C.campaign_id
	Group by C.campaign_name;
    

#This report should help in evaluating the financial impact of our promotional campaigns. (Display the values in millions)

    
##4  Produce a report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign. 
#Additionally, provide rankings for the categories based on their ISU%. The report will include three key fields: category, isu%, and rank order.


select category as Category,
       `Incremental Sold Units Percentage`,
       rank() over(order by `Incremental Sold Units Percentage` desc) as Ranks
from events_updated as E
inner join products_cleand as P
	on E.Product_code=P.Product_code
inner join campaigns_cleaned as C
	on E.Campaign_id=C.Campaign_id
	where Campaign_name='Diwali';

    
#This information will assist in assessing the category-wise success and impact of the Diwali campaign on incremental sales
    

##5  Create a report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), across all campaigns. 
#The report will provide essential information including product name, category, and ir%. 


select Ranks,
	   `Product Name`,
       Category,
       `IR %`
from ( select product_name as `Product Name`,
       category as `Category`,
	   `Incremental Revenue %` as `IR %`,
       rank() over(order by `Incremental Revenue` desc) as Ranks
from events_updated as E
		inner join products_cleand as P
		on P.Product_code=E.Product_code) as I
where ranks<=5;


#This analysis helps identify the most successful products in terms of incremental revenue across our campaigns, assisting in product optimization.






