USE Magist;

/* What categories of tech products does Magist have? */
SELECT product_category_name_english AS tech_products From product_category_name_translation 
WHERE product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo','small_appliances',
'small_appliances_home_oven_and_coffee','portable_kitchen_food_processors','home_appliances',
'home_appliances_2','air_conditioning','signaling_and_security','security_and_services');

/* How many products of these tech categories have been sold 
--(within the time window of the database snapshot)? 
What percentage does that represent from the overall number of products sold? */

SELECT COUNT(DISTINCT product_id) 
FROM order_items
JOIN products
USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_translation.product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services');

SELECT COUNT(DISTINCT product_id)
FROM order_items
JOIN products
USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name;

SELECT 4119/32951;

/* What’s the average price of the products being sold? */
SELECT round(avg(price),2) FROM order_items;

-- Average tech sales

SELECT AVG(price) 
FROM order_items
JOIN products
USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_translation.product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services');


-- Tech sales revenue

SELECT SUM(price) 
FROM order_items
JOIN products
USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name;
/* WHERE product_category_name_translation.product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services'); */

SELECT 1986123.12/13591643.70;

/*Are expensive tech products popular? */

SELECT COUNT(product_id), 
CASE 
WHEN price >= 700 THEN "Expensive"
WHEN price > 375 THEN "Medium"
ELSE "Cheap"
END AS price_range
FROM order_items
JOIN products
USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_translation.product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services')
GROUP BY price_range;

-- How many months of data are included in the magist database?

SELECT TIMESTAMPDIFF(MONTH,MIN(order_purchase_timestamp),
MAX(order_purchase_timestamp)) AS data_months
FROM orders;

-- How many sellers are there?

SELECT COUNT(seller_id) AS number_of_sellers FROM sellers;

-- How many Tech sellers are there?

SELECT COUNT(DISTINCT seller_id) AS number_of_sellers FROM sellers
JOIN order_items
USING (seller_id)
JOIN products USING (product_id)
JOIN product_category_name_translation USING (product_category_name)
WHERE product_category_name_translation.product_category_name_english IN 
('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services');

-- What is the total amount earned by all sellers? 
-- What is the total amount earned by all Tech sellers? 

SELECT SUM(price) FROM order_items
JOIN orders USING (order_id)
JOIN products USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE order_status NOT IN ('unavailable','canceled')
AND product_category_name_translation.product_category_name_english IN ('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services');

-- What’s the average time between the order being placed 
-- and the product being delivered?

SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_delivery_in_days
FROM orders
WHERE order_status = "delivered";

-- How many orders are delivered on time 
-- vs orders delivered with a delay?

SELECT 
CASE WHEN
DATEDIFF(order_estimated_delivery_date,order_delivered_customer_date) >= 0
THEN "on time"
ELSE "delayed"
END AS number_of_deliveries,
COUNT(order_id)
FROM orders
GROUP BY number_of_deliveries;
 
-- Tech deliveries
SELECT order_status,
COUNT(order_id)
FROM orders
JOIN order_items USING (order_id)
JOIN products USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE -- order_status NOT IN ('unavailable','canceled')
product_category_name_translation.product_category_name_english IN ('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services')
GROUP BY order_status;


SELECT AVG(review_score)
FROM order_reviews
JOIN order_items USING (order_id)
JOIN products USING (product_id)
JOIN product_category_name_translation 
ON products.product_category_name = product_category_name_translation.product_category_name
WHERE product_category_name_translation.product_category_name_english IN ('audio','computers', 'electornics','computers_accessories','pc_gamer','electronics','telephony','fixed_telephony',
'tablets_printing_image','consoles_games','cds_dvds_musicals','dvds_blu_ray','cine_photo',
'air_conditioning','signaling_and_security','security_and_services');

SELECT 804/17043;