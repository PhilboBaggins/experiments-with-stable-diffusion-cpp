ARG UBUNTU_VERSION=22.04

FROM ubuntu:$UBUNTU_VERSION

RUN apt-get update \
    && apt-get install -yy git python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /home/dev/
RUN git clone --recursive https://github.com/leejet/stable-diffusion.cpp sd \
    && cd sd/models \
    && pip install -r requirements.txt

WORKDIR /models/
ENTRYPOINT [ "python3", "/home/dev/sd/models/convert.py" ]
