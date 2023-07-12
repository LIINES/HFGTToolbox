# Docker file for hosting python_hfgt_toolbox. Builds your project and its dependencies into a docker container.
# This is mostly just the filesystem setup. Use docker-compose for runtime stuff (eg volumes, actual entrypoints etc)

ARG PROJECT_NAME=python_hfgt_toolbox
ARG POETRY_VERSION=1.1.14
ARG PYTHON_VERSION=3.9.13

FROM python:$PYTHON_VERSION-slim

# Arguments defined before a FROM will be unavailable after the FROM unless we re-specify the arg
ARG POETRY_VERSION
ARG PROJECT_NAME

WORKDIR /usr/src/app/$PROJECT_NAME/

# install poetry
RUN apt-get update && apt-get install curl git -y

# warning, this will break on poetry v1.2 https://python-poetry.org/blog/announcing-poetry-1.2.0a1/
ENV GET_POETRY_IGNORE_DEPRECATION=1
RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py > get-poetry.py
RUN python get-poetry.py --version=$POETRY_VERSION
ENV PATH=$PATH:/root/.poetry/bin/

# set up python environment
COPY pyproject.toml poetry.lock ./

# Add private repo if relevant args exist
RUN if [[ -z "$PUBLISH_URL" ]] ; then poetry config repositories.csiroenergy $PUBLISH_URL ; fi
RUN if [[ -z "$PUBLISH_USER" ]] ; then poetry config http-basic.csiroenergy $PUBLISH_USER $PUBLISH_PASSWORD ; fi
RUN poetry config --list

RUN poetry install --no-root

#Tools For debugging
RUN apt-get install nano iputils-ping net-tools nmap -y

#Copy necessary source, scripts and config
COPY src ./src
COPY docker-compose.yml .
COPY Dockerfile .
COPY *.md *.sh ./
COPY scripts ./scripts
RUN chmod +x scripts/*.sh

# workaround for poetry bug https://github.com/python-poetry/poetry/issues/2657
ENV PYTHONPATH=/usr/src/app/$PROJECT_NAME/src:$PYTHONPATH

# just launch bash for debugging. Specify real entrypoints in docker-compose.yml
ENTRYPOINT ["/bin/bash"]
