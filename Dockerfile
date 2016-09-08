FROM centos

RUN yum -y update
RUN yum -y install php-pecl-memcache php php-devel gcc httpd make

ADD depot/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm /tmp
ADD depot/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm /tmp

RUN yum -y localinstall /tmp/oracle-instantclient12.1-basic-12.1.0.2.0-1.x86_64.rpm
RUN yum -y localinstall /tmp/oracle-instantclient12.1-devel-12.1.0.2.0-1.x86_64.rpm

RUN echo 'instantclient,/usr/lib/oracle/12.1/client64/lib/' | pecl install oci8-2.0.12
RUN echo "extension=oci8.so" > /etc/php.d/oci8.ini

RUN echo "<?php echo phpinfo(); ?>" > /var/www/html/index.php
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]

