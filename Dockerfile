# Private Use for pastebin - https://gitnet.fr/deblan/gist
# If you are running Arch Linux or any distribution with kernel 4.19+
# You must add 'overlay.metacopy=N' in your kernel parameters first

# Install prerequisties Software and copy config files
FROM ubuntu:18.04

VOLUME /data

ENV GIT_USRNM="kmahyyg"
ENV CADDYPATH="/data/caddyssl"
ENV GIT_MAILADDR="16604643+kmahyyg@users.noreply.github.com"
ENV rGDeps="npm php php-mysql php-pdo-sqlite php-cgi php-xml git git-lfs patch build-essential less ca-certificates curl zip unzip libxml2 libxml2-dev php-pear php-fpm supervisor python3 python2.7"

WORKDIR /root

RUN apt-get update -y \
    && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install --no-install-recommends tzdata apt-utils -y \
    && echo "US/Pacific" | tee /etc/timezone \
    && ln -fs /usr/share/zoneinfo/US/Pacific /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && apt install --no-install-recommends -y $rGDeps \
    && git config --global user.email $GIT_MAILADDR \
    && git config --global user.name $GIT_USRNM \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && phpenmod pdo_sqlite \
    && mkdir -p /opt/gistpb \
    && curl -LO https://github.com/kmahyyg/deblan_gist_dockered/releases/download/caddy/caddy.tar.bz2 \
    && tar jxvf caddy.tar.bz2 \
    && rm caddy.tar.bz2 \
    && chmod +x caddy
     
WORKDIR /opt/gistpb

COPY clonerep.sh /usr/bin
COPY firsttime.sh /usr/bin

RUN chmod +x /usr/bin/clonerep.sh \
    && /usr/bin/clonerep.sh \
    && ln -fs /data/gistpb/data /opt/gistpb/data

COPY entrypoint.py /opt/gistpb
COPY composer.json /opt/gistpb
COPY Makefile /opt/gistpb

RUN chmod +x /usr/bin/firsttime.sh \
    && chmod +x /opt/gistpb/entrypoint.py
    
EXPOSE 9091
EXPOSE 443
EXPOSE 80

# RUN INIT SCRIPT AND BUILD
CMD ["/usr/bin/python3", "/opt/gistpb/entrypoint.py"]


