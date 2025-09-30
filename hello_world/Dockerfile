FROM python:3.11-alpine

# Copy web content
COPY rootfs/www /www

# Copy and set up the run script
COPY run.sh /run.sh
RUN chmod a+x /run.sh

# Expose port
EXPOSE 8099

CMD ["/run.sh"]