SELECT
  years,
  months,
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM public.urban_cart_sales
GROUP BY years, months
ORDER BY years, months;

SELECT COUNT(*) 
FROM public.urban_cart_sales
WHERE months IS NULL;

SELECT
  EXTRACT(YEAR FROM order_date)  AS year,
  EXTRACT(MONTH FROM order_date) AS month,
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit
FROM public.urban_cart_sales
GROUP BY
  EXTRACT(YEAR FROM order_date),
  EXTRACT(MONTH FROM order_date)
ORDER BY year, month;
