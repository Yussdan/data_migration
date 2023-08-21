CREATE TABLE   public.shipping_info (
    shipping_id INT,
    agreement_id INT REFERENCES shipping_agreement(agreement_id),
    transfer_id INT REFERENCES shipping_transfer(id),
    shipping_country_rate_id INT REFERENCES shipping_country_rates(id),
    shipping_plan_datetime timestamp,
    payment_amount numeric(14, 2),
    vendor_id INT);


Insert into shipping_info 
select
	distinct
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
    and st.transfer_model= SPLIT_PART(s.shipping_transfer_description, ':', 2)
inner join 
	 public.shipping_agreement sa on sa.agreement_id= cast(SPLIT_PART(s.vendor_agreement_description, ':', 1) as int4)
order by s.shippingid;