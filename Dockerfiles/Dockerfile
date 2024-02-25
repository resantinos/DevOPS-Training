FROM ubuntu:latest

# Avoid interactive dialog during apt installation
ENV DEBIAN_FRONTEND=noninteractive

# Install Apache2, PHP, and other necessary packages
RUN apt-get update && \
    apt-get install -y apache2 php libapache2-mod-php php-mysql php-mbstring && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install phpMyAdmin non-interactively
RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean false' | debconf-set-selections && \
    echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections && \
    apt-get update && \
    apt-get install -y phpmyadmin

# Declare arguments for the DB certificate and hostname
ARG DB_CERT
ARG DB_HOSTNAME

# Configure phpMyAdmin to use the DigitalOcean managed database with SSL
# Configure phpMyAdmin to use the DigitalOcean managed database
RUN { \
    echo '$i++;'; \
    echo "\$cfg['Servers'][\$i]['host'] = '${DB_HOSTNAME}';"; \
    echo "\$cfg['Servers'][\$i]['port'] = '25060';"; \
    echo "\$cfg['Servers'][\$i]['ssl'] = true;"; \
    echo "\$cfg['Servers'][\$i]['ssl_ca'] = '/etc/phpmyadmin/ca-certificate.crt';"; \
    } >> /etc/phpmyadmin/config.inc.php

# Enable Apache mods
RUN a2enmod status
# Create the CA certificate file from the build argument
RUN echo "${DB_CERT}" > /tmp/cert
RUN cat /tmp/cert | sed -e 's/-----BEGIN CERTIFICATE-----/&\n/' -e 's/-----END CERTIFICATE-----/\n&/' | awk 'BEGIN {RS=""; FS="\n"} {print $1; body = substr($0, length($1) + 2, length($0) - length($1) - length($NF) - 3); gsub(/ /, "", body); len = length(body); for (i=1; i<=len; i+=64) {print substr(body, i, 64);} print $NF;}' > /etc/phpmyadmin/ca-certificate.crt
RUN rm /tmp/cert
#Convert the cert
#COPY Dockerfiles/convert_cert.sh /tmp/convert_cert.sh
#RUN chmod +x /tmp/convert_cert.sh
#CMD ["/bin/bash", "-c", "/tmp/convert_cert.sh"]

# Copy Apache configuration for Prometheus
COPY Dockerfiles/apache-custom.conf /etc/apache2/conf-available/apache-custom.conf

# Enable server-status and apache-custom configurations
RUN a2enconf apache-custom

# Configure /server-status access control for specific IP range
RUN echo '<Location "/server-status">' > /etc/apache2/conf-available/server-status.conf && \
    echo '    SetHandler server-status' >> /etc/apache2/conf-available/server-status.conf && \
    echo '    Require ip 10.245' >> /etc/apache2/conf-available/server-status.conf && \
    echo '</Location>' >> /etc/apache2/conf-available/server-status.conf

# Set environment variables for Apache
ENV APACHE_RUN_USER www-data \
    APACHE_RUN_GROUP www-data \
    APACHE_LOG_DIR /var/log/apache2 \
    APACHE_LOCK_DIR /var/lock/apache2 \
    APACHE_PID_FILE /var/run/apache2.pid

# Expose port 80
EXPOSE 80

# Copy your web content
COPY public-html/* /var/www/html/
RUN apache2ctl graceful
# Start Apache in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]
