                                                 #########  PROMOTION TYPE ANALYSIS  ###############


use atliq_mart_db;

##1  What are the top 2 promotion types that resulted in the highest Incremental Revenue


select * from events_updated2;
select `Promo_category` as Promotion,
       `campaign_id` as Campaign,
	    sum(`Revenue Before`) as `Revenue Before`,
        sum(`Revenue After`) as `Revenue After`,
        concaT(round((sum(`Incremental revenue`)/1000000),0),' ','M') as `Total Incremented Revenue`
from events_updated2
group by `Promo_category`,`campaign_id`
	    order by sum(`Incremental revenue`) desc
        limit 2;


##2  What are the bottom 2 promotion types in terms of their impact on Incremental Sold Units?        


select `Promo_category` as Promotion,
	    `campaign_id` as Campaign,
        sum(`quantity_sold(before_promo)`) as `Units Sold Before`,
        sum(`quantity_sold(after_promo)`) as `Units sold After`,
        sum(`Incremental Sold Units`) as `Total Incremented Units`
from events_updated2
group by `Promo_category`,`campaign_id`
	    order by sum(`Incremental Sold Units`) asc
        limit 2;
        

##3  Is there a significant difference in the performance of discount-based promotions versus BOGOF (Buy One Get One Free) or cashback promotions?


create table events_updated2
select * from events_updated;

select * from events_updated2;

alter table events_updated2
add column `Promo Type` varchar(40);

update events_updated2
set `Promo Type` = case 
                       when Promo_category='Percentage' then 'Percentage' else 'BOGOF or Cashback' 
				   end;

select `Promo Type`,
	   sum(`Incremental Revenue`) as `IR`,
       sum(`Incremental Sold units`) as `ISU`
from events_updated2 as E
inner join stores_cleaned as S
		on E.store_id=S.store_id
	group by `Promo Type`;
        
