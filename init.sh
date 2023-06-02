#!/bin/bash

docker compose down
docker compose up --build -d

echo "Creating table queue..."

docker exec -it clickhouse-server clickhouse-client --query="CREATE TABLE queue (
    message String
  ) ENGINE = Kafka('kafka:9092', 'metrics', 'group', 'JSONAsString');"

docker exec -it clickhouse-server clickhouse-client --query="CREATE TABLE metrics (
    id UInt64,
    name String,
  ) ENGINE = MergeTree(); ORDER BY Id"

docker exec -it clickhouse-server clickhouse-client --query="CREATE MATERIALIZED VIEW consumer TO metrics
    AS SELECT
        JSONExtractString(message, 'id') as id,
        JSONExtractString(message, 'name') as name,
    FROM queue;
"

docker-compose exec -it kafka sh -c "kafka-console-producer --broker-list localhost:9092 --topic metrics < /input.json"

echo "Sleeping for 20 seconds ..."
sleep 20

echo "Getting data..."
docker-compose exec -it clickhouse-server clickhouse-client --format=Pretty --query="
	SELECT * FROM consumer;
"
