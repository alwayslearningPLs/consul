FROM ubuntu:22.04

RUN apt-get update --yes && apt-get install --yes software-properties-common curl gnupg2 apt-transport-https lsb-release make jq net-tools && \
  curl -sS https://apt.releases.hashicorp.com/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  apt-get install --yes consul && \
  consul version

VOLUME /etc/consul.d/

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/usr/bin/consul agent -config-dir=/etc/consul.d/"]

