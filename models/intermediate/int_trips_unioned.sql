with green_tripdata as (
    select * from {{ ref('stg_green_tripdata') }}
),

 yellow_tripdata as (
    select * from {{ ref('stg_yellow_tripdata') }}
),

trips_unioned as (
    select * from green_tripdata
    union all
    select * from yellow_tripdata
),

duplicates_removed as (
    select 
        ROW_NUMBER() over(partition by vendor_id,pickup_datetime,service_type ORDER BY pickup_datetime) rn,
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,
        pickup_datetime,
        dropoff_datetime,
        timestamp_diff(dropoff_datetime,pickup_datetime,second) as trip_duration,
        passenger_count,
        trip_distance,
        trip_type,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        improvement_surcharge,
        ehail_fee,
        service_type,
        total_amount,
        payment_type

    from trips_unioned
),


final as (
    select * 
    from duplicates_removed
    where rn = 1
)

select * from final