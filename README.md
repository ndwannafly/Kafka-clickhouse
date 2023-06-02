# Problem:

There is kafka, someone or something throws data into it, we don’t know who or what is doing this, for us it’s magic. What we know is that the data format that comes into the kafka topic is clickhouse. The business says "I want to add all the data from the metrics topic in kafka automatically in ClickHouse to the metrics table and then count something there" well suited for the job. Magic as it was with MongoDB will not work, here we just read from Kafka and put it in ClickHouse. So, to create such a thing, you need to connect ClickHouse itself to kafka. Just connectors can not be found. There is a kafka engine in ClickHouse that was specially created and used for connectivity between kafka and ClickHouse.

# Solution:
Just follow the clickhouse document.

# Clickhouse
ClickHouse is a popular open-source columnar database management system (DBMS) that is designed for online analytical processing (OLAP). It was developed by Yandex and is now widely used for handling large-scale datasets in real-time.

ClickHouse is known for its high performance, high availability, fault-tolerance, and scalability. It allows users to execute complex analytical queries on vast data sets in seconds due to its column-store structure, which enables data compression and efficient I/O operations.

ClickHouse is mainly used for data warehousing, business intelligence, clickstream analysis, and other use cases that require fast analytics of vast quantities of data. It can also be used for real-time data ingestion, such as in log management and time-series databases.

Some of the key benefits of using ClickHouse include its high-speed ingestion and query processing, low hardware requirements, support for various data formats, and seamless integration with various data sources and analytics tools.

# Runbook

`chmod +x script.sh`

`./script.sh`

