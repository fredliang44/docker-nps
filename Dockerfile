FROM alpine:3.6

LABEL maintainer="fredliang <info@fredliang.cn>"

RUN apk update && apk add zip bash tzdata curl wget && \
    cp -r -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -s https://api.github.com/repos/cnlh/nps/releases/latest \
    | grep "browser_download_url.*linux_amd64_server.tar.gz"  \
    | cut -d : -f 2,3 \
    | tr -d '\"' \
    | wget -i - && \
    tar -zxf *.tar.gz && rm -rf *.tar.gz && \
    mv nps/ /var/

WORKDIR /var/nps/

VOLUME /var/nps/conf

ENTRYPOINT /var/nps/nps