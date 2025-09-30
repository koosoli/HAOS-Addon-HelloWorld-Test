#!/usr/bin/with-contenv bashio

# Start a simple web server
bashio::log.info "Starting the Hello World addon..."
cd /www
python3 -m http.server 8099