# Use the official Docker Hub Ubuntu base image
FROM ubuntu:latest

# Update the base image
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y dist-upgrade && \
	apt-get -y install software-properties-common && \
	add-apt-repository ppa:ondrej/php && \
	apt-get update

# Install dependencies
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get -y install apache2 libapache2-mod-php8.3 mysql-client && \
	apt-get -y install php8.3-dev php8.3-xml php8.3-mbstring composer && \
	apt-get -y install libmemcached11 libmemcachedutil2 libmemcached-dev zlib1g-dev

# Setup PHP
RUN sed -i 's/memory_limit = 128M/memory_limit = 1G/g' /etc/php/8.3/apache2/php.ini && \
	sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php/8.3/apache2/php.ini && \
	sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/8.3/apache2/php.ini && \
	sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/8.3/cli/php.ini && \
	sed -i 's/display_errors = On/display_errors = Off/g' /etc/php/8.3/apache2/php.ini && \
	sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/8.3/apache2/php.ini && \
	sed -i 's/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/g' /etc/php/8.3/apache2/php.ini


RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php8.3-memcached php8.3-curl php8.3-redis

# Setup igbinary
RUN DEBIAN_FRONTEND=noninteractive \
	pecl install igbinary && \
	echo "extension=igbinary.so" > /etc/php/8.3/mods-available/igbinary.ini

# Setup Memcached
RUN DEBIAN_FRONTEND=noninteractive pecl download memcached-3.2.0 && tar xvzf memcached-3.2.0.tgz && cd memcached-3.2.0 && phpize && ./configure --enable-memcached-igbinary && make && make install
RUN echo "extension=memcached.so" > /etc/php/8.3/mods-available/memcached.ini
RUN ln -s /etc/php/8.3/mods-available/memcached.ini /etc/php/8.3/cli/conf.d/20-memcached.ini
RUN ln -s /etc/php/8.3/mods-available/memcached.ini /etc/php/8.3/apache2/conf.d/20-memcached.ini

# Setup Apache2
RUN a2enmod rewrite headers

# Enable the new virtualhost
COPY ./config/apache2/zotero.conf /etc/apache2/sites-available/
RUN a2dissite 000-default
RUN a2ensite zotero

# Override gzip configuration
COPY ./config/apache2/gzip.conf /etc/apache2/conf-available/
RUN a2enconf gzip


RUN DEBIAN_FRONTEND=noninteractive apt-get -y install php8.3-mysql

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install rinetd
# Rinetd
RUN echo "0.0.0.0		8082		minio		9000" >> /etc/rinetd.conf

# HTTP_Request2
RUN DEBIAN_FRONTEND=noninteractive pear install HTTP_Request2

# Expose and entrypoint
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
VOLUME /var/www/zotero
EXPOSE 80/tcp
EXPOSE 81/TCP
EXPOSE 82/TCP
ENTRYPOINT ["/entrypoint.sh"]