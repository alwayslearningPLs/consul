# Architecture

- *Node*: A Node is a machine (VM or a bare metal server)-that hosts services.
- *Datacenter*: A datacenter is a grouping of nodes and services that all have low-latency network connectivity with on another. A datacenter could be a kubernetes cluster.

![arhitecture consul](./assets/architecture-consul.drawio.png)

## Consul servers

Consul servers are Consul's database. Consul needs to store data about the services that are running, their configuration, health statuses, and more.

In a production environment, probably we would need between 3 to 5 consul servers to provide redundancy and high availability. Wait wait, how we can connect them so they have an updated database at each time the services go down/up? __RAFT__(a consensus algorithm) is used by consul to *leader election* and *replication*.

## Consul clients

Consul clients run on every node in a datacenter.

### Distributed failure detection

Consul needs to detect two types of failures:

- Service failure.
- Node failure.

To detect this, consul clients run health checks against each service on their node.

If a node goes offline, the consul client can't tell the consul server that the entire node is down because of its own "death". Consul servers could just perform a healthcheck to nodes like consul clients perform with services. Nevertheless, this is not scalable...

Consul uses a library called _Serf_, which implements a _gossip_ algorithm (also known as an epidemic algorihtm). It relies on each node communicating with a small number of other nodes (default three). Those nodes in turn communicate with another small number of nodes, and so on.

## Proxies

They are the sidecar proxies (following the sidecar pattern) that intercept requests from outside to the app.

Consul itself is not a proxy. Instead, consul uses a proxy called _Envoy_. This proxy communicates with the consul client so it can be configured.

## References

- [RAFT](https://raft.github.io/)
- [Envoy](https://www.envoyproxy.io/)

