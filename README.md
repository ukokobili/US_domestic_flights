# US domestic flights from 1990 to 2009
* US domestic flights
  * [Project Description](#project-description)
  * [Main Obejective](#main-objective)
  * [Dataset Description](#data-description)
  * [Technologies](#technologies)
  * [Project Architecture](#project-architecture)
  * [Tutorial](#tutorial)
  * [Pre-requisites](#pre-requisites)

# Project Description
The US domestic flight data is large and collected from 1990 to 2009 with over 3.5 million monthly domestic flight records. Data are arranged as an adjacency list with metadata. The data has to be processed (ELT) to enable analytics tasks using information from several years, cities, distance and population and so on.

# Main Obejective
Build a data pipeline and dashboard for users to do data analytic operations on the historical US domestic flight data:

  * Select a dataset.
  * Create a pipeline for processing this dataset and putting it into a data lake.
  * Create a pipeline for moving the data from the lake to a data warehouse.
  * Transform the data in the data warehouse: prepare it for the dashboard.
  * Create a dashboard.

# Dataset Description
The dataset was collected from [Kaggle](https://www.kaggle.com/datasets/ryanjt/us-domestic-flights-from-1990-to-2009) website. It contains information about the crimes committed in Baltimore, Maryland, US.

The dataset includes the following columns:
  * Origin: Three letter airport code of the origin airport
  * Destination: Three letter airport code of the destination airport
  * Origin City: Origin city name
  * Destination City: Destination city name
  * Passengers: Number of passengers transported from origin to destination
  * Seats: Number of seats available on flights from origin to destination
  * Flights:	Number of flights between origin and destination (multiple records for one month, many with flights > 1)
  * Distance:	Distance (to nearest mile) flown between origin and destination
  * Fly Date:	The date (yyyymm) of flight
  * Origin Population:	Origin city's population as reported by US Census
  * Destination Population:	Destination city's population as reported by US Census 

# Technologies
Below are the following technologies used for this project:

  * Cloud: GCP
  * Infrastructure as code(IaC): Terraform
  * Workflow orchestration: Airflow(ingestion pipeline and transformation pipeline)
  * Data Warehouse: BigQuery
  * Data Lake: GCS
  * Transformations: dbt 
  * Dashboard: Google Data Studio  

# Project architecture
The end-to-end data pipeline includes the following steps:

  * downloading, processing and uploading of the initial dataset to a DL;
  * moving the data from the lake to a DWH;
  * transforming the data in the DWH and preparing it for the dashboard;
  * dashboard creating.

You can find the detailed information on the diagram below:

![](https://github.com/ukokobili/baltimore/blob/main/images/Picture1.png)

# Tutorial
This tutorial contains the instructions you need to follow to reproduce the project results and can be found here.

# Pre-requisites
Endavour to pre-install the following applications
  * [GCP account](https://cloud.google.com/)
  * [Terraform](https://www.terraform.io/downloads)
  * [Docker](https://www.docker.com/products/docker-desktop/)

* Google Cloud Platform
  To set up GCP:

  * Create a free trial account.
  * Setup new project and write down your Project ID.
  * Configure service account to get access to this project and download auth-keys (.json). Please check the service account has all the permissions below:
    * Viewer
    * Storage Admin
    * Storage Object Admin
    * BigQuery Admin
  * Download [SDK](https://cloud.google.com/sdk) for local setup.
  * Set environment variable to point to your downloaded auth-keys:
  ```
  export GOOGLE_APPLICATION_CREDENTIALS="<path/to/your/service-account-authkeys>.json"
  # Refresh token/session, and verify authentication
  gcloud auth application-default login
  
  ```
  * Enable the following options under the APIs and services section:
     * [Identity and Access Management (IAM) API](https://console.cloud.google.com/apis/library/iam.googleapis.com?project=github-hn-1123)
     * [IAM service account credentials API](https://console.cloud.google.com/apis/library/iamcredentials.googleapis.com?project=github-hn-1123)
     
* Terraform
    We use Terraform to build and manage GCP infrastructure. Terraform configuration files are located in the separate folder. There are 3 configuration files:
     * [variables.tf](https://github.com/ukokobili/US_domestic_flights/blob/main/terraform/variables.tf) - contains variables to make your configuration more dynamic and flexible;
     * [main.tf](https://github.com/ukokobili/US_domestic_flights/blob/main/terraform/main.tf) - is a key configuration file consisting of several sections.
     Note: You can find the detailed description of each section [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/week_1_basics_n_setup/1_terraform_gcp/1_terraform_overview.md)

     Use the steps below to generate resources inside the GCP:

     * Create a terraform folder the [variables.tf](https://github.com/ukokobili/US_domestic_flights/blob/main/terraform/variables.tf) and [main.tf](https://github.com/ukokobili/US_domestic_flights/blob/main/terraform/main.tf) files 
     * Run terraform init command to initialize the configuration.
     * Use terraform plan to match previews local changes against a remote state.
     * Apply changes to the cloud with terraform apply command.
      Enter the GCP Project ID. 
      
     Note: Use terraform destroy command to remove your stack from the Cloud.

 * Airflow
   The next steps provide you with the instructions of running Apache Airflow, which will allow you to run the entire orchestration, taking into account that you have already set up a GCP account.

   Setup
   Go to the airflow subdirectory: here you can find the [Dockerfile](https://github.com/ukokobili/US_domestic_flights/blob/main/airflow/Dockerfile) and the lightweight version of the [docker-compose.yaml](https://github.com/ukokobili/US_domestic_flights/blob/main/airflow/docker-compose.yaml) file that are required to run Airflow.

   The lightweight version of docker-compose file contains the minimum required set of components to run data pipelines. Specify the Project ID (GCP_PROJECT_ID) and Cloud Storage name (GCP_GCS_BUCKET) in the docker-compose.yaml before launching. Ensure these variables are the same as actual GCP setup.

   You can easily run Airflow using the following commands:

    * ```docker-compose build``` to build the docker images;
    * ```docker-compose up``` airflow-init to initialize the Airflow scheduler, DB and other stuff;
    * ```docker-compose up``` to kick up the all the services from the container.

   Now you can launch Airflow UI and run the DAGs.
   Note: If you want to stop Airflow, please type ```docker-compose down``` command in your terminal.

   **Running DAGs**
   Open the http://localhost:8080/ address in your browser and login using ```airflow``` username and ```airflow``` password.

   On the DAGs View page you can find three dags:

     * ```gcs_ingestion_dag``` for downloading data from the source, unpacking and converting it to parquet format and finally uploading it to the Cloud Storage.
     * ```gcs_bq_dag``` to subsequently transorm and create a table and then optimized table in BigQuery from the data stored in GCS.

   Firstly, run the first ```gcs_ingestion_dag``` dag to enable data upload to GCS and then run the ```gcs_bq_dag``` dag to transform and create tables in DWH. 

*  DBT
   We are going to use [dbt](https://www.getdbt.com/) for data transformation in DWH and further analytics dashboard development.

   Using this [link](https://docs.getdbt.com/dbt-cli/cli-overview) to create download and install dbt core on your local machine then connect to your BigQuery following these [instructions](https://docs.getdbt.com/reference/warehouse-profiles/bigquery-profile) and modify the ```[profiles.yaml](https://docs.getdbt.com/reference/warehouse-profiles/bigquery-profile)``` in the ```./dbt``` directory

* Google Data Studio
  Create dashboard after building the production model in dbt

  The dashboard was built using [Google Data Studio](https://datastudio.google.com/u/1/reporting/07cb0451-66f3-4d78-b7ed-601d421dbafe/page/HPk0C). 

  The dashboard include details such as:
     * Total number of flights
     * Total number of passengers
     * Total number of seats
     * Average distance in mile

<h1 style="text-align: center;">US Domestic Flights from 1990 - 2009</h1>


