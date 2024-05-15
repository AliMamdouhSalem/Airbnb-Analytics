with 
mart_fullmoon_reviews as(

    select * from {{ref("mart_fullmoon_review")}}

)

select 
    is_full_moon,
    review_sentiment,
    count(*) as reviews 
from 
    mart_fullmoon_review
group by
    is_full_moon,
    review_sentiment