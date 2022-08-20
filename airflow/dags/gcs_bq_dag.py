import os
import logging

from airflow import DAG
from airflow.utils.dates import days_ago
from airflow.providers.google.cloud.operators.bigquery import BigQueryCreateExternalTableOperator, BigQueryInsertJobOperator
from airflow.providers.google.cloud.transfers.gcs_to_gcs import GCSToGCSOperator

# Helps to interact with Google Storage
from google.cloud import storage

PROJECT_ID = os.environ.get("GCP_PROJECT_ID")
BUCKET = os.environ.get("GCP_GCS_BUCKET")

data_name="us-domestic-flights-from-1990-to-2009"
dataset_id="ryanjt"
parquet_file="flights.parquet"

path_to_local_home = os.environ.get("AIRFLOW_HOME", "/opt/airflow/")
BIGQUERY_DATASET = os.environ.get("BIGQUERY_DATASET", 'us_domestic_flights')

default_args = {
    "owner": "airflow",
    "start_date": days_ago(1),
    "depends_on_past": False,
    "retries": 3,
}

# NOTE: DAG declaration - using a Context Manager (an implicit way)
with DAG(
    dag_id="gcs_bq_dag",
    schedule_interval="@once",
    default_args=default_args,
    catchup=False,
    max_active_runs=1,
    tags=['jkop'],
) as dag:

    # move data from gcs to bigquery
    gcs_to_bq = BigQueryCreateExternalTableOperator(
        task_id="gcs_to_bq",
        table_resource={
            "tableReference": {
                "projectId": PROJECT_ID,
                "datasetId": BIGQUERY_DATASET,
                "tableId": f"{data_name}",
            },
            "externalDataConfiguration": {
                "sourceFormat": "PARQUET",
                "sourceUris": [f"gs://{BUCKET}/kaggle/{dataset_id}/{parquet_file}"],
            },
        }, 
    )

    # formate int date to date datatype and create new table
    CREATE_NEW_TABLE_DATE = " CREATE OR REPLACE TABLE us-domestic-flights-356906.us_domestic_flights.flights AS \
        SELECT Origin, Destination, Origin_City, Origin_State, Destination_City, Destination_State, Passengers, Seats, Flights as no_of_flights, Distance, DATE(CONCAT(FLOOR(Fly_Date/100),'-',MOD(Fly_Date, 100),'-',1)) AS Date, Origin_Population, Destination_Population \
        FROM `us-domestic-flights-356906.us_domestic_flights.us-domestic-flights-from-1990-to-2009` "

    new_date_table = BigQueryInsertJobOperator(
        task_id="new_date_table",
        configuration={
            "query": {
                "query": CREATE_NEW_TABLE_DATE,
                "useLegacySql": False,
                }
        },
    )  
                 
    # create a partition query in bigquery
    CREATE_PART_TABLE = " CREATE OR REPLACE TABLE us-domestic-flights-356906.us_domestic_flights.flight_partitoned \
        PARTITION BY \
        DATE_TRUNC(Date, MONTH) AS \
        SELECT * FROM us-domestic-flights-356906.us_domestic_flights.flights;"

    part_job = BigQueryInsertJobOperator(
        task_id="part_job",
        configuration={
            "query": {
                "query": CREATE_PART_TABLE,
                "useLegacySql": False,
            }
        },
    )
    
gcs_to_bq >> new_date_table >> part_job