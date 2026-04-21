FROM deathwalker66/golang AS builder

### [ ENV ]
ENV GO111MODULE=on \
    GOOS=linux \
    GOARCH=amd64 \
    CGO_ENABLED=0

### [ WORKDIR ]    
WORKDIR /APP

RUN set -eux ;\
### Install Git
    apk --no-cache add \
    build-base  \
    git ;\
### Git Caddy en la ruta correcta
    git clone https://github.com/caddyserver/caddy.git ;\
    cd caddy/cmd/caddy ;\
### Add PHP Module(FastCGI)
    go get github.com/caddyserver/caddy/v2/modules/caddyhttp/reverseproxy/fastcgi ;\
### Make Caddy (Optimizado)
    export PATH=$PATH:/usr/local/go/bin ;\
    go build -ldflags="-s -w -extldflags '-static'" -o /caddy . ;\
    strip /caddy  # Reduce el tamaño del binario

FROM deathwalker66/alpine

LABEL Maintainer="CatDEV <dev.catnet@gmail.com>"

### [ ENV ]
ENV CADDY_VERSION=2.7.6

### COPY
COPY ./PRC/profile /etc/profile
COPY --from=builder /caddy /usr/bin/caddy
COPY SCP /SCP

### [ RUN ]
### [!]: Replace \ + && with ;\
RUN set -eux ;\  
### Directory for Caddy
    mkdir -p /data/caddy \
             /config/caddy \
             /APP/HTML \
             /etc/caddy \
             /var/log/caddy ;\
### Set Permissions
    chmod +x /usr/bin/caddy ;\
    chown -R root:root /etc/caddy /data/caddy /config/caddy /APP/HTML /var/log/caddy ;\
    chmod 755 /APP/HTML ;\
    chmod 755 /var/log/caddy ;\             
### Set Script Dir
    chmod +x /SCP/* ;\
### Set COM Dir
    chmod -R 777 /COM ;\   
### Clean [!]
    /SCP/clean.sh

### [ EXPOSE ]
EXPOSE 22 80 443 2019

### [ ENTRYPOINT ]
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

### [ CMD ]
CMD ["/SCP/entrypoint.sh"]
