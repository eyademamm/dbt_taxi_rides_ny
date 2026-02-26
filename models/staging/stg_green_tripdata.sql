with source as (
    select * from {{ source('raw_data', 'green_tripdata') }}
),




renamed as (
        select 
        cast(vendorid as int64) as vendor_id,
        cast(ratecodeid as int64) as rate_code_id,
        cast(pulocationid as int64) as pickup_location_id,
        cast(dolocationid as int64) as dropoff_location_id,

        -- timestamps
        cast(lpep_pickup_datetime as timestamp) as pickup_datetime,
        cast(lpep_dropoff_datetime as timestamp) as dropoff_datetime,

        -- trip info
        store_and_fwd_flag,
        cast(passenger_count as int) as passenger_count,
        cast(trip_distance as numeric) as trip_distance,
        cast(trip_type as int) as trip_type,

        -- payment info
        cast(fare_amount as numeric) as fare_amount,
        cast(extra as numeric) as extra,
        cast(mta_tax as numeric) as mta_tax,
        cast(tip_amount as numeric) as tip_amount,
        cast(tolls_amount as numeric) as tolls_amount,
        cast(improvement_surcharge as numeric) as improvement_surcharge,
        cast(ehail_fee as numeric) as ehail_fee,
        'green' as service_type,
        cast(total_amount as numeric) as total_amount,
        cast(payment_type as int) as payment_type

    from source
    where vendorid is not null
)




select * from renamed