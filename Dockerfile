# Dockerfile
# Extends the official WordPress image with additional PHP extensions
# and configurations useful for a production music school site.

FROM wordpress:6.5-php8.2-apache

# Install additional PHP extensions
RUN apt-get update && apt-get install -y \
    libwebp-dev \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fix MPM conflict at build time:
#   1. Remove any mpm_* symlinks from mods-enabled
#   2. Strip inline LoadModule mpm_* lines from apache2.conf (source of the
#      duplicate when symlinks alone are not the culprit)
#   3. Re-enable only mpm_prefork (required for mod_php)
#   4. Enable remoteip (for RemoteIPHeader), rewrite, and headers
RUN rm -f /etc/apache2/mods-enabled/mpm_*.load \
          /etc/apache2/mods-enabled/mpm_*.conf \
    && sed -i '/LoadModule mpm_/d' /etc/apache2/apache2.conf \
    && a2enmod mpm_prefork remoteip rewrite headers

# Copy custom Apache config
COPY apache.conf /etc/apache2/conf-available/wordpress.conf
RUN a2enconf wordpress

# Copy PHP upload settings (used by Railway — docker-compose mounts this separately for local)
COPY uploads.ini /usr/local/etc/php/conf.d/uploads.ini

# Set recommended PHP settings for WordPress
RUN { \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 300'; \
    echo 'max_input_vars = 3000'; \
    echo 'memory_limit = 256M'; \
} > /usr/local/etc/php/conf.d/wordpress-recommended.ini

# Install WP-CLI
RUN curl -sO https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

EXPOSE 80
