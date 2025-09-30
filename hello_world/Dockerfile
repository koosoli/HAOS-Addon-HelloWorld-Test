# Dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# The base image is now specified in build.yaml and comes with Nginx pre-installed.
# No package installation or manual Nginx configuration is needed here.

# Copy web content to the container
COPY rootfs/www /www

# Copy the run script and make it executable
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]