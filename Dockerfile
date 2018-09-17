FROM ubuntu:16.04
MAINTAINER Iain Mckay "me@iainmckay.co.uk"

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PHP_ZEND_EXTENSION ${PHP_ZEND_EXTENSION:-"zend_extension=/usr/lib/php/20170718/xdebug.so"}
ENV PHP_XDEBUG_DEFAULT_ENABLE ${PHP_XDEBUG_DEFAULT_ENABLE:-1}
ENV PHP_XDEBUG_REMOTE_ENABLE ${PHP_XDEBUG_REMOTE_ENABLE:-1}
ENV PHP_XDEBUG_REMOTE_HOST ${PHP_XDEBUG_REMOTE_HOST:-"127.0.0.1"}
ENV PHP_XDEBUG_REMOTE_PORT ${PHP_XDEBUG_REMOTE_PORT:-9000}
ENV PHP_XDEBUG_REMOTE_AUTO_START ${PHP_XDEBUG_REMOTE_AUTO_START:-1}
ENV PHP_XDEBUG_REMOTE_CONNECT_BACK ${PHP_XDEBUG_REMOTE_CONNECT_BACK:-1}
ENV PHP_XDEBUG_IDEKEY ${PHP_XDEBUG_IDEKEY:-docker}
ENV PHP_XDEBUG_PROFILER_ENABLE ${PHP_XDEBUG_PROFILER_ENABLE:-0}
ENV PHP_XDEBUG_PROFILER_OUTPUT_DIR ${PHP_XDEBUG_PROFILER_OUTPUT_DIR:-"/tmp"}

RUN apt-get update && apt-get install -y software-properties-common && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && apt-get update && \
    apt-get install -y software-properties-common wget git curl && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated graphviz phpunit nodejs \
        php7.2-cli php7.2-dev php7.2-curl php7.2-gd php7.2-gmp php7.2-json php7.2-ldap php7.2-mysql php7.2-odbc php7.2-pgsql php7.2-pspell php7.2-readline php7.2-recode php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xmlrpc php7.2-bcmath php7.2-bz2 php7.2-enchant php7.2-imap php7.2-interbase php7.2-intl php7.2-mbstring php7.2-soap php7.2-sybase php7.2-xsl php7.2-zip php-memcache php-memcached php-pear \
        openjdk-8-jre libxext-dev libxrender-dev libxtst-dev && \
    pecl install xdebug && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

COPY xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

RUN useradd -m -s /bin/bash developer \
    && mkdir /home/developer/.PhpStorm2018.2 \
    && touch /home/developer/.PhpStorm2018.2/.keep \
    && chown -R developer.developer /home/developer \
    && mkdir /opt/phpstorm \
    && wget -O - https://download.jetbrains.com/webide/PhpStorm-2018.2.3.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin
RUN phpenmod curl gd gmp json ldap mysql odbc pgsql pspell readline recode snmp sqlite3 tidy xml xmlrpc bcmath bz2 enchant imap interbase intl mbstring mcrypt soap sybase xsl zip xdebug memcache memcached
#RUN php5enmod mcrypt curl
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar -O /usr/bin/phpmd.phar && chmod +x /usr/bin/phpmd.phar
RUN pear install PHP_CodeSniffer
RUN npm install -g bower

USER developer
VOLUME /home/developer/.PhpStorm2018.2
CMD /opt/phpstorm/bin/phpstorm.sh
