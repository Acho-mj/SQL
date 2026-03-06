WITH filtered AS (
  SELECT day, time, sex, total_bill, DENSE_RANK() OVER(PARTITION BY day ORDER BY total_bill DESC) as ranking
  FROM tips
)
SELECT day, time, sex, total_bill
FROM filtered 
WHERE ranking <= 3