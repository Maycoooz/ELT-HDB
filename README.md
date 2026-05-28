# ELT-HDB
ELT pipeline for HDB resale data from 2017 - 2026

## Stack
- **Meltano** — extract from local DuckDB, load into BigQuery
- **dbt** — transform raw BigQuery data into staging, intermediate and mart layers
- **Dagster** — orchestrate the full pipeline

## Prerequisites
- Miniconda or Anaconda
- Google Cloud Platform account with BigQuery enabled
- GCP service account JSON key with BigQuery permissions
- DuckDB file with HDB resale data

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

## Project Structure
```
ELT-HDB/
├── environment.yml          # conda environment
├── hdb-meltano/             # Meltano ELT project
│   ├── meltano.yml          # plugin config
│   ├── .env.example         # environment variable template
│   └── plugins/
│       ├── extractors/      # tap-duckdb definition
│       └── loaders/         # target-bigquery definition
├── hdb-transform/           # dbt transformations (coming soon)
└── hdb-orchestrate/         # Dagster orchestration (coming soon)
```