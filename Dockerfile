FROM debian:latest
MAINTAINER = aster <asterio.gonzalez@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
ENV PKG_RESOURCES_CACHE_ZIP_MANIFESTS 1  # to adoid 'Warning: Detected setuptools version 5.5.1...'

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y python-pip
RUN apt-get install -y subversion
#RUN pip install --upgrade pip  # update PIP to the last version
RUN apt-get install -y vim  # only if we are going to enter interactively for debugging
RUN apt-get install -y wget curl # for debuging

# Install main packages
#======================
RUN apt-get install -y git-core
#RUN apt-get install -y apache2-utils  # htpasswd check contrib/htpasswd from trac

#RUN pip install -U trac
RUN apt-get install -y trac
#RUN pip install TracAccountManager

# Plugins
#======================

#RUN pip install graphviz
#RUN easy_install https://trac-hacks.org/svn/graphvizplugin/tags/0.11-0.7.5
RUN apt-get install -y trac-accountmanager
RUN apt-get install -y trac-wysiwyg
RUN apt-get install -y trac-graphviz
RUN apt-get install -y trac-mastertickets
RUN apt-get install -y trac-tags
RUN easy_install https://trac-hacks.org/svn/wikiautocompleteplugin/trunk/
#RUN easy_install tracstats
RUN apt-get install -y trac-includemacro

#RUN easy_install https://trac-hacks.org/svn/cardsplugin/trunk
#RUN easy_install https://trac-hacks.org/svn/whiteboardplugin/0.12/trunk/

#RUN apt-get install -y trac-customfieldadmin
#RUN apt-get install -y trac-xmlrpc
#RUN apt-get install -y trac-wikiprint
#RUN apt-get install -y trac-diavisview
#RUN apt-get install -y trac-announcer
#RUN apt-get install -y trac-batchmodify

#RUN easy_install https://trac-hacks.org/svn/wikiautocompleteplugin

# https://trac-hacks.org/wiki/TextareaKeyBindingsPlugin



# Apache services
#RUN apt-get install -y apache2
#RUN apt-get install -y libapache2-mod-python libapache2-mod-python-doc

# Configuration
#======================
COPY etc /etc/

# Trac setup
#======================
COPY root /root

# Setup trac and git environments
RUN bash /root/trac_setup.sh

# Apache mod_python
#RUN a2enconf trac.conf
#RUN a2enmod python
#RUN service apache2 start

#apt-get install -y cron
#apt-get install -y wget
#apt-get install -y libmysqlclient-dev
#apt-get install -y graphviz
#apt-get install -y python-imaging
#apt-get install -y python-dev
#apt-get install -y docutils-common

#pip install reportlab html5lib pypdf
#pip install pip --upgrade
#pip install trac mysql-python
#pip install pygments
#pip install docutils
#RUN pip install trac 


# Apache
#======================
#RUN apt-get install -y apache2 libapache2-mod-python openssl

# Set ssl certificates
#RUN mkdir -p /etc/ssl/private
#RUN mkdir -p /etc/ssl/certs
#COPY trac_ssl.key /etc/ssl/private/trac.key
#COPY trac_ssl.crt /etc/ssl/certs/trac.crt
#RUN chmod 400 /etc/ssl/private/trac.key /etc/ssl/certs/trac.crt

# permisions
#RUN chown www-data:www-data /etc/trac -R
#RUN chown www-data /var/trac -R
#RUN chown -R  www-data:www-data /trac 
#COPY apache2/apache2.conf /etc/apache2/apache2.conf

# Set only https
#RUN sed -i "s/Listen 80/Listen 443/g" /etc/apache2/ports.conf
#RUN rm /etc/apache2/sites-enabled/000-default.conf

# Enable ssl
#RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/
#RUN ln -s /etc/apache2/mods-available/ssl.conf /etc/apache2/mods-enabled/
#RUN ln -s /etc/apache2/mods-available/socache_shmcb.load /etc/apache2/mods-enabled

# Enable trac
#RUN mkdir -p /etc/apache2/conf.d
#COPY apache2/trac.conf /etc/apache2/conf.d

#RUN ln -s /etc/apache2/conf.d/ssl.conf /etc/apache2/sites-enabled/ssl.conf
#RUN ln -s /etc/apache2/conf.d/trac.conf /etc/apache2/sites-enabled/trac.conf

#COPY apache2/ssl.conf /etc/apache2/conf.d/
#COPY apache2/ports.conf /etc/apache2/
#COPY apache2/index.html /var/www/html

EXPOSE 80
#CMD ["/bin/bash"]
CMD ["/root/run.sh"]

