#!/bin/bash

. /opt/nest/bin/nest_vars.sh

export NEST_SERVER_MODULES=nest,numpy
export NEST_SERVER_RESTRICTION_OFF=true

uwsgi nest-server
