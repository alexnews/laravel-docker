FROM centos:6
MAINTAINER Takayuki Miwa <i@tkyk.name>

ENV code_root /code
ENV httpd_conf ${code_root}/httpd.conf

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN yum install -y httpd
RUN yum install --enablerepo=epel,remi-php56,remi -y \
                              php \
                              php-cli \
                              php-gd \
                              php-mbstring \
                              php-mcrypt \
                              php-mysqlnd \
                              php-pdo \
                              php-xml \
                              php-xdebug
RUN sed -i -e "s|^;date.timezone =.*$|date.timezone = America/New_York|" /etc/php.ini

ADD . $code_root
RUN test -e $httpd_conf && echo "Include $httpd_conf" >> /etc/httpd/conf/httpd.conf

EXPOSE 80
CMD ["/usr/sbin/apachectl", "-D", "FOREGROUND"]

#RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
#RUN php -r "if (hash_file('SHA384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
#RUN php composer-setup.php
#RUN php -r "unlink('composer-setup.php');"
#RUN php composer.phar create-project laravel/laravel /code/www/lsapp 
#RUN mkdir /usr/local/www
#RUN mkdir /usr/local/www/aphorism.ru
#RUN ln -s /code/www /usr/local/www/aphorism.ru/www
#RUN ln -s /code/req /usr/local/www/aphorism.ru/req
