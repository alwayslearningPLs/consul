#!/bin/bash

# **NOTE** we are using RAW IP Addresses because we should configure a DNS server, and redirect all the *.consul. queries to the consul server
# or use consul server as default. This is out of this lab (at least by the moment).

# Any of this three commands return the IPs of the consul servers
dig @192.168.56.40 -p 8600 consul.service.myhome.consul. ANY
dig @192.168.56.41 -p 8600 consul.service.myhome.consul. ANY
dig @192.168.56.42 -p 8600 consul.service.myhome.consul. ANY

# Same here without specifying the datacenter (myhome)
dig @192.168.56.40 -p 8600 consul.service.consul. ANY
dig @192.168.56.41 -p 8600 consul.service.consul. ANY
dig @192.168.56.42 -p 8600 consul.service.consul. ANY

# Display services

# Consul service
curl http://192.168.56.40:8500/v1/catalog/service/consul | jq -r '.[].ID'

# From some consul VM
consul catalog services
# or from any machine with access to one of the cluster ones.
curl http://192.168.56.40:8500/v1/catalog/services | jq .
curl http://192.168.56.40:8500/v1/catalog/service/server00 | jq .

