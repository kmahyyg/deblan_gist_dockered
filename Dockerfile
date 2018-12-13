# Private Use for pastebin - https://gitnet.fr/deblan/gist
# If you are running Arch Linux or any distribution with kernel 4.19+
# You must add 'overlay.metacopy=N' in your kernel parameters first

# Install prerequisties Software and copy config files
FROM ubuntu:18.04

ENV GIT_USRNM="kmahyyg"
ENV GIT_MAILADDR="16604643+kmahyyg@users.noreply.github.com"
ENV rGDeps="npm php php-mysql mysql-server php-pdo-sqlite php-cgi php-xml git git-lfs patch build-essential less ca-certificates curl zip unzip libxml2 libxml2-dev php-pear php-fpm"

RUN echo "US/Pacific" | tee /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata
    && apt-get update -y \
    && apt install --no-install-recommends -y $rGDeps \
    && mkdir -p /run/php \
    && git config --global user.email $GIT_MAILADDR \
    && git config --global user.name $GIT_USRNM \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && phpenmod pdo_sqlite \
    && mkdir -p /opt/gistpb \
    && mkdir -p /data \
    && curl -LO https://github.com/kmahyyg/deblan_gist_dockered/releases/download/caddy/caddy.tar.bz2 \
    && tar jxvf caddy.tar.bz2
     
VOLUME /data

WORKDIR /opt/gistpb

RUN git clone -b upstr https://github.com/kmahyyg/deblan_gist_dockered.git . \
    && ln -s /data/data /opt/gistpb/data \

# Copy Gist config Files
ADD #TODO: Copy configs
    
RUN make

# Run PHP-FPM and CADDY via Supervisord

#TODO run supervisord

#TODO EXPOSE caddy port




     
