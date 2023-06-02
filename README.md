# Problem:

There is kafka, someone or something throws data into it, we don’t know who or what is doing this, for us it’s magic. What we know is that the data format that comes into the kafka topic is clickhouse. The business says "I want to add all the data from the metrics topic in kafka automatically in ClickHouse to the metrics table and then count something there" well suited for the job. Magic as it was with MongoDB will not work, here we just read from Kafka and put it in ClickHouse. So, to create such a thing, you need to connect ClickHouse itself to kafka. Just connectors can not be found. There is a kafka engine in ClickHouse that was specially created and used for connectivity between kafka and ClickHouse.

# Solution:
Just follow the clickhouse document

# Runbook

`chmod +x script.sh`

`./script.sh`

