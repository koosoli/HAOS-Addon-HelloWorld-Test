# Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Update package index and install nginx
# This provides a robust, production-grade web server.
RUN apk update && \
    apk add --no-cache nginx

# Copy our custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy web content to the container
COPY rootfs/www /www

# Copy the run script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]