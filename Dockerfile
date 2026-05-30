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

# Enable Apache mod_rewrite (required for WordPress pretty permalinks)
# Remove event/worker MPM symlinks directly — a2dismod silently fails when
# a module is compiled in statically, leaving Apache with two MPMs loaded.
RUN rm -f /etc/apache2/mods-enabled/mpm_event.load \
          /etc/apache2/mods-enabled/mpm_event.conf \
          /etc/apache2/mods-enabled/mpm_worker.load \
          /etc/apache2/mods-enabled/mpm_worker.conf \
    && a2enmod rewrite headers

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
