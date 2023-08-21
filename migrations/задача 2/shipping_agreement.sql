create table if not exists public.shipping_agreement(
	agreement_id int4,
	agreement_number varchar(256),
	agreement_rate numeric(14,2),
	agreement_commission numeric(14,3),
	primary key (agreement_id) 
	);
insert into public.shipping_agreement
select distinct cast(arr[1] as int) as id,arr[2],cast(arr[3] as numeric(14,2)),cast(arr[4] as numeric(14,3)) from (
select regexp_split_to_array(vendor_agreement_description, ':+') as arr from public.shipping s) as tmp_arr
order by id;