This contains generalized puppet script for the installation and configuration of nagios all Linux Operating Systems
*******************************************************************************************

Server Configuration Management Setup
=====================================


For rpm package: (redhat,centos, etc)
-------------------------------------
#For latest yum repositry download and install the rpmforge repository.

For x86 (32-bit) systemswe are doing the following steps:

rpm -Uhv http://apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.i386.rpm

For x64 (64-bit) systems:

rpm -Uhv http://apt.sw.be/redhat/el5/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm

#Installing git and puppet

yum install git-core puppet

#Configuring ssh public key.

cd $HOME
ssh-keygen -t rsa 
vi .ssh/id_rsa.pub

Paste the ssh key into the GitHub account you'll be using

#Installation of nagios.


sudo git clone git@github.com:geopcgeo/Nagios.git


ln -s /$HOME/Nagios /etc/puppet/modules
mkdir /etc/puppet/manifests
cp /etc/puppet/modules/nodes.pp /etc/puppet/manifests/
chmod 755 /etc/puppet/modules/nagios/scripts/*
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

Now you can login to Nagios Web Interface with url http://<IP Address>/nagios3/ with username nagiosadmin
----------------------------------------------------------------------------------------------------------
