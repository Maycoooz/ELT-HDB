# ELT-HDB
ELT pipeline for HDB resale data from 2017 - 2026

## Stack
- **Meltano** — extract from local DuckDB, load into BigQuery
- **dbt** — transform raw BigQuery data into staging and mart layers
- **Dagster** — orchestrate the full pipeline (coming soon)

## Prerequisites
- Miniconda or Anaconda
- Google Cloud Platform account with BigQuery enabled
- GCP service account JSON key with BigQuery permissions
- DuckDB file with HDB resale data (viewable in DBeaver)

## Setup

### 1. Create conda environment
```bash
conda env create -f environment.yml
conda activate env
```

### 2. Configure environment variables
```bash
cp hdb-meltano/.env.example hdb-meltano/.env
```
Edit `.env` and fill in your own paths:
- `TAP_DUCKDB_PATH` — path to your local DuckDB file
- `TARGET_BIGQUERY_CREDENTIALS_PATH` — path to your GCP service account JSON key

### 3. Install Meltano plugins
```bash
cd hdb-meltano
meltano install
```

### 4. Run the ELT pipeline
```bash
meltano run tap-duckdb target-bigquery
```
This will extract 231,971 records from DuckDB and load them into the `hdb_raw` dataset in BigQuery.

### 5. Configure dbt
```bash
cd ../hdb_transform
dbt debug
```
Ensure all checks pass before running any models.

## Project Structure
```
ELT-HDB/
├── environment.yml           # conda environment
├── hdb-meltano/              # Meltano ELT project
│   ├── meltano.yml           # plugin config
│   ├── .env.example          # environment variable template
│   └── plugins/
│       ├── extractors/       # tap-duckdb definition
│       └── loaders/          # target-bigquery definition
└── hdb_transform/            # dbt transformation project
    ├── dbt_project.yml       # dbt config
    ├── profiles.yml          # BigQuery connection config
    └── models/
        ├── staging/
        │   ├── sources.yml   # points to hdb_raw in BigQuery
        │   └── stg_hdb_resale.sql
        └── marts/
            ├── schema.yml
            ├── fact_resale.sql
            └── dim_flat_type.sql
```

## BigQuery Structure
```
hdb-resale-497709/
├── hdb_raw                   # raw data loaded by Meltano
│   └── main_hdb_resale       # 231,971 rows
├── hdb_transform_staging     # dbt staging views (coming soon)
└── hdb_transform_marts       # dbt mart tables (coming soon)
```