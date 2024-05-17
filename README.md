# Airbnb Analytics
In this project I used DBT Cloud to transform Airbnb listings, hosts and reviews data in berlin, and create a datawarehouse on Snowflake. 

# Data
The data was extracted from https://insideairbnb.com/get-the-data/. \
The data extracted includes the following tables:
- listings
- hosts
- reviews
  
while the full moon dates table wasn't extracted from the airbnb data \

these table have the following schema\
![input_schema](https://github.com/AliMamdouhSalem/SnowFlakeDBT/assets/74428524/ba19b5a4-7730-4aa9-937e-28087bd43bef)

# Modeling and transformation

## Staging
First step was to create 3 ephemeral materialisation models to act as a staging layer were data was loaded as is from the data warehouse, only changing some column names.
- stg_raw_hosts
- stg_raw_listings
- stg_raw_reviews

## Dimensions
stg_raw_hosts and stg_raw_listings were chosen as dimension in this model and 2 view materialisation models create for them were some data cleaning and transformation was done.
- dim_hosts
  - Only one data transformation happened where I change the null host names into 'Anon'
- dim_listings
  - 0 values in the minimum_nights column was changed to 1
  - changed the price column from string in the following format '$90' into decimal

A table materialisation was created as a dimension that consisted of joining dim_listings and dim_hosts with host_id and was named:
-  dim_listings_hosts

## Facts
Stg_raw_reviews was chosen as a fact table for this model and an incremental materialisation model was created for it:
- fct_reviews
  - a surrogate key was created

## Snapshots
I created 2 snapshot to keep history using SCD type 2 for my 2 dimension views:
-  scd_hosts
-  scd_listings

## Seeds
A csv of full moon dates was uploaded to dbt to be used as a seed named:
- seed_full_moon_dates

## Marts
A data mart was created joining the fct_reviews table with the seed_full_moon_dates:
- fct_moon_reviews

## Testing
Several tests were implemented on all models with dbt generic tests, custom created tests, and tests from [dbt expectations](https://github.com/calogica/dbt-expectations)

## Final DBT DAG
![image](https://github.com/AliMamdouhSalem/SnowFlakeDBT/assets/74428524/f82bd547-b385-44e4-af88-7a5cd3e80722)


#  Dashboard
![image](https://github.com/AliMamdouhSalem/SnowFlakeDBT/assets/74428524/57753829-d10c-4971-8b24-1b74410916ab)


# Technologies used
- **DBT** (Data transformation)
- **Snowflake** (Data Warehouse)
- **Power BI** (Data Visualisation)
