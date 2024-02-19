# Use the official Ubuntu base image
FROM ubuntu:latest

# Update the package repository and install Apache2
RUN apt-get update && apt-get install -y apache2

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
COPY ./public-html/index.html /var/www/html/index.html

# Use the "exec" form of CMD to ensure Apache gets PID 1 and can receive Unix signals
CMD ["apache2ctl", "-D", "FOREGROUND"]