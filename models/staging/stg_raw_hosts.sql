with 

source as (

    select * from {{ source('staging', 'raw_hosts') }}

),

renamed as (

    select
        id as host_id,
        name as host_name,
        is_superhost,
        created_at,
        updated_at

    from source

)

select * from renamed
