{{
    config(
        materialized= 'view',
    )
}} 

with
stg_raw_listings as (

    select * from {{ref("stg_raw_listings")}}

)

select 
    listing_id,
    listing_url,
    name,
    room_type,
    case 
        when minimum_nights=0 then 1
        else minimum_nights
    end as minimum_nights,
    host_id,
    cast(substr(price,2) as decimal(10,2)) as price,
    created_at,
    updated_at
FROM 
stg_raw_listings