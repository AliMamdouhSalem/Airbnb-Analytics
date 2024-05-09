{{
    config(
        materialized= 'view',
    )
}} 

with
stg_raw_hosts as (

    select * from {{ref("stg_raw_hosts")}}

)
select
    host_id,
    nvl(host_name,'Anon') as host_name,
    is_superhost,
    created_at,
    updated_at
from 
    stg_raw_hosts