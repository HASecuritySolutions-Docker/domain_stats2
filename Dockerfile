FROM alpine

MAINTAINER Justin Henderson justin@hasecuritysolutions.com

RUN apk add --update --no-cache --virtual .build-deps \
  && apk add --no-cache --virtual .build-deps \
  && apk add --no-cache build-base git mercurial py3-pip \
  && apk add --update --no-cache python3 \
  && pip3 install PySocks \
  && pip3 install six \
  && pip3 install pyyaml \
  && pip3 install requests \
  && rm -rf /var/cache/apk/* \
  && hg clone https://bitbucket.org/richardpenman/pywhois \
  && chmod +x pywhois/setup.py \
  && cd pywhois && python3 setup.py install && cd / \
  && rm -rf /pywhois \
  && cd /opt && git clone https://github.com/MarkBaggett/domain_stats2.git \
  && find /usr/local \
    \( -type d -a -name test -o -name tests \) \
    -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
    -exec rm -rf '{}' + \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .rundeps $runDeps \
  && apk del .build-deps \
  && mkdir /var/log/domain_stats \
  && ln -sf /dev/stderr /var/log/domain_stats/domain_stats.log \
  && adduser -Ds /bin/sh domain_stats \
  && chown -R domain_stats: /opt/domain_stats2 \
  && cd /opt/domain_stats2 \
  && echo y | /usr/bin/python3 /opt/domain_stats2/database_admin.py --rebuild

USER domain_stats

EXPOSE 8000

STOPSIGNAL SIGTERM

CMD cd /opt/domain_stats2 && /usr/bin/python3 /opt/domain_stats2/domain_stats.py
