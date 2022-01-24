FROM nestsim/nest:3.1
LABEL maintainer="Sebastian Spreizer <spreizer@web.de>"

ARG NEST_VERSION=3.2
ARG NEST_SRC_PATH=/tmp

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    cython3 \
    libgsl-dev \
    libltdl-dev \
    libncurses5-dev \
    libreadline-dev \
    pandoc \
    python \
    python3-dev \
    python3-numpy \
    python3-pandas \
    python3-pip \
    python3-scipy \
    python3-sphinx \
    wget

RUN apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3 10

RUN python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install flask flask-cors RestrictedPython uwsgi

RUN wget https://github.com/nest/nest-simulator/archive/refs/tags/v${NEST_VERSION}.tar.gz -P ${NEST_SRC_PATH} && \
    cd ${NEST_SRC_PATH} && tar -zxf v${NEST_VERSION}.tar.gz

RUN wget https://github.com/nest/nest-simulator/releases/download/v3.2/nest-simulator-3.2-p1-VersionNumber.patch -P ${NEST_SRC_PATH} && \
    cd ${NEST_SRC_PATH}/nest-simulator-${NEST_VERSION} && \
    patch -p1 < ${NEST_SRC_PATH}/nest-simulator-3.2-p1-VersionNumber.patch

RUN python3 -m pip install -r ${NEST_SRC_PATH}/nest-simulator-${NEST_VERSION}/doc/requirements.txt

RUN mkdir /tmp/nest-build && cd /tmp/nest-build && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/opt/nest \
          ${NEST_SRC_PATH}/nest-simulator-${NEST_VERSION} && \
    make -j 8 && \
    make html && \
    make install

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 5000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["0.0.0.0:5000"]
