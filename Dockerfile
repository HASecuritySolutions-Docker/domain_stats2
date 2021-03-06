FROM ubuntu:20.04

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
  && apt install python3-pip curl -y \
  && pip3 install pyyaml rdap domain_stats \
  && apt clean \
  && useradd -ms /bin/bash domain_stats
COPY data /

USER domain_stats

EXPOSE 8000

STOPSIGNAL SIGTERM

CMD cd /data && domain_stats .
