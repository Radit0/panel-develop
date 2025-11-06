FROM php:8.2-fpm

# Install system dependency + ext-zip
RUN apt update && apt install -y \
    libzip-dev zip unzip && \
    docker-php-ext-install zip

WORKDIR /app
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install dependency Laravel/Pterodactyl
RUN composer install --no-dev --optimize-autoloader

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
