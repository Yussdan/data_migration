create table if not exists public.shipping_transfer(
	id serial,
	transfer_type varchar(100),
	transfer_model varchar(100),
	shipping_transfer_rate numeric(14,3),
	primary key (id) 
	);
insert into public.shipping_transfer(transfer_type,transfer_model,shipping_transfer_rate)
select distinct arr[1], arr[2],shipping_transfer_rate from(
select regexp_split_to_array(shipping_transfer_description, ':+') as arr,shipping_transfer_rate from public.shipping s) tmp_arr