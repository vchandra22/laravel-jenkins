FROM dunglas/frankenphp:latest-php8.2

# System dependencies
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    libpq-dev \
    libexif-dev \
    libsodium-dev \
    gnupg \
    ca-certificates \
    git \
    software-properties-common

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN install-php-extensions \
    pgsql \
    pdo_pgsql \
    gd \
    intl \
    zip \
    exif \
    sodium \
    pcntl

# Install Node.js (22.x LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs

WORKDIR /app

# Copy and install dependencies
COPY . /app

# Setup Laravel dependencies
RUN composer install --no-interaction --prefer-dist --optimize-autoloader
RUN npm install && npm run build

# Setup permission for Laravel
RUN chown -R www-data:www-data /app/storage /app/bootstrap/cache
