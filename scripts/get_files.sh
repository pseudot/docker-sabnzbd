#!/bin/bash
if [ ! -z "$1" ]; then
  LOC=$1
  LOC2=$LOC1
else 
  LOC=/tmp
  LOC2=/opt
fi

# Get setuptools
echo Downloading setuptools
if [ ! -d "$LOC/python" ]; then
  mkdir $LOC/python
fi
wget https://bootstrap.pypa.io/ez_setup.py --no-check-certificate -O $LOC/python/ez_setup.py -nv 

# download pyopenssl
echo Downloading pyOpenSSL
wget --no-check-certificate https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.14.tar.gz -O $LOC/python/pyOpenSSL.tar.gz -nv 
mkdir /tmp/pyOpenSSL.tar.gz
tar -zxf $LOC/python/pyOpenSSL.tar.gz -C /tmp/pyOpenSSL.tar.gz

# Download cheetah
echo Downloading cheetah
wget --no-check-certificate http://pypi.python.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz -O $LOC/python/cheetah.tar.gz  -nv 
mkdir /tmp/cheetah.tar.gz
tar -zxf $LOC/python/cheetah.tar.gz -C /tmp/cheetah.tar.gz

#yENc
echo Downloading yENC
wget http://www.golug.it/pub/yenc/yenc-0.4.0.tar.gz -O $LOC/python/yenc.tar.gz -nv 
mkdir /tmp/yenc.tar.gz
tar -zxf $LOC/python/yenc.tar.gz -C /tmp/yenc.tar.gz

if [ ! -d "$LOC/os" ]; then
  mkdir $LOC/os
fi
#Rar
echo Downloading RAR
wget http://www.rarlab.com/rar/rarlinux-x64-4.1.1.tar.gz -O $LOC/os/rar.tar.gz -nv
mkdir /tmp/rar.tar.gz
tar -zxf $LOC/os/rar.tar.gz -C /tmp/rar.tar.gz

#par2
echo Downloading par2
wget http://chuchusoft.com/par2_tbb/par2cmdline-0.4-tbb-20100203-lin64.tar.gz -O $LOC/os/par2commandline-lin64.tar.gz -nv
mkdir /tmp/par2commandline-lin64.tar.gz
tar -zxf $LOC/os/par2commandline-lin64.tar.gz -C /tmp/par2commandline-lin64.tar.gz

echo Cloning sabnzbd repo
if [ -d "$LOC2/sabnzbd" ]; then
  rm -rf $LOC2/sabnzbd
fi

mkdir $LOC2/sabnzbd
git clone -b master https://github.com/sabnzbd/sabnzbd.git $LOC2/sabnzbd
