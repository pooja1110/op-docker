#
# OS-PHP CentOS with Web Application Components on Codeship
#
FROM centos:6

MAINTAINER Pooja Pande <pooja.pande11@gmail.com>

RUN yum -y install epel-release
RUN yum -y install wget
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN wget https://centos6.iuscommunity.org/ius-release.rpm
RUN rpm -Uvh ius-release*.rpm
RUN yum -y update

RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

################################################################################
# INSTALL PHP
################################################################################

# Installing nginx
RUN yum -y install nginx

RUN yum -y install php56u-fpm php56u php56u-opcache php56u-xml php56u-mcrypt php56u-gd php56u-devel php56u-mysql php56u-intl php56u-mbstring php56u-bcmath php56u-pecl-memcache php56u-soap \
    cronie gcc git memcached nginx supervisor unzip && \
    chkconfig supervisord on && \
    echo -e "short_open_tag=On" > /etc/php.d/shortopentags.ini && \
    echo -e "date.timezone=\"Asia/Singapore\"" > /etc/php.d/timezone.ini

################################################################################
# INSTALL MYSQL
################################################################################
# add the official mysql rpm repo
RUN wget -q http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm
RUN rpm -ivh mysql-community-release-el6-5.noarch.rpm
RUN yum -y install mysql-server mysql-client

################################################################################
# INSTALL unzip
################################################################################
RUN yum install zip unzip -y

RUN rpm -Uvh http://dheche.fedorapeople.org/hhvm/el6/RPMS/x86_64/hhvm-release-6-1.noarch.rpm
RUN yum -y install hhvm


################################################################################
# Download AWS CLI
################################################################################
RUN \
 curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" &&\
 unzip awscli-bundle.zip &&\
 ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws &&\
 rm -rfv awscli-bundle awscli-bundle.zip

################################################################################
# INSTALL GIT
################################################################################
RUN yum -y install git gcc

################################################################################
# INSTALL ZIP
################################################################################
RUN yum -y install git software-properties-common zip unzip


################################################################################
# INSTALL COMPOSER
################################################################################
#RUN curl -sS https://getcomposer.org/installer | php -- --install -dir=/usr/bin/ --filename=composer
