with trips_unioned as (
    select * from {{ ref('int_trips_unioned') }}
),

facts as (
    select
        ROW_NUMBER() OVER (ORDER BY pickup_datetime) AS trip_id,
        vendor_id,
        rate_code_id,
        pickup_location_id,
        dropoff_location_id,
        pickup_datetime,
        dropoff_datetime,
        trip_duration,
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
        total_amount,
        {{get_payment_type(payment_type)}} as payment_type
        

    from trips_unioned
)

select distinct payment_type from facts order by payment_type

