# Learning DNS on consul

We can query to the DNS interface in Consul where our services are located, for example

we can use the `dig` utility from `dnsutils` in ubuntu to call the DNS server on port `8600` and know where our service *backend* is located

`dig @127.0.0.1 -p 8600 backend.service.myhome.consul. ANY`

- `@127.0.0.1`: We are targeting our localhost, which in this case is the server.
- `-p 8600`: We are targeting the port *8600*.
- `{service-name}.service.{datacenter-name}.consul.`: the last period is to look for this fixed name, instead of doing a lookup.

Sample output:

```txt
; <<>> DiG 9.18.1-1ubuntu1.1-Ubuntu <<>> @127.0.0.1 -p 8600 backend.service.myhome.consul ANY ; (1 server found)
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 910
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 1232
;; QUESTION SECTION:
;backend.service.myhome.consul. IN      ANY

;; ANSWER SECTION:
backend.service.myhome.consul. 0 IN     A       192.168.56.30

;; Query time: 0 msec
;; SERVER: 127.0.0.1#8600(127.0.0.1) (TCP)
;; WHEN: Tue Sep 20 02:53:45 UTC 2022
;; MSG SIZE  rcvd: 74
```

There a number of configuration options that are important for the *DNS interface*, specifically:

- `client_addr` => Because of we are listening on all our available interfaces, we can fetch the resource from our physical machine using: `dig @192.168.56.30 -p 8600 backend.service.myhome.consul. ANY`.
- `ports.dns` => This is the option that we can set in the `server.hcl` to change the port of DNS. By default *8600*
- `recursors` => Allows to have upstream DNS servers so if a service is not inside the consul domain, it can forward the query upstream.
- `domain` => By default, Consul responds to DNS queries in the "consul" domain. This keyword can be used to change that domain [see](https://www.consul.io/docs/agent/config/cli-flags#_domain)
- `alt_domain` => This flag allows Consul to respond to DNS queries in an alternate domain, in addition to the primary domain.
- `dns_config` => This object allows a number of sub-keys to be set which can tune how DNS queries are serviced.

For more queries on that, [see](./queries.sh)

## DNS caching

By default, Consul serves all DNS results with a *0 TTL* value. This prevents caching.

### Stale reads

Stale reads can be used to *reduce latency* and *increase throughput* of DNS queries. Settings:

- `dns_config.allow_stale`: Must be set to true to enable stale reads.
- `dns_config.max_stale`: Limits how stale results are allowed to be when querying DNS.

#### Allow stale reads

Since Consul 0.7.1, `allow_stale` is enabled by default and uses a `max_stale` value that defaults to a near-indefinite threshold (10 years)

```hcl
# Default configuration
dns_config {
  allow_stale = true
  max_stale   = "87600h"
}
```

If you disable the stale read, then a single leader node will serve reads. They will be consistent, but we are limited to the thoughput of a that single server.

### Negative reponse caching

Some DNS clients cache negative responses - that is, Consul returning a not found style response because a service exists but there are no healthy endpoints.

### DNS SOA Record

| keyword | definition | example |
| ------- | ---------- | ------- |
| name | DNS name | example.com |
| record type | type of record | SOA |
| MNAME | This is the name of the primary nameserver for the zone. Secondary servers that maintain duplicates of the zone's DNS records receive updates to the zone from this primary server | ns.primaryserver.com |
| RNAME | It is the email of the administrator of the server. admin.example.com == admin@example.com, but RNAME doesn't allow '@' | admin.example.com |
| SERIAL | version number for the SOA record | 1111111111 |
| REFRESH | The length of time in seconds, secondary servers wait before asking primary servers for the SOA record to see if it has been updated. | 86400 |
| RETRY | The length of time in seconds, a server should wait for asking an unresponsive primary nameserver for an update again. | 7200 |
| EXPIRE | If a second server does not get a response from the primary server for this amount of time, it should stop responding to queries for that zone. | 4000000 |
| TTL | Time To Live | 11200 |

```hcl
dns_config {
  soa {
# By default, 24 hours
    expire  = 86400
# This also controls negative cache TTL in most implementations. Default value is 0, ie: no minimum TTL or negative one.
    min_ttl = 0
# By default, 1 hour
    refresh = 3600
# By default, 10 minutes
    retry   = 600
  }
}
```

### TTL values

By default, `node_ttl` and `service_ttl` has always "0s" to prevent caching downstream. The more higher this values is, the more time it will be cached.

### More options

- `enable_truncate`: It set to `true`, a UDP DNS query that would return more than 3 rows would fit into a valid UDP response, will set the truncated flag, indicating to clients that they should re-query using TCP to get the full set of records.

### Full example

```hcl
dns_config {
  allow_stale     = true
  max_stale       = 87600
  node_ttl        = "0s"
  service_ttl {
    "*"           = "0s"
  }
  soa {
    expire        = 86400
    min_ttl       = 0
    refresh       = 3600
    retry         = 600
  }
  enable_truncate = false
}
domain          = consul
```

## References

- [DNS SOA](https://www.cloudflare.com/learning/dns/dns-records/dns-soa-record/)
- [Benefits of Stale reads](https://blog.cloudflare.com/the-benefits-of-serving-stale-dns-entries-when-using-consul/)
