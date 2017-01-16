FROM debian:latest
MAINTAINER = aster <asterio.gonzalez@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y apt-utils
RUN apt-get install -y python-pip
RUN pip install --upgrade pip  # update PIP to the last version
RUN apt-get install -y vim  # only if we are going to enter interactively for debugging


# Install packages
#======================
#RUN bash /root/trac_packages.sh

RUN apt-get install -y git-core
RUN pip install -U trac

# Configuration
#======================
COPY etc /etc/

# Trac setup
#======================
COPY root /root
RUN bash /root/trac_setup.sh



#apt-get install -y cron
#apt-get install -y wget
#apt-get install -y libmysqlclient-dev
#apt-get install -y subversion
#RUN apt-get install -y git
#RUN apt-get install -y vim
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

#RUN apt-get install -y pwgen
#RUN apt-get install -y git-core
#RUN apt-get install -y trac
#RUN apt-get install -y trac-git
#RUN apt-get install -y trac-accountmanager
#RUN apt-get install -y trac-customfieldadmin
#RUN apt-get install -y trac-xmlrpc
#RUN apt-get install -y trac-wikiprint
#RUN apt-get install -y trac-wysiwyg
#RUN apt-get install -y trac-mastertickets
#RUN apt-get install -y trac-tags
#RUN apt-get install -y trac-diavisview
#RUN apt-get install -y trac-announcer
#RUN apt-get install -y trac-batchmodify
#RUN apt-get install -y trac-graphviz
#RUN apt-get install -y python-flup

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


# Final settings
#======================

#ADD setup_trac_config.sh /.setup_trac_config.sh
#ADD setup_trac.sh /.setup_trac.sh
#ADD run.sh /run.sh
#ADD trac_logo.png /var/www/trac_logo.png

#ADD set_trac_user_password.py /usr/local/bin/
#RUN chmod 755 /usr/local/bin/set_trac_user_password.py


EXPOSE 80
CMD ["/bin/bash"]
#CMD ["/run.sh"]

