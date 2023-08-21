CREATE VIEW public.shipping_datamart AS 
(
    SELECT 
        distinct
        s.shippingid,
        vendorid,
        transfer_type,
        shipping_end_fact_datetime::DATE-shipping_start_fact_datetime::DATE AS full_day_at_shipping,
        CASE WHEN shipping_end_fact_datetime > s.shipping_plan_datetime THEN 1 ELSE 0 END AS is_delay,
        case when ss.status='finished' then 1 else 0 end is_shipping_finish,
        CASE WHEN shipping_end_fact_datetime > s.shipping_plan_datetime THEN (shipping_end_fact_datetime::DATE - s.shipping_plan_datetime::DATE) ELSE 0 END AS delay_day_at_shipping,
        s.payment_amount,
        s.payment_amount * (scr.shipping_country_base_rate + agreement_rate + st.shipping_transfer_rate) AS vat,
        s.payment_amount * agreement_commission AS profit
    FROM 
        public.shipping s
    INNER JOIN 
         public.shipping_info si ON si.shipping_id = s.shippingid
    INNER JOIN 
         public.shipping_agreement sa ON si.agreement_id = sa.agreement_id 
    INNER JOIN 
         public.shipping_country_rates scr ON si.shipping_country_rate_id = scr.id 
    INNER JOIN 
         public.shipping_transfer st ON st.id = si.transfer_id 
    INNER JOIN 
         public.shipping_status ss ON ss.shippingid = s.shippingid
);
