CREATE TABLE IF NOT EXISTS  public.shipping_status (
	shippingid int8,
    status TEXT,
    state TEXT,
    shipping_start_fact_datetime TIMESTAMP ,
    shipping_end_fact_datetime TIMESTAMP
);

WITH max_state_datetime AS (
    SELECT
        shippingid,
        MAX(state_datetime) AS max_datetime
    FROM  public.shipping
    GROUP BY shippingid
),
start_day AS (
	SELECT 
		shippingid,
		CASE WHEN state='booked' THEN state_datetime END start_d
FROM  public.shipping s 
),
end_day AS (
		SELECT 
		shippingid,
		CASE WHEN state='recieved' THEN state_datetime END end_d
FROM  public.shipping s 
)
INSERT INTO shipping_status
SELECT
    s.shippingid,
    s.state,
    s.status,
    sd.start_d,
    ed.end_d
FROM  public.shipping s
JOIN max_state_datetime m ON s.shippingid = m.shippingid AND m.max_datetime=s.state_datetime 
JOIN start_day sd ON sd.shippingid=s.shippingid 
JOIN end_day ed ON ed.shippingid =s.shippingid 
WHERE sd.start_d IS NOT NULL AND ed.end_d IS NOT NULL
GROUP BY s.shippingid,s.state,s.status ,sd.start_d,ed.end_d;

