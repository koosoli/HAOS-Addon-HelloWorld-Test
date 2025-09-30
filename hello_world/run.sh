#!/usr/bin/with-contenv bashio

bashio::log.info "Hello World Add-on is starting up..."
bashio::log.info "-----------------------------------------------------------"
bashio::log.info "DEBUG: Printing environment variables"
env
bashio::log.info "-----------------------------------------------------------"

WEB_DIR="/www"
bashio::log.info "DEBUG: Checking if web directory '${WEB_DIR}' exists..."
if [ -d "$WEB_DIR" ]; then
    bashio::log.info "SUCCESS: Web directory '${WEB_DIR}' found."
    bashio::log.info "DEBUG: Contents of '${WEB_DIR}':"
    ls -lA "$WEB_DIR"
else
    bashio::log.error "FATAL: Web directory '${WEB_DIR}' not found. Check the Dockerfile."
    exit 1
fi

PORT=8099
bashio::log.info "Starting built-in httpd server on port ${PORT}, serving from ${WEB_DIR}"

# Start the httpd server in the foreground
# -f: Run in the foreground
# -p PORT: Listen on this port
# -h /www: Serve files from this directory
exec httpd -f -p "${PORT}" -h "${WEB_DIR}"

# The script will end here as `exec` replaces the current process.
# If httpd exits, the container will stop.
bashio::log.warning "httpd server has stopped. Add-on is shutting down."