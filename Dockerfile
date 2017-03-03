FROM centos:centos7

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var

RUN groupadd -r ansible && useradd -r -u 1000240000 -m -p password01 -g ansible ansible

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

RUN mkdir /.ansible

RUN yum install -y openssh openssh-server openssh-clients openssl-libs

ENV container docker

RUN chmod -R 777 /usr && chmod -R 777 /etc && chmod -R 777 /var && chmod -R 777 /.ansible

EXPOSE 22

USER ansible

CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/sbin/init"]