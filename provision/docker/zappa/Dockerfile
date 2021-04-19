FROM equipindustry/python:3.8.0-slim

MAINTAINER Luis Mayta <@slovacus>

LABEL NAME air-pollution-zappa

COPY Pipfile* /usr/src/

# set working directory to /usr/src/
WORKDIR /usr/src/

RUN  groupadd -g 500 -r python \
  && groupadd developer \
  && useradd -m -g developer -G python developer \
  && chown -R developer:python /usr/local/bin \
  && mkdir -p /usr/src \
  && chown -R developer /usr/src \
  && pip3 install pipenv \
  && pipenv install  \
  && pipenv shell --fancy \
  && apt-get purge \
  && rm -rf /var/lib/apt/lists/*
