# Services in Consul

## Service config file

```hcl
service {
# It is recommended to use characters allowed to use in DNS names
  name = "servicename"
# If we use the same name for more than one service, we must use a different id. By default, the name will be used as id, if id is not specified
  id   = "serviceid" 
# List of strings values that can be used to add service-level labels.
  tags = [
    "myfirstlabel",
    "mysecondlabel"
  ]
# Port where the service is running
  port = 80

}
```

## Lab architecture

![consul architecture with envoy](./assets/consul_envoy_architecture.drawio.png)

## Reference

- [Tutorial](https://learn.hashicorp.com/tutorials/consul/get-started-service-discovery?utm_source=docs)
- [Services](https://www.consul.io/docs/discovery/services)
- [Health check](https://www.consul.io/docs/discovery/checks)
- [apt-key-deprecated-solution](https://itsfoss.com/apt-key-deprecated/)
- [warning-apt-key](https://stackoverflow.com/questions/68992799/warning-apt-key-is-deprecated-manage-keyring-files-in-trusted-gpg-d-instead/71384057#71384057)
- [apt-key-managing-ansible](https://stackoverflow.com/questions/71585303/how-can-i-manage-keyring-files-in-trusted-gpg-d-with-ansible-playbook-since-apt)

