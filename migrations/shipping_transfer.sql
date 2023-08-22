CREATE TABLE IF NOT EXISTS public.shipping_transfer(
	id SERIAL,
	transfer_type VARCHAR(100),
	transfer_model VARCHAR(100),
	shipping_transfer_rate NUMERIC(14,3),
	PRIMARY KEY (id) 
	);
INSERT INTO public.shipping_transfer(transfer_type,transfer_model,shipping_transfer_rate)
SELECT DISTINCT arr[1], arr[2],shipping_transfer_rate 
FROM(
SELECT regexp_split_to_array(shipping_transfer_description, ':+') AS arr,shipping_transfer_rate FROM public.shipping s) tmp_arr