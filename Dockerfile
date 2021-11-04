FROM python:3.8.7-slim

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
  && apt install python3-pip curl -y \
  && pip3 install pyyaml rdap domain_stats python-whois setuptools flask diskcache gunicorn requests python-dateutil publicsuffixlist \
  && apt clean \
  && useradd -ms /bin/bash domain_stats \
  && mkdir -p /data \ &&
  && chown -R domain_stats:domain_stats /data
COPY data /data/

USER domain_stats

EXPOSE 8000

STOPSIGNAL SIGTERM

CMD cd /data && domain-stats .
