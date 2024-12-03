# Kafka CDC Example Solution

This solution is a collection of the working files for the 3 part series on connecting Elasticsearch to Postgres changes via CDC and Kafka. You can find the article [here](https://google.com). If you found the article valuable, please drop a like on it. If you didn't, let me know why in the comments!

## Steps for getting this going locally

1. run `docker compose up -d` to start the compose stack.
2. run the SQL included in the `sql-up.sql` file against the postgres database to get the tables in place.
3. run the following in your terminal of choice:

```
  curl --location 'http://localhost:8083/connectors' \
  --header 'Content-Type: application/json' \
  --data '  {
      "name": "db-connector",
      "config": {
        "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
        "database.hostname": "host.docker.internal",
        "database.port": "5432",
        "database.user": "postgres",
        "database.password": "example",
        "database.dbname": "postgres",
        "database.server.name": "postgres",
        "topic.prefix": "data",
        "plugin.name":  "pgoutput"
      }
    }'
```

4. Generate an API key in Kibana under **Search > Overview** and copy the encoded API Key generated into the `compose.yaml` file under the `ELASTIC_API_KEY` args in the consumer args.

5. Restart the stack by first calling `docker compose down --rmi local` and then `docker compose up -d` to refresh your API KEY env variable into your consumer images/containers

## Notes

- If you are making changes to your consumer code, make sure to terminate the running consumer containers in the compose stack and comment them out in the `compose.yaml` so they aren't competing with events in Kafka.

- Refer to the articles for further understanding of what's going on here!
