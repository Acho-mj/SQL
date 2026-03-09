WITH filtered_not_canceled AS (
    -- 취소 주문을 제외한 주문 month, 주문 금액의 합계
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, SUM(oi.price) AS ordered_amount
    FROM orders o
    JOIN order_items oi ON (o.order_id = oi.order_id)
    WHERE o.order_id NOT IN (SELECT order_id FROM orders WHERE order_id LIKE 'C%')
    GROUP BY order_month
), filtered_canceled AS (
    -- 취소 주문의 month, 주문 금액의 합계
    SELECT DATE_FORMAT(order_date, '%Y-%m') AS order_month, SUM(oi.price) AS canceled_amount
    FROM orders o
    JOIN order_items oi ON (o.order_id = oi.order_id)
    WHERE o.order_id IN (SELECT order_id FROM orders WHERE order_id LIKE 'C%')
    GROUP BY order_month
)

-- 월 별로 취소 주문을 제외한 주문 금액의 합계, 취소 주문의 금액 합계, 그리고 총 합계
SELECT order_month, ordered_amount, canceled_amount, (ordered_amount + canceled_amount) AS total_amount
FROM filtered_not_canceled fnc
JOIN filtered_canceled fc ON (fnc.order_month = fc.order_month)
GROUP BY order_month
ORDER BY order_month ASC;