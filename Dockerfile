# Based on centos:6.5. 
FROM centos:centos6
MAINTAINER Pseudot <pseudot@outlook.com>

# Install RPM keys
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6

# Install Git for updates
RUN yum -y install git tar wget gcc python-devel openssl-devel unzip libffi-devel

# Download files or copy files
COPY scripts/  /tmp/scripts
RUN chmod +x /tmp/scripts/*.sh
RUN cd /tmp/scripts; /tmp/scripts/get_files.sh

#COPY python/ez_setup.py /tmp/python/ez_setup.py
#ADD python/cheetah.tar.gz /tmp/python/cheetah.tar.gz
#ADD yenc/yenc.tar.gz /tmp/python/yenc.tar.gz
#ADD python/pyOpenSSL.tar.gz /tmp/python/pyOpenSSL.tar.gz
#COPY sabnzbd/ /opt/sabnzbd

# Install Supervisor to control processes

# Install easy_setup, python is already installed
RUN python /tmp/python/ez_setup.py

# Easy install supervisor, for running multiple procersses
RUN easy_install pip==1.5.6
RUN pip install supervisor==3.0

# Copy supervisord configuration.
RUN mkdir -p /usr/local/etc
COPY supervisor/supervisord.conf /usr/local/etc/supervisord.conf
COPY supervisor/supervisord_sabnzbd.conf /usr/local/etc/supervisor.d/supervisord_sabnzbd.conf

# Install cheetah
RUN cd /tmp/cheetah.tar.gz/Cheetah-*/; python setup.py install

# Install yenc
RUN cd /tmp/yenc.tar.gz/yenc-*/; python setup.py install

# Install pyOpenSSL
RUN cd /tmp/pyOpenSSL.tar.gz/pyOpenSSL-*/; python setup.py install

# Install RAR
RUN cp /tmp/rar.tar.gz/rar/unrar /usr/local/sbin/

# Install par2cmdline
RUN cp -r /tmp/par2commandline-lin64.tar.gz/par2cmdline-0.*/* /usr/local/sbin/

# Install sabnzbd
COPY sabnzbd/ /opt/sabnzbd
COPY sabnzbd_config/sabnzbd.ini /root/.sabnzbd/sabnzbd.ini

# Copy SSL
COPY ssl/sabnzbd.pem /opt/sabnzbd/ssl/sabnzbd.pem
COPY ssl/sabnzbd.key /opt/sabnzbd/ssl/sabnzbd.key
RUN chmod 0700 /opt/sabnzbd/ssl/sabnzbd.key
RUN chmod 0700 /opt/sabnzbd/ssl/sabnzbd.pem

# Remove temp files
RUN rm -rf /tmp/*

# Expose volumes
RUN mkdir /var/log/sabznbd
VOLUME [ "/var/log/sabnzbd", "//.sabnzbd/" "/opt/downloads/completed" ]

EXPOSE 8080 9001 9090

# Run the supervisor
WORKDIR /usr/bin
CMD ["/usr/bin/supervisord","--configuration=/usr/local/etc/supervisord.conf"]