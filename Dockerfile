FROM centos:centos7

RUN yum update -y

ENV GOSU_VERSION 1.7
RUN set -x \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true
	
RUN yum install -y epel-release
RUN yum install -y ansible	
	
RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

EXPOSE 22

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var && chmod -R 777 /docker-entrypoint.sh

USER ansible
CMD ["ansible"]