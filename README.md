# AtliQ Mart’s Promotions Analysis and Tangible Insights!

This repository contains the SQL scripts used to analyze the performance of promotional campaigns run by AtliQ Mart during Diwali 2023 and Sankranti 2024. The project addresses various business requests related to identifying high-value discounted products, store distribution, campaign effectiveness, and product performance in terms of incremental sales and revenue.

## Introduction

Promotions are a pivotal aspect of retail strategy, especially during festive seasons. This project focuses on evaluating the impact of promotional campaigns conducted by AtliQ Mart during Diwali 2023 and Sankranti 2024. By analyzing various metrics such as incremental revenue, sold units, and store performance, this analysis aims to provide actionable insights to enhance future promotional strategies and maximize returns.

## Data Sources

The analysis is based on data provided by the AtliQ team. The main datasets include:
- **fact_events**
- **dim_products**
- **dim_stores**
- **sales_summary**

These datasets contain information about product sales, store locations, promotional events, and campaign revenues.

## Project Overview

1. Analyzed promotional campaigns during Diwali 2023 and Sankranti 2024 using internal data from AtliQ Mart.
2. Executed SQL queries to address key business requests focused on product, store, and campaign performance.
3. Identified high-value products, analyzed store distribution, and evaluated the effectiveness of various promotion types.
4. Generated actionable insights to optimize future marketing strategies and improve overall sales performance.

## Business Requests

### 1. High-Value Products in BOGOF Promotion
**Query:**
Provide a list of products with a base price greater than 500 that are featured in the promo type of 'BOGOF' (Buy One Get One Free).

```sql
select distinct(E.product_code),
	   product_name
from events_cleaned as E
inner join products_cleand as P
	on E.product_code=P.product_code
	where E.Promo_type='BOGOF'
	And E.base_price>500;
```

**Purpose:**
Identify high-value products that are heavily discounted to evaluate pricing and promotion strategies.

### 2. Store Count by City
**Query:**
Generate a report that provides an overview of the number of stores in each city, sorted in descending order of store counts.

```sql
select count(store_id) as `Number Of Stores`,
	   city as City
from stores_cleaned
	group by city
	order by count(store_id) desc;
```
**Purpose:**
Identify cities with the highest store presence to assist in optimizing retail operations.

### 3. Campaign Revenue Impact
**Query:**
Generate a report displaying each campaign along with the total revenue generated before and after the campaign.

```sql
select campaign_name as Campaign,
       concat((round(sum(`Revenue Before`)/1000000,0)),' ','M') as `Revenue Before`,
       concat((round(sum(`Revenue After`)/1000000,0)),' ','M') as `Revenue After`
from events_updated as E
inner join campaigns_cleaned as C
	on E.campaign_id=C.campaign_id
	Group by C.campaign_name;
```
**Purpose:**
Evaluate the financial impact of promotional campaigns.

### 4. Diwali Campaign ISU% by Category
**Query:**
Produce a report that calculates the Incremental Sold Quantity (ISU%) for each category during the Diwali campaign and provide rankings based on ISU%.

```sql
select category as Category,
       `Incremental Sold Units Percentage`,
       rank() over(order by `Incremental Sold Units Percentage` desc) as Ranks
from events_updated as E
inner join products_cleand as P
	on E.Product_code=P.Product_code
inner join campaigns_cleaned as C
	on E.Campaign_id=C.Campaign_id
	where Campaign_name='Diwali';
```

**Purpose:**
Assess the category-wise success and impact of the Diwali campaign on incremental sales.

### 5. Top 5 Products by IR%
**Query:**
Create a report featuring the Top 5 products, ranked by Incremental Revenue Percentage (IR%), across all campaigns.

```sql
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
```

**Purpose:**
Identify the most successful products in terms of incremental revenue across campaigns to assist in product optimization.

## Results and Insights

The analysis revealed several key insights:
- Identify high-value BOGOF products and assess their impact on discounting strategies.
- Determine top and bottom-performing stores based on incremental revenue and sold units, and analyze city-wise store performance.
- Evaluate promotion types to find the most effective for revenue generation and the least impactful on sold units.
- Analyze product categories and specific products for significant sales lifts from promotions and their responsiveness to different promotion types.
- Review revenue impact before and after campaigns and rank categories and products by incremental sales and revenue percentage.

These insights can help AtliQ Mart make informed decisions for future promotional activities, optimize resource allocation, and improve overall sales performance.

## Conclusion

Overall, the analysis provides valuable insights into the performance of promotional campaigns conducted by AtliQ Mart during Diwali 2023 and Sankranti 2024. By leveraging data analytics, AtliQ Mart can enhance its marketing strategies, attract more customers, and drive higher sales during festive seasons.

## Additional Insights

In addition to the main business requests, the following recommended insights were explored:

### Store Performance Analysis
- **Top 10 Stores by Incremental Revenue (IR):** Identify stores with the highest additional revenue from promotions.
- **Bottom 10 Stores by Incremental Sold Units (ISU):** Identify stores with the least increase in sold units.
- **City-wise Store Performance:** Analyze performance variations by city and identify characteristics of top-performing stores.

### Promotion Type Analysis
- **Top 2 Promotion Types by Incremental Revenue:** Determine which promotions generated the highest additional revenue.
- **Bottom 2 Promotion Types by Incremental Sold Units:** Identify promotions with the least impact on sold units.
- **Comparison of Promotion Types:** Assess differences among discount, BOGOF, and cashback promotions.
- **Optimal Promotion Balance:** Find promotions that balance high sales with good margins.

### Product and Category Analysis
- **High-Lifting Product Categories:** Identify categories with the largest sales increase from promotions.
- **Product Responsiveness to Promotions:** Determine which products performed exceptionally well or poorly.
- **Correlation Between Product Category and Promotion Type:** Analyze how different categories respond to various promotion types
