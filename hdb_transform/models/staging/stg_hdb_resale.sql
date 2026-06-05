WITH deduped AS (
    SELECT
        CAST(LEFT(month, 4) AS INTEGER) AS year,
        CAST(RIGHT(month, 2) AS INTEGER) AS month,
        town,
        flat_type,
        block,
        street_name,
        storey_range,
        CAST(floor_area_sqm AS NUMERIC) AS floor_area_sqm,
        flat_model,
        CAST(lease_commence_date AS INTEGER) AS lease_commence_date,
        remaining_lease,
        CAST(resale_price AS NUMERIC) AS resale_price,
        ROW_NUMBER() OVER (
            PARTITION BY month, town, flat_type, block, street_name, 
                         storey_range, floor_area_sqm, flat_model, 
                         lease_commence_date, remaining_lease, resale_price
        ) AS row_num
    FROM {{ source('hdb_raw', 'main_hdb_resale') }}
)

SELECT * EXCEPT(row_num)
FROM deduped
WHERE row_num = 1