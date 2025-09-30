#!/bin/bash
set -e

echo "Hello World Add-on is starting up..."
echo "-----------------------------------------------------------"
echo "Configuring Nginx for Ingress..."
echo "-----------------------------------------------------------"

# Get the ingress port from environment (Home Assistant sets this)
if [ -n "$HASSIO_TOKEN" ]; then
    # Try to get the ingress port from the API
    INGRESS_PORT=$(curl -s -H "Authorization: Bearer $HASSIO_TOKEN" \
        http://supervisor/addons/self/info | jq -r '.data.ingress_port // 8099')
else
    # Fallback to default port
    INGRESS_PORT=8099
fi

echo "Nginx will listen on port: ${INGRESS_PORT}"

# Create Nginx configuration
cat > /etc/nginx/nginx.conf << EOF
user root;
worker_processes auto;
error_log /dev/stdout info;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;
    
    access_log /dev/stdout;
    
    sendfile on;
    keepalive_timeout 65;
    
    server {
        listen ${INGRESS_PORT};
        server_name _;
        
        root /www;
        index index.html;
        
        location / {
            try_files \$uri \$uri/ /index.html;
        }
    }
}
EOF

echo "Nginx configuration created."
echo "Starting Nginx..."

# Start nginx in foreground
exec nginx -g 'daemon off;'