#!/bin/bash

# Execute this command on the machine that you want to work as the server
docker container run --name consul --rm --detach \
  --volume consul-server-data:/consul/data \
  --volume ${PWD}/consul-server.hcl:/consul/config/consul.hcl \
  --net=host consul:latest agent --config-dir=/consul/config

# Execute this command on the machine that you want to work as the client
docker container run --name consul --rm --detach \
  --volume consul-client-data:/consul/data \
  --volume ${PWD}/consul-client.hcl:/consul/config/consul.hcl \
  --net=host consul:latest agent --config-dir=/consul/config
