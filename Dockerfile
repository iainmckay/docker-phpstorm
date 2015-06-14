FROM ubuntu:wily
MAINTAINER Iain Mckay "me@iainmckay.co.uk"

#ADD https://download.jetbrains.com/webide/PhpStorm-8.0.3.tar.gz /opt/

# block from https://github.com/fgrehm/docker-netbeans
RUN sed 's/main$/main universe/' -i /etc/apt/sources.list && \
    apt-get update && apt-get install -y software-properties-common wget && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer libxext-dev libxrender-dev libxtst-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

RUN useradd -m -s /bin/bash developer \
    && mkdir /home/developer/.WebIde80 \
    && touch /home/developer/.WebIde80/.keep \
    && chown -R developer.developer /home/developer \
    && mkdir /opt/phpstorm \
    && wget -O - http://download.jetbrains.com/webide/PhpStorm-8.0.3.tar.gz | tar xzf - --strip-components=1 -C "/opt/phpstorm"

USER developer
VOLUME /home/developer/.WebIde80
CMD /opt/phpstorm/bin/phpstorm.sh
