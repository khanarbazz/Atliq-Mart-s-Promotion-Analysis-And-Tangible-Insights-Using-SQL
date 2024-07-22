
create database Atliq_mart_db;                                   ##MySQL Server name :127.0.0.1                 port no:3306

use Atliq_mart_db;

select * from campaigns;
select * from events;
select * from products;
select * from stores;
select * from events_manipulated;


select * from events_cleaned;

select * from events_manipulated;


##Creating Events_updated with Revenue before and after

create table events_updated
select * from events_manipulated;
            
      
alter table events_updated
add column `Revenue Before` int,
add column `Revenue After` int;


Update events_updated
SET `Revenue Before` = base_price * `quantity_sold(before_promo)`,
	`Revenue After` = (base_price - (base_price * (promo/100))) * `quantity_sold(after_promo)`;


##Adding  ISU and ISU %

alter table events_updated
add column  `Incremental Sold Units` int;

update  events_updated
set `Incremental Sold Units`= `quantity_sold(after_promo)`-`quantity_sold(before_promo)`;

alter table events_updated
add column  `Incremental Sold Units percentage` int;

update  events_updated
set `Incremental Sold Units Percentage`= ((`quantity_sold(after_promo)`-`quantity_sold(before_promo)`)/ `quantity_sold(before_promo)`)*100;


##Addinf IR and IR % 

alter table events_updated
add column `Incremental Revenue` int;
select * from products_cleand;
update events_updated
set `Incremental Revenue`= round(((base_price-(base_price*(promo/100)))*`quantity_sold(after_promo)`)-(base_price*`quantity_sold(before_promo)`),0);

alter table events_updated
add column `Incremental Revenue %` int;
select * from products_cleand;
update events_updated
set `Incremental Revenue %`= (`Incremental Revenue`/`Revenue Before`)*100;

