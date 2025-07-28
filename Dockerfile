FROM dunglas/frankenphp:latest-php8.2

RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    libpq-dev \
    libexif-dev \
    libsodium-dev

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN install-php-extensions \
    pgsql \
    pdo_pgsql \
    gd \
    intl \
    zip \
    exif \
    sodium \
    pcntl

WORKDIR /app

COPY . ./

CMD ["sleep", "infinity"]
