# Private Docker for pastebin

This build will use SQLite as a database backend, because this is a private instance and I don't need MySQL.

Upstream Link: https://gitnet.fr/deblan/gist

- Web Root: `./upstream/web`

## Modification

I modified:

- Makefile
- Composer.json

To fit the non-interactive build process of docker.

## Config files

For config details, check the upstream link:

- https://gitnet.fr/deblan/gist/src/branch/master/src/Gist/Composer/PostInstallHandler.php
- https://gitnet.fr/deblan/gist/wiki/_pages

Please mount `./dkdata` as `/data`. Please modify the config file according to your instance.

```
.
├── caddyssl
├── gistpb
│   ├── app
│   │   └── config
│   │       └── config.yml
│   ├── data
│   └── propel.yaml
└── spvisord
    ├── config
    │   ├── Caddyfile
    │   └── php-fpm.conf
    └── supervisord.conf

```

## Gist Pastebin

`./gistpb/propel.yaml` **SHOULD NOT BE MODIFIED** and the program will put it into the docker container!

`./gistpb/data` folder should be accessed by webserver.

`./gistpb/app/config/config.yml` should be modified according to your environment:

- token: sha1(uuidgen())
- api_key: 'WRITE SOMETHING AS YOU PLEASED' (Recommend: secrets.token_urlsafe(28) in Python 3.6+)
- Other things: Check upstream documents

## Supervisord

Modify the config about `php-fpm`, `supervisord.conf`, `Caddyfile` according to your circumstances.

 **If not necessary, please don't modify all files except `Caddyfile`.**

## Caddy

Caddy server is a light-weight, high-performance web server written in Golang.

The `caddy` executable file contains full plugins, use it as you want.

See more details about it at https://caddyserver.com/docs 

**YOU SHOULD MODIFY THE HOSTNAME AND EMAIL USED FOR SIGN A TLS CERT AT LEAST.**

# Upstream

Upstream Commit: 3972513905bcb007c8dbf56bb5dff40774df33c8

GIST
====

GIST is an open-source application to share code.
https://www.deblan.io/post/517/gist-est-dans-la-place

**[Read the wiki for more information](https://gitnet.fr/deblan/gist/wiki/_pages).**

### Editor

![Gist](https://upload.deblan.org/u/2018-08/5b7ab7a6.png "Gist editor")

### Result 

![Gist](https://upload.deblan.org/u/2018-08/5b7ab7d4.png "Gist result")

### Account

![Gist](https://upload.deblan.org/u/2018-08/5b7aba2d.png "Gist account")

### Embeded Gist

![Gist](https://upload.deblan.org/u/2018-08/5b7ab81c.png "Embeded Gist")
