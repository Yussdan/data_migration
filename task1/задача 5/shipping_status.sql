CREATE TABLE IF NOT EXISTS  public.shipping_status (
	shippingid int8,
    status text,
    state text,
    shipping_start_fact_datetime timestamp ,
    shipping_end_fact_datetime timestamp
);

WITH max_state_datetime AS (
    SELECT
        shippingid,
        MAX(state_datetime) AS max_datetime
    FROM  public.shipping
    GROUP BY shippingid
),
start_day as (
	select 
		shippingid,
		case when state='booked' then state_datetime end start_d
from  public.shipping s 
),
end_day as (
		select 
		shippingid,
		case when state='recieved' then state_datetime end end_d
from  public.shipping s 
)
INSERT INTO shipping_status
SELECT
    s.shippingid,
    s.state,
    s.status,
    sd.start_d,
    ed.end_d
FROM  public.shipping s
JOIN max_state_datetime m ON s.shippingid = m.shippingid and m.max_datetime=s.state_datetime 
join start_day sd on sd.shippingid=s.shippingid 
join end_day ed on ed.shippingid =s.shippingid 
where sd.start_d is not null and ed.end_d is not null
GROUP BY s.shippingid,s.state,s.status ,sd.start_d,ed.end_d;

