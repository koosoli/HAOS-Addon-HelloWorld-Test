#!/usr/bin/with-contenv bashio

bashio::log.info "Hello World Add-on is starting up..."
bashio::log.info "-----------------------------------------------------------"
bashio::log.info "Using Nginx as a production-grade web server."
bashio::log.info "-----------------------------------------------------------"

# Get the port from the Home Assistant Supervisor for Ingress
PORT=$(bashio::network.ingress_port)
bashio::log.info "Ingress is enabled. Configuring Nginx to listen on port: ${PORT}"

# Dynamically update the Nginx configuration with the correct port
CONFIG_PATH="/etc/nginx/nginx.conf"
bashio::log.info "Updating Nginx configuration at ${CONFIG_PATH}..."
sed -i "s/%%PORT%%/${PORT}/g" "${CONFIG_PATH}"

bashio::log.info "Nginx configuration updated. Starting Nginx server..."

# Start the Nginx server in the foreground
# -c specifies the configuration file to use
exec nginx -c "${CONFIG_PATH}"

# The script will end here as `exec` replaces the current process.
# If nginx exits, the container will stop.
bashio::log.warning "Nginx server has stopped. Add-on is shutting down."