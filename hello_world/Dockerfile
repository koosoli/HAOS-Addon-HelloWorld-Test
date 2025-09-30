# Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install python3
RUN apk add --no-cache python3

# Copy rootfs
COPY rootfs /

# Set up our script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]