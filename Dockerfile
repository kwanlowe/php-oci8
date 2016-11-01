FROM centos

LABEL Name=php-oci8-centos Version=1.0
MAINTAINER Kwan Lowe "kwan@digitalhermit.com"

ADD depot/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp
ADD depot/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp

RUN  yum -y update && \
     yum -y install php-pecl-memcache php php-devel gcc httpd make libaio && \
     yum -y localinstall /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
                         /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm && \
     yum -y autoremove && \
     yum -y clean all && \
     rm /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm \
        /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm 

RUN echo 'instantclient,/usr/lib/oracle/12.1/client64/lib/' | pecl install oci8-2.0.12 && \
    echo "extension=oci8.so" > /etc/php.d/oci8.ini

ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
