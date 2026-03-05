-- 2018년 1월 1일 이후 일별로 집계된
-- 결제 고객수, 매출액, ARPPU를 계산
SELECT
  DATE_FORMAT(order_purchase_timestamp, '%Y-%m-%d') AS dt,
  COUNT(DISTINCT customer_id) AS pu,
  SUM(payment_value) AS revenue_daily,
  ROUND(SUM(payment_value) / COUNT(DISTINCT customer_id), 2) AS arppu 
FROM
  olist_orders_dataset ood
  JOIN olist_order_payments_dataset  oop ON (ood.order_id = oop.order_id)
WHERE
  order_purchase_timestamp >= '2018-01-01'
GROUP BY
  dt
ORDER BY
  dt ASC;