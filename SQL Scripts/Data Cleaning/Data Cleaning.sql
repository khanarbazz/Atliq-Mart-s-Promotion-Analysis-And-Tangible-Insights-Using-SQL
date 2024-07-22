use Atliq_mart_db;


                                ### Creating Duplicate for every table ###

create table events_cleaned
like events;

select * from events_cleaned;

Insert into events_cleaned
Select *
from events;

create table stores_cleaned
like stores;

Insert into stores_cleaned
Select *
from stores;

create table products_cleand
like products;

Insert into products_cleand
Select *
from products;

create table campaigns_cleaned
like campaigns;

Insert into campaigns_cleaned
Select *
from campaigns;

                                    
                                ####  DATA CLEANING ON EVENTS TABLE   ###
                                ###   1.1 Checking for Duplicate Values  ###


select *
from (
select *,
row_number() over(partition by event_id,
							   store_id,
							   campaign_id,
							   product_code,
							   base_price,
							   promo_type
							   
					 )  as Ranks
from events_cleaned) as I
where Ranks>1;                                                           ### No Duplicate Found ###  
               
						
                  						### 1.2 NULL HANDLING ###


select * from events_cleaned;

select event_id
from events_cleaned
where event_id is null;

select event_id
from events_cleaned
where store_id is null;

select event_id
from events_cleaned
where campaign_id is null;

select event_id
from events_cleaned
where product_code is null;

select event_id
from events_cleaned
where base_price is null;

select event_id
from events_cleaned
where promo_type is null;

select event_id
from events_cleaned
where quantity_sold(before_promo) is null;

select event_id
from events_cleaned
where quantity_sold(after_promo) is null;
                                                                                                             ### No Null Found ###
                                                                  
	                                    ###  1.3 ERROR  HANDLING  ###
    
select *
from events_cleaned
;

select distinct(event_id)
from events_cleaned;

select distinct(store_id)
from events_cleaned;

select distinct(campaign_id)
from events_cleaned;

select distinct(product_code)
from events_cleaned;

select distinct(base_price)
from events_cleaned;

select distinct(promo_type)
from events_cleaned;
                                                                                                     ### No Error found #####
                            

            ###  OTHER TABLES ARE HAVING LESS DATA SO INSETEAD OF CHECKING FOR NULL,ERROR,DUPLICATES IN SQL I CHECKED THAT IN EXCEL  ###