# Docker file for hosting python_hfgt_toolbox. Builds your project and its dependencies into a docker container.
# This is mostly just the filesystem setup. Use docker-compose for runtime stuff (eg volumes, actual entrypoints etc)

ARG PYTHON_VERSION=3.9.13

FROM python:$PYTHON_VERSION-slim

# Arguments defined before a FROM will be unavailable after the FROM unless we re-specify the arg
ARG POETRY_VERSION

ARG PROJECT_NAME=python_hfgt_toolbox
ARG POETRY_VERSION=1.2.0
ARG JULIA_VERSION=1.8.1

WORKDIR /usr/src/app/$PROJECT_NAME/

# install packages
RUN apt-get update && apt-get install julia curl git -y

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 - --version=$POETRY_VERSION
ENV PATH=$PATH:/root/.local/bin

# set up python environment
COPY pyproject.toml poetry.lock ./

RUN poetry install --no-root

# Tools For debugging
RUN apt-get install nano iputils-ping net-tools nmap -y

# Copy necessary source, scripts and config
COPY src ./src
COPY docker-compose.yml .
COPY Dockerfile .
COPY *.md *.sh ./
COPY scripts ./scripts
RUN chmod +x scripts/*.sh

# Workaround for poetry bug https://github.com/python-poetry/poetry/issues/2657
ENV PYTHONPATH=/usr/src/app/$PROJECT_NAME/src:$PYTHONPATH

# just launch bash for debugging. Specify real entrypoints in docker-compose.yml
ENTRYPOINT ["/bin/bash"]
