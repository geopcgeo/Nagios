#!/bin/sh
#This will create password for the user nagiosadmin.
nagiosadmin_password=$1
echo "Configuring Nagios Web Interface Login"
htpasswd -b -c /etc/nagios3/htpasswd.users nagiosadmin $nagiosadmin_password
echo "Now you can login to Nagios Web Interface with url http://<IP Address>/nagios3/ with username nagiosadmin.
