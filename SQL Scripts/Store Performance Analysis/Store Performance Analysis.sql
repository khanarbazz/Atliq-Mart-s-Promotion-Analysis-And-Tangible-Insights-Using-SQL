                                                 #########  STORE PERFORMANCE ANALYSIS  ###############


use atliq_mart_db;

### Created table with name "events_updated"  Kindly check DDl & DML Script 


##1  Which are the top 10 stores in terms of Incremental Revenue (IR) generated from the promotions?


select * 
from (
	   select Dense_rank() over(order by `Incremental Revenue` desc) as Ranks,
       store_id as `Store ID`,
       `Incremental Revenue`
		from events_updated) as I
where Ranks<=10 ;


##2 Which are the bottom 10 stores when it comes to Incremental Sold Units (ISU) during the promotional period?


select *
from (
		select Dense_rank() over(order by `Incremental Sold units` ASC) as Ranks, 
		store_id as `Store ID`,
		`Incremental Sold Units`
		from events_updated ) as I
where Ranks<=10;


##3  How does the performance of stores vary by city?
## Are there any common characteristics among the top-performing stores that could be leveraged across other stores?


create view `Common Characteristics` as
	select city,`promo_category`,
		   avg(`incremental Revenue`) as `IR`,
		   avg(`incremental sold units`) as `ISU`,
		   count(E.store_id) as `Num of Stores`,
		   row_number() over(partition  by city order by avg(`incremental Revenue`) desc) as Ranks
	from events_updated as E
	inner join stores_cleaned as S
		  on E.store_id=S.store_id
		  group by city,`promo_category` ;
          


select * 
from `Common Characteristics`
where ranks=1;

select * 
from `Common Characteristics`
where ranks=2;

select * 
from `Common Characteristics`
where ranks=3;
select * from `Common Characteristics`;

###Common Characteristics as per analysis;
 ## 1)Promo Category -  Promo category "Cashback" (Which is approx. 16.66% as we know from the given data) as having no loss in revenue as compared to category "Percentage" which is having almost all the revenue in minus
					    ## reason it that the discount percentage is too high.
 ## 2)Number of stores - Number of stores is not that much impactful when the percentage of discount is extreme.