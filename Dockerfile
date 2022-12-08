FROM python:3-slim-bullseye

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apt update \
  && apt dist-upgrade -y \
  && apt install python3-pip curl -y \
  && pip3 install pyyaml rdap domain_stats python-whois setuptools flask diskcache gunicorn requests python-dateutil publicsuffixlist \
  && apt clean \
  && useradd -ms /bin/bash domain_stats \
  && mkdir -p /data
COPY data /data/

RUN chown -R domain_stats:domain_stats /data \
  && chmod -R 700 /data

USER domain_stats

EXPOSE 8000

STOPSIGNAL SIGTERM

CMD domain-stats /data
