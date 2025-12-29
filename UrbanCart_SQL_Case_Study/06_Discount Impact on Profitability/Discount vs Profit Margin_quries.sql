SELECT
  ROUND(discount * 100, 0) AS discount_pct,
  COUNT(*) AS order_lines,
  ROUND(AVG(profit_margin) * 100, 2) AS avg_profit_margin_pct
FROM public.urban_cart_sales
GROUP BY ROUND(discount * 100, 0)
ORDER BY discount_pct;

SELECT
  ROUND(discount * 100, 0) AS discount_pct,
  COUNT(*) AS total_lines,
  SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_lines,
  ROUND(
    100.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS loss_line_pct
FROM public.urban_cart_sales
GROUP BY ROUND(discount * 100, 0)
ORDER BY discount_pct;
