A. Hotel Management System
1. Last booked room for every user
SELECT 
    b.user_id,
    b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) AS last_booking
    FROM bookings
    GROUP BY user_id
) lb
ON b.user_id = lb.user_id 
AND b.booking_date = lb.last_booking;

2. Booking ID & total billing (Nov 2021)
SELECT 
    bc.booking_id,
    SUM(i.item_rate * bc.item_quantity) AS total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-11'
GROUP BY bc.booking_id;

3. Bills in Oct 2021 with amount > 1000
SELECT 
    bc.bill_id,
    SUM(i.item_rate * bc.item_quantity) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE DATE_FORMAT(bc.bill_date, '%Y-%m') = '2021-10'
GROUP BY bc.bill_id
HAVING bill_amount > 1000;

4. Most & least ordered item each month (2021)
WITH item_orders AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.item_id,
        SUM(bc.item_quantity) AS total_qty
    FROM booking_commercials bc
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.item_id
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total_qty DESC) AS max_rank,
        RANK() OVER (PARTITION BY month ORDER BY total_qty ASC) AS min_rank
    FROM item_orders
)
SELECT *
FROM ranked
WHERE max_rank = 1 OR min_rank = 1;

5. Second highest bill per month (2021)
WITH monthly_bills AS (
    SELECT 
        DATE_FORMAT(bc.bill_date, '%Y-%m') AS month,
        bc.bill_id,
        SUM(i.item_rate * bc.item_quantity) AS total_bill
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY month, bc.bill_id
),
ranked AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY month ORDER BY total_bill DESC) AS rnk
    FROM monthly_bills
)
SELECT *
FROM ranked
WHERE rnk = 2;
