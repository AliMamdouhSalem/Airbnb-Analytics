{{
    config(
        materialized= 'table',
        on_schema_change='fail'
    )
}} 

with 
l as (

    select * from {{ref("dim_listings")}}

),

h as (

    select * from {{ref("dim_hosts")}}

) 

select 
    l.listing_id,
    l.listing_url,
    l.name,
    l.room_type,
    l.minimum_nights,
    l.price,
    l.host_id,
    h.host_name,
    h.is_superhost,
    l.created_at,
    greatest(l.updated_at, h.updated_at) as updated_at
from l
left join h
on l.host_id = h.host_id