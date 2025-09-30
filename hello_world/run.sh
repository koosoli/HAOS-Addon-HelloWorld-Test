#!/usr/bin/with-contenv bashio

bashio::log.info "Hello World Add-on is starting up..."
bashio::log.info "-----------------------------------------------------------"
bashio::log.info "Using the official Home Assistant Nginx base image."
bashio::log.info "Configuring Nginx for Ingress..."
bashio::log.info "-----------------------------------------------------------"

# Get the port from the Home Assistant Supervisor for Ingress
PORT=$(bashio::network.ingress_port)
bashio::log.info "Ingress is enabled. Configuring Nginx to listen on port: ${PORT}"

# Create a new Nginx server configuration file for Ingress.
# This will be included by the main nginx.conf from the base image.
CONFIG_PATH="/etc/nginx/servers/ingress.conf"
bashio::log.info "Creating Nginx configuration at ${CONFIG_PATH}..."

# Write the server configuration to the file
cat > "${CONFIG_PATH}" << EOF
server {
    # Listen on the port that Home Assistant provides for Ingress
    listen ${PORT};

    # The location of our web files
    root /www;

    # The default file to serve
    index index.html;

    # Fallback to index.html for single-page applications
    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOF

bashio::log.info "Nginx configuration for Ingress created."
bashio::log.info "The Nginx server will now be started by the base image's s6-overlay."