#!/bin/bash

# Look for service "backend", which is a "service", inside the datacenter "myhome" from the domain "mydomain" which is the consul domain.
dig @127.0.0.1      -p 8600 backend.service.myhome.mydomain. ANY
dig @192.168.56.30  -p 8600 backend.service.myhome.mydomain. ANY

# Look for service "backend", which is a "service", inside the datacenter "myhome" (by default) from the domain "mydomain" which is the consul domain.
dig @127.0.0.1      -p 8600 backend.service.mydomain. ANY
dig @192.168.56.30  -p 8600 backend.service.mydomain. ANY

# Look for service "backend", with primary tag, inside backend service with myhome as datacenter (by default)
dig @127.0.0.1      -p 8600 primary.backend.service.myhome.mydomain. ANY
dig @192.168.56.30  -p 8600 primary.backend.service.myhome.mydomain. ANY

# Look for service "backend", with primary tag, inside backend service with myhome as datacenter (by default)
dig @127.0.0.1      -p 8600 primary.backend.service.mydomain. ANY
dig @192.168.56.30  -p 8600 primary.backend.service.mydomain. ANY

# Asking for the DNS SOA of service inside mydomain
dig @127.0.0.1      -p 8600 service.mydomain. SOA
dig @192.168.56.30  -p 8600 service.mydomain. SOA

# Look for node kitchen inside myhome datacenter
dig @127.0.0.1      -p 8600 kitchen.node.myhome.mydomain. ANY
dig @192.168.56.30  -p 8600 kitchen.node.myhome.mydomain. ANY

# Look for node kitchen inside myhome datacenter (by default)
dig @127.0.0.1      -p 8600 kitchen.node.mydomain. ANY
dig @192.168.56.30  -p 8600 kitchen.node.mydomain. ANY

