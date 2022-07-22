#!/usr/bin

pip install kaggle

export KAGGLE_USERNAME="enter your username"
export KAGGLE_KEY="enter your api key"




dataset_id=ryanjt
dataset_name=us-domestic-flights-from-1990-to-2009

kaggle datasets download -d $dataset_id/$dataset_name --unzip -p "/opt/airflow/$dataset_id"
