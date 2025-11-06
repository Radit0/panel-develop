FROM php:8.2-fpm

# Install system deps
RUN apt-get update && apt-get install -y \
    unzip git curl libzip-dev libonig-dev libxml2-dev libpng-dev \
    libjpeg-dev libfreetype6-dev libmcrypt-dev default-mysql-client \
    && docker-php-ext-configure gd --with-freetype --with-jpeg

# Install PHP extensions yang dibutuhin
RUN docker-php-ext-install \
    pdo pdo_mysql bcmath zip gd exif pcntl

WORKDIR /app
COPY . .

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install project dependencies
RUN composer install --no-dev --optimize-autoloader

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
