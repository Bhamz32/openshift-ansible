FROM centos:centos7

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

RUN groupadd -r ansible && useradd -r -m -g ansible ansible

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

RUN yum update -y

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

# Setup gosu for easier command execution
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64" \
    && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.2/gosu-amd64.asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -r /root/.gnupg/ \
    && chmod +x /usr/local/bin/gosu
	
RUN yum install -y epel-release
RUN yum install -y ansible
	
RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

EXPOSE 22

USER ansible
CMD ["ansible"]