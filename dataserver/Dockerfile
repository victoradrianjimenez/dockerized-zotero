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
apt-get -y install apache2 libapache2-mod-php8.3 mysql-client composer rinetd git && \
apt-get -y install php8.3-dev php8.3-xml php8.3-mbstring php8.3-mysql php8.3-memcached php8.3-curl php8.3-redis && \
apt-get -y install libmemcached11 libmemcachedutil2 libmemcached-dev zlib1g-dev

# Setup PHP
RUN \
sed -i 's/memory_limit = 128M/memory_limit = 1G/g' /etc/php/8.3/apache2/php.ini && \
sed -i 's/max_execution_time = 30/max_execution_time = 300/g' /etc/php/8.3/apache2/php.ini && \
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/8.3/apache2/php.ini && \
sed -i 's/short_open_tag = Off/short_open_tag = On/g' /etc/php/8.3/cli/php.ini && \
sed -i 's/display_errors = On/display_errors = Off/g' /etc/php/8.3/apache2/php.ini && \
sed -i 's/display_errors = Off/display_errors = On/g' /etc/php/8.3/apache2/php.ini && \
sed -i 's/error_reporting = E_ALL \& ~E_DEPRECATED \& ~E_STRICT/error_reporting = E_ALL \& ~E_NOTICE \& ~E_STRICT \& ~E_DEPRECATED/g' /etc/php/8.3/apache2/php.ini

# Setup igbinary
RUN DEBIAN_FRONTEND=noninteractive \
pecl install igbinary && \
echo "extension=igbinary.so" > /etc/php/8.3/mods-available/igbinary.ini

# Setup Memcached
RUN DEBIAN_FRONTEND=noninteractive \
pecl download memcached-3.2.0 && \
tar xvzf memcached-3.2.0.tgz && \
cd memcached-3.2.0 && \
phpize && \
./configure --enable-memcached-igbinary && \
make && \
make install && \
echo "extension=memcached.so" > /etc/php/8.3/mods-available/memcached.ini && \
ln -s /etc/php/8.3/mods-available/memcached.ini /etc/php/8.3/cli/conf.d/20-memcached.ini && \
ln -s /etc/php/8.3/mods-available/memcached.ini /etc/php/8.3/apache2/conf.d/20-memcached.ini

# Setup Apache2, Enable the new virtualhost and Override gzip configuration
COPY ./config/apache2/zotero.conf /etc/apache2/sites-available/
COPY ./config/apache2/gzip.conf /etc/apache2/conf-available/
RUN \
a2enmod rewrite headers && \
a2dissite 000-default && \
a2ensite zotero && \
a2enconf gzip

# Install AWS client
RUN \
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
./aws/install

# AWS local credentials
RUN \
mkdir ~/.aws && \
bash -c 'echo -e "[default]\nregion = us-east-1" > ~/.aws/config' && \
bash -c 'echo -e "[default]\naws_access_key_id = zotero\naws_secret_access_key = zoterodocker" > ~/.aws/credentials'

# Rinetd
RUN echo "0.0.0.0		8082		minio		9000" >> /etc/rinetd.conf

# HTTP_Request2
# RUN DEBIAN_FRONTEND=noninteractive pear install HTTP_Request2

WORKDIR /zotero
RUN \
git clone https://github.com/zotero/dataserver.git . && \
git clone https://github.com/zendframework/zf1.git /zf1 && \
mv -f /zf1/library/Zend/* ./include/Zend && \
rm -r -f /zf1

# Composer
RUN composer install

# Copy files
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Expose and entrypoint
EXPOSE 80/TCP
EXPOSE 81/TCP
EXPOSE 82/TCP
ENTRYPOINT ["/entrypoint.sh"]
