SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['stg.year', 'stg.month', 'f.flat_id', 'l.location_id', 'stg.resale_price', 'stg.storey_range', 'stg.floor_area_sqm', 'stg.remaining_lease', 'stg.lease_commence_date']) }} AS resale_id,
    stg.year,
    stg.month,
    stg.storey_range,
    stg.floor_area_sqm,
    stg.lease_commence_date,
    stg.remaining_lease,
    stg.resale_price,
    f.flat_id,
    l.location_id
FROM {{ ref('stg_hdb_resale') }} AS stg
JOIN {{ ref('dim_flat') }} AS f
ON f.flat_type = stg.flat_type 
AND f.flat_model = stg.flat_model
JOIN {{ ref('dim_location') }} AS l 
ON l.town = stg.town
AND l.block = stg.block
AND l.street_name = stg.street_name