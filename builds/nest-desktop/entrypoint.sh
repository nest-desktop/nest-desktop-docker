#!/bin/bash

jq -n \
  --arg nest_simulator_path "${NEST_SIMULATOR_PATH}" \
  --arg nest_simulator_port "${NEST_SIMULATOR_PORT}" \
  --arg nest_simulator_url "${NEST_SIMULATOR_URL}" \
  '{
    nestSimulator: {
      path: $nest_simulator_path,
      port: $nest_simulator_port,
      url: $nest_simulator_url
    }
  }' > /usr/share/nginx/html/config/app.json

exec "$@"
