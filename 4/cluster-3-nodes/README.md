# Cluster of 3 nodes

## Installation

`vagrant up`

## Testing

- consul servers: `curl http://localhost:8500/v1/catalog/service/consul | jq -r '.[].ID'`

