#!/usr/bin/env bash

ZOOKEEPER_CONNECT_URL=zk-1:22181

docker run \
  --net=hackathon \
  confluentinc/cp-kafka:3.3.0 \
  kafka-topics --create --topic $1 --partitions 20 --replication-factor 1 --if-not-exists --zookeeper ${ZOOKEEPER_CONNECT_URL} 