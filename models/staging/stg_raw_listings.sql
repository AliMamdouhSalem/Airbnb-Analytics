with 

source as (

    select * from {{ source('staging', 'raw_listings') }}

),

renamed as (

    select
        id as listing_id,
        listing_url,
        name,
        room_type,
        minimum_nights,
        host_id,
        price,
        created_at,
        updated_at

    from source

)

select * from renamed
