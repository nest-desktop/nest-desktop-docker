#!/bin/bash

. /opt/nest/bin/nest_vars.sh

export NEST_SERVER_HOST="${NEST_SERVER_HOST:-0.0.0.0}"
export NEST_SERVER_MODULES="${NEST_SERVER_MODULES:-nest,numpy}"
export NEST_SERVER_RESTRICTION_OFF="${NEST_SERVER_RESTRICTION_OFF:-true}"
export NEST_SERVER_STDOUT="${NEST_SERVER_STDOUT:-1}"

exec nest-server start
