#!/bin/bash

docker-compose down
docker-compose up -d

docker-compose exec -it kafka kafka-topics --bootstrap-server localhost:9092 --create --topic metrics

echo "Creating table queue..."

docker exec -it clickhouse-server clickhouse-client --query="CREATE TABLE queue (
    message String
  ) ENGINE = Kafka('kafka:9092', 'metrics', 'group', 'JSONAsString');"
echo "done create table queue..."

echo "Creating table metrics..."

docker-compose exec -it clickhouse-server clickhouse-client --query="CREATE TABLE metrics (
    id UInt64,
    name String,
  ) ENGINE = MergeTree() ORDER BY id;"
echo "done create table metrics..."

docker-compose exec -it clickhouse-server clickhouse-client --query="CREATE MATERIALIZED VIEW consumer TO metrics
    AS SELECT
        JSONExtractString(message, 'id') as id,
        JSONExtractString(message, 'name') as name,
    FROM queue;
"


echo "write input into topic metrics..."
docker-compose exec -it kafka sh -c "kafka-console-producer --broker-list localhost:9092 --topic metrics < /input.json"
echo "done writing..."

echo "Writing until data get synced... for 5 seconds ..."
sleep 5

echo "Getting data..."
docker-compose exec -it clickhouse-server clickhouse-client --format=Pretty --query="
	SELECT * FROM consumer;
"
echo "Worked!"
