CREATE TABLE   public.shipping_info (
    shipping_id INT4,
    agreement_id INT4 REFERENCES shipping_agreement(agreement_id),
    transfer_id INT4 REFERENCES shipping_transfer(id),
    shipping_country_rate_id INT4 REFERENCES shipping_country_rates(id),
    shipping_plan_datetime TIMESTAMP,
    payment_amount NUMERIC(14, 2),
    vendor_id INT4);


INSERT INTO shipping_info 
SELECT
	DISTINCT
    s.shippingid,
    sa.agreement_id,
    st.id AS shipping_transfer_id,
    cr.id AS shipping_country_rate_id,
    s.shipping_plan_datetime,
    s.payment_amount,
    s.vendorid
FROM
    public.shipping s
INNER JOIN
     public.shipping_country_rates cr ON s.shipping_country = cr.shipping_country
INNER join
     public.shipping_transfer st ON st.transfer_type = SPLIT_PART(s.shipping_transfer_description, ':', 1) 
    AND st.transfer_model= SPLIT_PART(s.shipping_transfer_description, ':', 2)
INNER JOIN 
	 public.shipping_agreement sa ON sa.agreement_id= cast(SPLIT_PART(s.vendor_agreement_description, ':', 1) AS INT4)
ORDER BY s.shippingid;