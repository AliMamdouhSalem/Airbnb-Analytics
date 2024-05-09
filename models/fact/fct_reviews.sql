{{
    config(
        materialized= 'incremental',
        on_schema_change='fail'
    )
}}

with
stg_raw_reviews as (

    select * from {{ref("stg_raw_reviews")}}

)

select 
    listing_id,
    review_date,
    reviewer_name,
    review_text,
    review_sentiment
from stg_raw_reviews
where
    review_text is not null
    {% if is_incremental() %}
        and review_date>(select max(review_date) from {{ this }})
    {% endif %}
