CREATE TABLE IF NOT EXISTS public.shipping_agreement(
	agreement_id INT4,
	agreement_number VARCHAR(256),
	agreement_rate NUMERIC(14,2),
	agreement_commission NUMERIC(14,3),
	PRIMARY KEY (agreement_id) 
	);
INSERT INTO public.shipping_agreement
SELECT DISTINCT cast(arr[1] AS INT) AS id,arr[2],cast(arr[3] AS NUMERIC(14,2)),cast(arr[4] AS NUMERIC(14,3)) FROM (
SELECT regexp_split_to_array(vendor_agreement_description, ':+') AS arr FROM public.shipping s) AS tmp_arr
ORDER BY id;