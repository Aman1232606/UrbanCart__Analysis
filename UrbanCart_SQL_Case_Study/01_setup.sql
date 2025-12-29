SELECT
  category,
  ROUND(SUM(profit), 2) AS total_profit
FROM public.urban_cart_sales
GROUP BY category
HAVING SUM(profit) < 0
ORDER BY total_profit;

SELECT
  category,
  ROUND(SUM(profit), 2) AS total_profit
FROM public.urban_cart_sales
GROUP BY category
ORDER BY total_profit DESC;

SELECT
  category,
  ROUND(AVG(discount) * 100, 2) AS avg_discount_pct,
  ROUND(AVG(profit_margin) * 100, 2) AS avg_margin_pct
FROM public.urban_cart_sales
GROUP BY category
ORDER BY avg_discount_pct DESC;
