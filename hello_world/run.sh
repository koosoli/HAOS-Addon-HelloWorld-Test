#!/usr/bin/with-contenv bashio

bashio::log.info "Hello World Add-on is starting up..."
bashio::log.info "-----------------------------------------------------------"
bashio::log.info "DEBUG: Printing environment variables"
env
bashio::log.info "-----------------------------------------------------------"

bashio::log.info "DEBUG: Checking if python3 is installed..."
if command -v python3 &> /dev/null
then
    bashio::log.info "SUCCESS: python3 is installed."
    python3 --version
else
    bashio::log.error "FATAL: python3 is not installed. Please check the Dockerfile."
    exit 1
fi

WEB_DIR="/www"
bashio::log.info "DEBUG: Checking if web directory '${WEB_DIR}' exists..."
if [ -d "$WEB_DIR" ]; then
    bashio::log.info "SUCCESS: Web directory '${WEB_DIR}' found."
    bashio::log.info "DEBUG: Contents of '${WEB_DIR}':"
    ls -lA "$WEB_DIR"
else
    bashio::log.error "FATAL: Web directory '${WEB_DIR}' not found."
    exit 1
fi

bashio::log.info "Changing to directory '${WEB_DIR}'..."
cd "$WEB_DIR"

PORT=8099
bashio::log.info "Starting Python3 HTTP server on port ${PORT}..."
python3 -m http.server "${PORT}" &

SERVER_PID=$!
bashio::log.info "Web server started with PID: ${SERVER_PID}"

# Wait for the server to exit
wait "${SERVER_PID}"

bashio::log.info "Web server has stopped."
bashio::log.info "Hello World Add-on is shutting down."