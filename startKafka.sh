#!/usr/bin/env bash

ZOOKEEPER_CONNECT_URL=zk-1:22181

docker stop zk-1 && docker rm zk-1

docker run -d \
   --net=hackathon \
   --name=zk-1 \
   -e ZOOKEEPER_SERVER_ID=1 \
   -e ZOOKEEPER_CLIENT_PORT=22181 \
   -e ZOOKEEPER_TICK_TIME=2000 \
   -e ZOOKEEPER_INIT_LIMIT=5 \
   -e ZOOKEEPER_SYNC_LIMIT=2 \
   -e ZOOKEEPER_SERVERS="zk-1:22888:23888" \
   confluentinc/cp-zookeeper:3.3.0

docker stop kafka-1 && docker rm kafka-1 \
  && docker stop kafka-2 && docker rm kafka-2 \
  && docker stop kafka-3 && docker rm kafka-3

docker run -d \
    --net=hackathon \
    --name=kafka-1 \
    -e KAFKA_ZOOKEEPER_CONNECT=${ZOOKEEPER_CONNECT_URL} \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-1:29092 \
    confluentinc/cp-kafka:3.3.0

docker run -d \
    --net=hackathon \
    --name=kafka-2 \
    -e KAFKA_ZOOKEEPER_CONNECT=${ZOOKEEPER_CONNECT_URL} \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-2:39092 \
    confluentinc/cp-kafka:3.3.0

docker run -d \
    --net=hackathon \
    --name=kafka-3 \
    -e KAFKA_ZOOKEEPER_CONNECT=${ZOOKEEPER_CONNECT_URL} \
    -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka-3:49092 \
    confluentinc/cp-kafka:3.3.0

docker stop schema-registry && docker rm schema-registry

docker run -d \
    --net=hackathon \
    --name=schema-registry \
    -p 8081:8081 \
    -e SCHEMA_REGISTRY_KAFKASTORE_CONNECTION_URL=${ZOOKEEPER_CONNECT_URL} \
    -e SCHEMA_REGISTRY_HOST_NAME=schema-registry \
    -e SCHEMA_REGISTRY_LISTENERS=http://schema-registry:8081 \
    -e SCHEMA_REGISTRY_DEBUG=true \
    confluentinc/cp-schema-registry:3.3.0