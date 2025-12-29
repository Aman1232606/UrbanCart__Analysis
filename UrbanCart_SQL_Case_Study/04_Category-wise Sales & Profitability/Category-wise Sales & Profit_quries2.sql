SELECT
  category,
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  ROUND(AVG(profit_margin) * 100, 2) AS avg_profit_margin_pct
FROM public.urban_cart_sales
GROUP BY category
ORDER BY total_sales DESC;


