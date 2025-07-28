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

# Set working directory
WORKDIR /app

# Copy only composer definitions to leverage Docker cache
COPY composer.json composer.lock ./

# Copy remaining source code
COPY . ./

# Start with sleep (biar Jenkins bisa exec command)
CMD ["sleep", "infinity"]
