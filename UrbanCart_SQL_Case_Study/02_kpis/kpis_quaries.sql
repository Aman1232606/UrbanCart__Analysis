SELECT
  ROUND(SUM(sales), 2)  AS total_sales,
  ROUND(SUM(profit), 2) AS total_profit,
  COUNT(DISTINCT order_id) AS total_orders,
  ROUND(AVG(profit_margin) * 100, 2) AS avg_profit_margin_pct
FROM public.urban_cart_sales;

SELECT
  COUNT(DISTINCT customer_id) AS total_customers,
  ROUND(SUM(sales) / NULLIF(COUNT(DISTINCT order_id), 0), 2) AS avg_order_value
FROM public.urban_cart_sales;

SELECT
  COUNT(*) AS total_order_lines,
  SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_lines,
  ROUND(
    100.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS loss_lines_pct
FROM public.urban_cart_sales;

SELECT
  ROUND(AVG(delivery_days), 2) AS avg_delivery_days
FROM public.urban_cart_sales;
