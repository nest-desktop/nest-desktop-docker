ARG NEST_VERSION=3.8

FROM ubuntu:22.04 as builder
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"
ARG NEST_VERSION

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    cython3 \
    libgsl-dev \
    libltdl-dev \
    libncurses5-dev \
    libreadline-dev \
    pandoc \
    python3-dev \
    wget

# Get released files.
RUN wget https://github.com/nest/nest-simulator/archive/refs/tags/v${NEST_VERSION}.tar.gz -P /tmp && \
    tar -zxf /tmp/v${NEST_VERSION}.tar.gz --directory /tmp

RUN mkdir /tmp/nest-build && cd $_ && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest /tmp/nest-simulator-${NEST_VERSION} && \
    make -j $(nproc) && make install


FROM ubuntu:22.04
ARG NEST_VERSION

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    libgsl-dev \
    libltdl-dev \
    python3-pip

RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/nest-simulator-${NEST_VERSION} /tmp/nest-simulator
COPY --from=builder /opt/nest /opt/nest

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install numpy pandas && \
    python3 -m pip install flask Flask_Cors gunicorn RestrictedPython

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 52425
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
