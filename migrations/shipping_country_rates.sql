CREATE TABLE IF NOT EXISTS public.shipping_country_rates(
	id SERIAL,
	shipping_country TEXT,
	shipping_country_base_rate NUMERIC(14,2),
	PRIMARY KEY (id)
	);
INSERT INTO public.shipping_country_rates(shipping_country,shipping_country_base_rate)
SELECT 
	DISTINCT shipping_country, shipping_country_base_rate 
FROM public.shipping;