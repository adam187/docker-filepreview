FROM ubuntu:trusty

ARG DEBIAN_FRONTEND=noninteractive

# Install build dependencies
RUN apt-get update \
    && \
    apt-get install -y -q \
    software-properties-common \
    python-software-properties \
    build-essential

RUN apt-get update \
    && \
    apt-get install -y -q --no-install-recommends \
    apt-utils

# Add ppa for ffmpeg
RUN add-apt-repository ppa:mc3man/trusty-media -y

RUN apt-get upgrade -y -q

# Install unoconv dependencies
RUN apt-get update \
    && \
    apt-get install -f -y -q \
    python3-uno \
    libreoffice-writer \
    libreoffice-draw \
    libreoffice-calc \
    libreoffice-impress

# Install filepreview dependencies
RUN apt-get update \
    && \
    apt-get install -y -f -q \
    unoconv \
    ffmpeg \
    imagemagick \
    curl

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
RUN apt-get install -y nodejs

# Cleanup
RUN apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
