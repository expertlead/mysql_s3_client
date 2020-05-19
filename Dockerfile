FROM debian:jessie-slim

ENV PATH=$PATH:/root/.local/bin

RUN apt update && \
    apt install -y mysql-client \
    python3-pip && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install --upgrade --user awscli

COPY init.sh /root/init.sh

ENTRYPOINT "/root/init.sh"
