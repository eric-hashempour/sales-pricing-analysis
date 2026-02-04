
-- stg_orders
SELECT *
FROM stg_orders


-- dim_products
IF OBJECT_ID('dim_products', 'U') IS NOT NULL
	DROP TABLE dim_products;
SELECT DISTINCT
[Product ID]
, Category
, [Sub-Category]
, MAX([Product Name]) AS [Product Name]     -- Some products have multiple names/change their names over time
INTO dim_products 
FROM stg_orders
GROUP BY
[Product ID]
, Category
, [Sub-Category];

SELECT *
FROM dim_products;


-- dim_customers
IF OBJECT_ID('dim_customers', 'U') IS NOT NULL
	DROP TABLE dim_customers;
SELECT DISTINCT
[Customer ID]
, [Customer Name]
, Segment
INTO dim_customers
FROM stg_orders;

SELECT *
FROM dim_customers;


-- dim_geography
IF OBJECT_ID('dim_geography', 'U') IS NOT NULL
	DROP TABLE dim_geography;
SELECT DISTINCT
[State]
, Region
INTO dim_geography
FROM stg_orders;


SELECT *
FROM dim_geography;


-- fact_sales
IF OBJECT_ID('fact_sales', 'U') IS NOT NULL
	DROP TABLE fact_sales;
SELECT
[Row ID]
, FORMAT([Order Date], 'yyyy-MM') AS order_year_month
, [Order ID]
, [Product ID]		-- Foreign Keys
, [Customer ID]
, [State]
, Region
, Category
, [Sub-Category]
, Sales
, Quantity
, Discount
, [Discount Flag]
, Profit
, [Profit Margin]
, [Loss Flag]
INTO fact_sales
FROM stg_orders;

SELECT *
FROM fact_sales;


-- agg_sales_time_product (view)
IF OBJECT_ID('agg_sales_time_product', 'V') IS NOT NULL
    DROP VIEW agg_sales_time_product;
GO
CREATE VIEW agg_sales_time_product AS
SELECT
[Product ID]
, FORMAT([Order Date], 'yyyy-MM') AS order_year_month
, SUM(Quantity) AS total_quantity
, SUM(Sales) AS total_sales
, SUM(Profit)AS total_profit
, ROUND(SUM(Profit)*1.0/NULLIF(SUM(Sales), 0), 2) AS total_profit_margin
FROM stg_orders
GROUP BY 
[Product ID]
, FORMAT([Order Date], 'yyyy-MM')


-- agg_sales_category_region (view)
IF OBJECT_ID('agg_sales_category_region', 'V') IS NOT NULL
    DROP VIEW agg_sales_category_region;
GO
CREATE VIEW agg_sales_category_region AS
SELECT
Category
, [Sub-Category]
, Region
, FORMAT([Order Date], 'yyyy-MM') AS order_year_month
, SUM(Quantity) AS total_quantity
, SUM(Sales) AS total_sales
, SUM(Profit)AS total_profit
FROM stg_orders
GROUP BY 
Category
, [Sub-Category]
, Region
, FORMAT([Order Date], 'yyyy-MM')


-- price_elasticity_inputs
IF OBJECT_ID('price_elasticity_inputs', 'V') IS NOT NULL
    DROP VIEW price_elasticity_inputs;
GO
CREATE VIEW price_elasticity_inputs AS
SELECT
[Product ID]
, [Category]
, [Sub-Category]
, FORMAT([Order Date], 'yyyy-MM') AS order_year_month
, SUM(Quantity) AS total_quantity
, SUM(Sales) AS total_sales
, SUM(Profit) AS total_profit
, ROUND(SUM(Profit)*1.0 / SUM(Sales), 2) AS total_profit_margin
, ROUND(SUM(Sales) / NULLIF(SUM(Quantity), 0), 2) AS price_per_unit
, ROUND(SUM(Discount * Quantity) / NULLIF(SUM(Quantity), 0), 4) AS avg_discount
FROM stg_orders
GROUP BY
[Sub-Category]
, [Category]
, [Product ID]
, FORMAT([Order Date], 'yyyy-MM');


-- pricing_simulation_base
IF OBJECT_ID('pricing_simulation_base', 'V') IS NOT NULL
    DROP VIEW pricing_simulation_base;
GO
CREATE VIEW pricing_simulation_base AS
SELECT
[Product ID]
, Category
, [Sub-Category]
, Region
, ROUND(AVG(Quantity), 2) AS baseline_quantity
, ROUND(AVG(Sales) / AVG(NULLIF(Quantity, 0)), 2) AS baseline_price
, ROUND(AVG(Profit), 2) AS baseline_profit
FROM stg_orders
WHERE YEAR([Order Date]) =
	(
		SELECT 
		MAX(YEAR([Order Date])) 
		FROM stg_orders
	)
GROUP BY 
[Product ID]
, Category
, [Sub-Category]
, Region


-- pricing_recommendations
--SELECT
--[Product ID]
--, Category
--, [Sub-Category]
--, Region
--, recommended_action
--, expected_revenue_change
--, expected_profit_change
--FROM stg_orders