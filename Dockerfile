FROM ubuntu:16.04
MAINTAINER Iain Mckay "me@iainmckay.co.uk"

RUN apt-get update && \
    apt-get install -y software-properties-common wget git curl && \
    curl -sL https://deb.nodesource.com/setup_5.x | bash - && \
    apt-get update && \
    apt-get install -y graphviz phpunit nodejs \
        php7.0-cli php7.0-dev php7.0-curl php7.0-gd php7.0-gmp php7.0-json php7.0-ldap php7.0-mysql php7.0-odbc php7.0-pgsql php7.0-pspell php7.0-readline php7.0-recode php7.0-sqlite3 php7.0-tidy php7.0-xml php7.0-xmlrpc php7.0-bcmath php7.0-bz2 php7.0-enchant php7.0-imap php7.0-interbase php7.0-intl php7.0-mbstring php7.0-mcrypt php7.0-soap php7.0-sybase php7.0-xsl php7.0-zip php-memcache php-memcached php-pear \
        openjdk-8-jre libxext-dev libxrender-dev libxtst-dev && \
    pecl install xdebug && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN useradd -m -s /bin/bash developer \
    && mkdir /home/developer/.PhpStorm2016.2 \
    && touch /home/developer/.PhpStorm2016.2/.keep \
    && chown -R developer.developer /home/developer \
    && mkdir /opt/phpstorm \
    && wget -O - https://download.jetbrains.com/webide/PhpStorm-2016.2.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"

RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/bin
RUN phpenmod curl gd gmp json ldap mysql odbc pgsql pspell readline recode snmp sqlite3 tidy xml xmlrpc bcmath bz2 enchant imap interbase intl mbstring mcrypt soap sybase xsl zip xdebug memcache memcached
#RUN php5enmod mcrypt curl
RUN wget -c http://static.phpmd.org/php/latest/phpmd.phar -O /usr/bin/phpmd.phar && chmod +x /usr/bin/phpmd.phar
RUN pear install PHP_CodeSniffer
RUN npm install -g bower

USER developer
VOLUME /home/developer/.PhpStorm2016.2
CMD /opt/phpstorm/bin/phpstorm.sh
