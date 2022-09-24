ARG ENVOY_VERSION_STRING="1.23.0"
FROM ubuntu:22.04

ARG ENVOY_VERSION_STRING

RUN apt-get update --yes && apt-get install --yes software-properties-common curl gnupg2 apt-transport-https lsb-release make jq net-tools && \
  curl -sS https://apt.releases.hashicorp.com/gpg | apt-key add -  && \
  add-apt-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
  apt-get install --yes consul && \
  consul version && \
  curl -L https://func-e.io/install.sh | bash -s -- -b /usr/local/bin && \
  func-e use $ENVOY_VERSION_STRING && \
  cp /root/.func-e/versions/$ENVOY_VERSION_STRING/bin/envoy /usr/local/bin/ && \
  envoy --version

VOLUME /etc/consul.d/

ENTRYPOINT ["/bin/bash", "-c"]

CMD ["/usr/bin/consul agent -config-dir=/etc/consul.d/"]

