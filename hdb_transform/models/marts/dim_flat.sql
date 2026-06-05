SELECT DISTINCT
    {{ dbt_utils.generate_surrogate_key(['flat_type', 'flat_model']) }} AS flat_id,
    flat_type,
    flat_model
FROM {{ ref('stg_hdb_resale') }}