FROM ubuntu:18.04

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
  && apt install python3-pip -y \
  && pip3 install pyyaml rdap domain_stats \
  && apt clean \
  && adduser -Ds /bin/sh domain_stats

USER domain_stats

EXPOSE 8000

STOPSIGNAL SIGTERM

CMD cd /etc/domain_stats && domain_stats .
