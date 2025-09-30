# Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Update package index and install python3
# This is necessary to ensure the package lists are fresh before installing.
RUN apk update && \
    apk add --no-cache python3

# Copy web content to the container
COPY rootfs/www /www

# Copy the run script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]