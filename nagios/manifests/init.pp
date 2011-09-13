#
# Class: nagios
#
# Manages nagios.
# Include it to install and run nagios
# It defines package, service, main configuration file.
#
# Usage:
# include nagios
#
class nagios {

    # Load the variables used in this module. Check the params.pp file 
    require nagios::params
    include apache::params

    # No Nagios without webserver
    include apache

    # Basic Package - Service - Configuration file management
    package { "nagios":
        name   => "${nagios::params::packagename}",
        ensure => present,
    }
	
	# NRPE addon is designed to allow you to execute Nagios plugins on remote Linux/Unix machines.
	package { [ "nagios-nrpe-server" ]:
		ensure => present,
	}

    service { "nagios":
        name       => "${nagios::params::servicename}",
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => "${nagios::params::hasstatus}",
        pattern    => "${nagios::params::processname}",
        require    => Package["nagios"],
        subscribe  => File["nagios.conf"],
    }

    file { "nagios.conf":
        path    => "${nagios::params::configfile}",
        mode    => "${nagios::params::configfile_mode}",
        owner   => "${nagios::params::configfile_owner}",
        group   => "${nagios::params::configfile_group}",
        ensure  => present,
        require => Package["nagios"],
        notify  => Service["nagios"],
    }
	
	exec { "password":
		command =>"/etc/puppet/modules/nagios/scripts/web_interface_password.sh $nagiosadmin_password",
		require => Service["${nagios::params::servicename}"]
	}
	
}



	



























