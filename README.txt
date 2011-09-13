This contains generalized puppet script for the installation and configuration of nagios all Linux Operating Systems
*******************************************************************************************

Server Configuration Management Setup
=====================================


For rpm package: (redhat,centos, etc)
-------------------------------------
#For latest yum repositry we are doing the following steps:

su -c 'rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm'
wget http://rpms.famillecollet.com/enterprise/remi-release-5.rpm
rpm -Uvh remi-release-5*.rpm
sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/remi.repo

#Installing git and puppet

yum install git-core puppet

#Configuring ssh public key.

cd $HOME
ssh-keygen -t rsa 
vi .ssh/id_rsa.pub

Paste the ssh key into the GitHub account you'll be using

#Installation of nagios.


sudo git clone git@github.com:geopcgeo/Nagios.git

mkdir /etc/puppet/modules
mkdir /etc/puppet/manifests
cp -Rv Nagios/* /etc/puppet/modules
chmod -R 755 /etc/puppet/modules/app/scripts
cp /etc/puppet/modules/nodes.pp /etc/puppet/manifests/
puppet -v /etc/puppet/manifests/nodes.pp
init 6


For debian package: (ubuntu, debian etc)
----------------------------------------


# Installing git and puppet

sudo apt-get install -y git-core puppet


# Configuring ssh public key.

cd $HOME
sudo ssh-keygen -t rsa 
sudo vi .ssh/id_rsa.pub

# Paste the ssh key into the GitHub account you'll be using

sudo git clone git@github.com:geopcgeo/Nagios.git

# Installation of nagios.


sudo ln -s /$HOME/Nagios /etc/puppet/modules
sudo cp /etc/puppet/modules/nodes.pp /etc/puppet/manifests/
sudo chmod 755 /etc/puppet/modules/nagios/scripts/*
sudo puppet -v /etc/puppet/manifests/nodes.pp

