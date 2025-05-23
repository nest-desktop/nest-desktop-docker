#!/bin/bash

source /opt/nest/bin/nest_vars.sh

export NEST_SERVER_HOST="${NEST_SERVER_HOST:-0.0.0.0}"
export NEST_SERVER_STDOUT="${NEST_SERVER_STDOUT:-1}"

export NEST_SERVER_ACCESS_TOKEN="${NEST_SERVER_ACCESS_TOKEN}"
export NEST_SERVER_CORS_ORIGINS="${NEST_SERVER_CORS_ORIGINS:-*}"
export NEST_SERVER_DISABLE_AUTH="${NEST_SERVER_DISABLE_AUTH:-1}"
export NEST_SERVER_DISABLE_RESTRICTION="${NEST_SERVER_DISABLE_RESTRICTION:-1}"
export NEST_SERVER_ENABLE_EXEC_CALL="${NEST_SERVER_ENABLE_EXEC_CALL:-1}"
export NEST_SERVER_MODULES="${NEST_SERVER_MODULES:-import nest; import numpy; import numpy as np}"
export NEST_SERVER_WORKERS="${NEST_SERVER_WORKERS:-1}"

exec nest-server start
