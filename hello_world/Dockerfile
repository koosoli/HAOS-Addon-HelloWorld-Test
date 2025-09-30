# Dockerfile
FROM alpine:3.18

# Install nginx and bash (needed for bashio commands)
RUN apk add --no-cache \
    nginx \
    bash \
    curl \
    jq

# Install bashio for Home Assistant addon development
RUN curl -J -L -o /tmp/bashio.tar.gz \
    "https://github.com/hassio-addons/bashio/archive/v0.16.2.tar.gz" && \
    mkdir /tmp/bashio && \
    tar zxvf /tmp/bashio.tar.gz --strip 1 -C /tmp/bashio && \
    mv /tmp/bashio/lib /usr/lib/bashio && \
    ln -s /usr/lib/bashio/bashio /usr/bin/bashio && \
    rm -rf /tmp/bashio /tmp/bashio.tar.gz

# Create necessary directories
RUN mkdir -p /www /etc/nginx/servers

# Copy web content to the container
COPY rootfs/www /www

# Copy the run script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]