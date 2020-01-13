FROM php:7.2-cli

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get update && \
    apt-get install -y \
      git \
      zip \
      unzip \
      libpng-dev \
      libjpeg-dev \
      libfreetype6-dev \
      libmcrypt-dev && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/freetype2 --with-png-dir=/usr/include --with-jpeg-dir=/usr/include && \
    docker-php-ext-install pdo pdo_mysql mbstring exif calendar gd && \
    docker-php-ext-enable pdo pdo_mysql mbstring exif calendar gd
