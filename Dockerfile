# Private Use for pastebin - https://gitnet.fr/deblan/gist
# If you are running Arch Linux or any distribution with kernel 4.19+
# You must add 'overlay.metacopy=N' in your kernel parameters first

FROM ubuntu:18.04
 
RUN rGDeps='npm php php-mysql mysql-server php-pdo-sqlite php-xml git git-lfs patch build-essential less ca-certificates curl zip unzip libxml2 libxml2-dev' \
    && echo "America/New_York" | sudo tee /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata
    && apt-get update -y \
    && apt install --no-install-recommends -y $rGDeps \
    && git config --global user.email "16604643+kmahyyg@users.noreply.github.com" \
    && git config --global user.name "kmahyyg" \
    && curl -sS https://getcomposer.org/installer | php \
    && chmod +x composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && mkdir -p /opt/gistpb \
    && mkdir -p /data
     
VOLUME /data

WORKDIR /opt/gistpb

RUN git clone https://github.com/kmahyyg/deblan_gist_dockered.git



     
