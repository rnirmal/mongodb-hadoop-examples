-- Using Brickhouse for the collect funciton
add JAR brickhouse-0.7.0.jar;
create temporary function collect as 'brickhouse.udf.collect.CollectUDAF';

-- Create an external table in hive using the Ocean data stored in MongoDB
CREATE EXTERNAL TABLE ocean_data
(
city STRING,
products ARRAY<STRUCT<name:STRING, data:ARRAY<STRUCT<v:STRING>>>>
)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"city":"name", "products.name":"products.name", "products.data.v": "products.data.v"}')
TBLPROPERTIES('mongo.uri'='${hiveconf:MONGO_INPUT}');

-- Create a temporary table to extrapolate the various product values
CREATE TABLE product_values(city STRING, product STRING, value FLOAT);

-- Insert values into that table
INSERT OVERWRITE TABLE product_values SELECT city, prod_value.name as product, values.v as value from ocean_data LATERAL VIEW explode(products) t1 as prod_value LATERAL VIEW explode(prod_value.data) t2 as values;

-- Create the final output table where the processed results will be stored
create table results(city STRING, products ARRAY<STRUCT<name:STRING, min:FLOAT, max:FLOAT, avg:DOUBLE>>) STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
TBLPROPERTIES('mongo.uri'='${hiveconf:MONGO_OUTPUT}');

-- Finally insert the computed values into the results table
INSERT INTO table results select city, collect(prod) as products from (SELECT city, named_struct('name', product, 'min', min(value), 'max', max(value), 'avg', avg(value)) as prod from product_values group by city, product) p group by city;


-- Create the final output table where the processed results will be stored
create table results(city STRING, products ARRAY<STRUCT<name:STRING, min:FLOAT, max:FLOAT, avg:DOUBLE>>) STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
TBLPROPERTIES('mongo.uri'='${hiveconf:MONGO_OUTPUT}');

-- Finally insert the computed values into the results table
INSERT INTO table results select city, collect(prod) as products from (SELECT city, named_struct('name', product, 'min', round(min(value), 2), 'max', round(max(value), 2), 'avg', round(avg(value), 2)) as prod from product_values group by city, product) p group by city;
