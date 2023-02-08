FROM ubuntu:22.04
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"
ARG DEBIAN_FRONTEND=noninteractive

ARG NEST_VERSION=3.4_rc1
ARG NEST_SRC_PATH=/tmp

RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cython3 \
    libgsl-dev \
    libltdl-dev \
    libncurses5-dev \
    libreadline-dev \
    pandoc \
    python3-dev \
    python3-pip \
    wget

RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Install requirements for NEST Server.
RUN python3 -m pip install \
    Flask \
    Flask-Cors \
    gunicorn \
    RestrictedPython

# Get released files.
RUN wget https://github.com/nest/nest-simulator/archive/refs/tags/v${NEST_VERSION}.tar.gz -P ${NEST_SRC_PATH} && \
    cd ${NEST_SRC_PATH} && tar -zxf v${NEST_VERSION}.tar.gz

RUN python3 -m pip install -r ${NEST_SRC_PATH}/nest-simulator-${NEST_VERSION}/doc/requirements.txt && \
    python3 -m pip install sphinx_gallery==0.10.1

RUN mkdir /tmp/nest-build && cd /tmp/nest-build && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest \
          ${NEST_SRC_PATH}/nest-simulator-${NEST_VERSION} && \
    make -j $(nproc)
    
RUN make doc && \
    make install

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 52425
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
