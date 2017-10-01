#!/usr/bin/env bash

docker stop zk-1 && docker rm zk-1 \
  && docker stop zk-2 && docker rm zk-2 \
  && docker stop zk-3 && docker rm zk-3

docker stop kafka-1 && docker rm kafka-1 \
  && docker stop kafka-2 && docker rm kafka-2 \
  && docker stop kafka-3 && docker rm kafka-3

docker stop kafka-rest && docker rm kafka-rest
docker stop kafka-manager && docker rm kafka-manager
docker stop kafka-topic-ui && docker rm kafka-topic-ui
docker stop schema-registry && docker rm schema-registry
docker stop schema-registry-ui && docker rm schema-registry-ui
