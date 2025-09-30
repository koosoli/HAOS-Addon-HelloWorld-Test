# Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# The base image contains all the tools we need.
# No package installation is necessary for this simple addon.

# Copy web content to the container
COPY rootfs/www /www

# Copy the run script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]