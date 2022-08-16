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

  # remove all docker containers
  docker rm $(docker ps -aq)

sudo chmod -R 777 /home/nerd/projects/US_domestic_flights/dbt/dbt/project_1

**For developers of integrations with dbt Core:**

          pip install dbt-core

          Be advised, dbt Cores python API is not yet stable or documented
          (https://docs.getdbt.com/docs/running-a-dbt-project/dbt-api)

      **For the previous behavior of `pip install dbt`:**

          pip install dbt-core dbt-postgres dbt-redshift dbt-snowflake dbt-bigquery
          
# remove all docker containers
docker-compose up --remove-orphans -d --build

C:/Users/DELL/...