USE air_bnb -- *using airbnb DATABASE has created in the creator's dbeaver USER application

#KPI's requirement

-- Find out Total Listing
SELECT count(id) AS total_listing FROM listings l 

-- Find out Total Review
SELECT count(listing_id) AS total_review FROM reviews r


#Problem statements

##Listing distribution
-- Find out room_type distribution
SELECT 
	n.neighborhood_group,
	count(l.id) AS total_listing
FROM neighborhood n
JOIN listings l
	ON l.neighbourhood = n.neighborhood
GROUP BY n.neighborhood_group
ORDER BY total_listing DESC;


##Room_type distribusi
-- Find out most frequently room in Singapore
SELECT  
	rt.room_type,
	count(l.id) AS room_type_amount,
	ROUND((COUNT(l.id) * 100.0 / (SELECT COUNT(id) FROM listings)), 0) AS percentage
FROM room_type rt
JOIN listings l 
	ON l.room_type = rt.room_type
GROUP BY rt.room_type
ORDER BY 
	room_type_amount DESC, 
	percentage;

-- Does market share affect the number of guests staying?
SELECT 
	rt.room_type,
	count(l.id) AS guest_total
FROM room_type rt 
JOIN listings l 
	ON l.room_type = rt.room_type 
JOIN reviews r 
	ON r.listing_id = l.id 
GROUP BY rt.room_type
ORDER BY guest_total DESC;


##Price unit
-- Find out the distribution of price ranges based on room type
SELECT 
	rt.room_type,
	min(l.price) AS floor_price, 
	max(l.price) AS ceilling_price 
FROM room_type rt
JOIN listings l 
	ON l.room_type = rt.room_type
GROUP BY rt.room_type;

-- Find out average price
SELECT
	rt.room_type,
	round(avg(l.price), 0) AS avg_price
FROM room_type rt
JOIN listings l 
	ON l.room_type = rt.room_type
GROUP BY rt.room_type
ORDER BY avg_price DESC;


##Total revenue
SELECT 
	rt.room_type,
	sum(l.price*l.minimum_nights) AS total_revenue
FROM room_type rt
JOIN listings l 
	ON l.room_type = rt.room_type
JOIN reviews r 
	ON r.listing_id = l.id 
GROUP BY rt.room_type
ORDER BY total_revenue DESC;