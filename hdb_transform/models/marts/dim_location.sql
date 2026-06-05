SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['town', 'block', 'street_name']) }} AS location_id,
    town,
    block,
    street_name
FROM {{ ref("stg_hdb_resale") }}

-- would be better if there is a postal code but the dataset does not provide it