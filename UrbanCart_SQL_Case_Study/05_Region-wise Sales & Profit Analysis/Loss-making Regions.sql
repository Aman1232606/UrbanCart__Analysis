SELECT
  region,
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit_margin) * 100, 2) AS avg_profit_margin_pct
FROM public.urban_cart_sales
GROUP BY region
ORDER BY total_sales DESC;

SELECT
  region,
  ROUND(SUM(profit), 2) AS total_profit
FROM public.urban_cart_sales
GROUP BY region
HAVING SUM(profit) < 0
ORDER BY total_profit;

SELECT
  region,
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND((SUM(profit) / NULLIF(SUM(sales),0)) * 100, 2) AS profit_to_sales_pct
FROM public.urban_cart_sales
GROUP BY region
ORDER BY profit_to_sales_pct DESC;
