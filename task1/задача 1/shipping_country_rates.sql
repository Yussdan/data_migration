create table if not exists public.shipping_country_rates(
	id SERIAL,
	shipping_country text,
	shipping_country_base_rate numeric(14,2),
	primary key (id)
	);
insert into public.shipping_country_rates(shipping_country,shipping_country_base_rate)
select distinct shipping_country, shipping_country_base_rate from public.shipping;