# Use the official Ubuntu base image
FROM ubuntu:latest

# Install Apache2 and necessary tools
RUN apt-get update && \
    apt-get install -y apache2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable mod_status for Apache
RUN a2enmod status

# Configure /server-status access control for specific IP range
RUN echo '<Location "/server-status">' > /etc/apache2/conf-available/server-status.conf && \
    echo '    SetHandler server-status' >> /etc/apache2/conf-available/server-status.conf && \
    echo '    Require ip 10.245' >> /etc/apache2/conf-available/server-status.conf && \
    echo '</Location>' >> /etc/apache2/conf-available/server-status.conf && \
    a2enconf server-status

# Configure Apache to use the custom log format
RUN echo 'LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined' >> /etc/apache2/apache2.conf && \
    echo 'CustomLog ${APACHE_LOG_DIR}/access.log combined' >> /etc/apache2/apache2.conf

# Set environment variables to configure Apache.
# This is optional and can be customized.
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Expose web server port
# By default, Apache listens on port 80
EXPOSE 80

# Copy your custom "Hello World" page to the DocumentRoot
COPY ./public-html/* /var/www/html/

# Use the "exec" form of CMD to ensure Apache gets PID 1 and can receive Unix signals
CMD ["apache2ctl", "-D", "FOREGROUND"]