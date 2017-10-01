#!/usr/bin/env bash

ZOOKEEPER_CONNECT_URL=zk-1:22181

docker run \
  --net=hackathon \
  confluentinc/cp-kafka:3.3.0 \
  kafka-topics --describe --topic $1 --zookeeper ${ZOOKEEPER_CONNECT_URL}