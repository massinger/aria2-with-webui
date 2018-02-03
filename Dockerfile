FROM resin/armv7hf-debian
RUN [ "cross-build-start" ]

MAINTAINER massinger <massinger@139.com>

RUN apt-get update && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	apt-get install aria2 && \
	apt-get install git && \
	git clone https://github.com/ziahamza/webui-aria2 /aria2-webui && \
    rm /aria2-webui/.git* -rf && \
	apt-get install darkhttpd

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80
EXPOSE 8080

CMD ["/conf-copy/start.sh"]

RUN [ "cross-build-end" ]
