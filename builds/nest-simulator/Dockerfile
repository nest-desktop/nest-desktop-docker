FROM ubuntu:22.04
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"
ARG DEBIAN_FRONTEND=noninteractive

ARG NEST_VERSION=3.7

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cython3 \
    libgsl-dev \
    libltdl-dev \
    libncurses5-dev \
    libopenmpi-dev \
    libreadline-dev \
    pandoc \
    python3-dev \
    python3-pip \
    wget

RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 12

# Get released files.
RUN wget https://github.com/nest/nest-simulator/archive/refs/tags/v${NEST_VERSION}.tar.gz -P /tmp && \
    cd /tmp && tar -zxf v${NEST_VERSION}.tar.gz

RUN python3 -m pip install --upgrade pip setuptools wheel
RUN python3 -m pip install -r /tmp/nest-simulator-${NEST_VERSION}/requirements_pynest.txt
RUN python3 -m pip install -r /tmp/nest-simulator-${NEST_VERSION}/requirements_nest_server.txt

RUN mkdir /tmp/nest-build && cd $_ && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest \
          /tmp/nest-simulator-${NEST_VERSION} && \
    make -j $(nproc) && \
    make install

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 52425
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
