FROM 192.168.128.23:5000/ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y apache2 libapache2-mod-php php-mysql git php-memcache curl php-cli php-mbstring unzip php-pgsql glusterfs-client wget2 prometheus-apache-exporter supervisor

RUN rm /var/www/html/index.html
RUN mkdir /var/www/html/images
ADD code/* /var/www/html/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD init.sh /

EXPOSE 80
EXPOSE 9117

ENTRYPOINT ["/usr/bin/supervisord","-c","/etc/supervisor/conf.d/supervisord.conf"]
