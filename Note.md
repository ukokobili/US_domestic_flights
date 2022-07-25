docker-compose run --workdir="//usr/app/dbt/us_flights" dbt-bq debug

docker compose run --workdir="//usr/app/dbt/project_name" service-name debug

docker compose run flights-bq init

export DBT_PROFILES_DIR=c/Users/DELL/.dbt

pip install --upgrade dbt-<adapter>

pip install --upgrade \
  dbt-core \
  dbt-postgres \
  dbt-redshift \
  dbt-snowflake \
  dbt-bigquery

