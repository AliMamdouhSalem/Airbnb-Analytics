{{
    config(
        materialized= 'table'
    )
}} 

with 

r as (

    select * from {{ref("fct_reviews")}}

),

fm as (

    select * from {{ref("seed_full_moon_dates")}}

)

select 
    r.*,
    case
        when fm.full_moon_date is not null
        then 'not fullmoon'
        else 'full moon'
    end as is_full_moon
from
    r
    left join 
    fm
    on to_date(r.review_date) = dateadd(day,1,fm.full_moon_date) 
