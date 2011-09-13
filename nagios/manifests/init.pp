
class nagios::install {

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
		
}

class nagios::web{
			case $operatingsystem
                {	   debian:  {       exec { "password":
							command =>"/etc/puppet/modules/nagios/scripts/ubuntu_web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
						ubuntu:	{       exec { "password":
							command =>"/etc/puppet/modules/nagios/scripts/web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
						centos: {       exec { "password":
							command =>"/etc/puppet/modules/nagios/scripts/centos_web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
				}
}

class nagios {
	require apache::params
	include apache, apache::params, nagios::install, nagios::web
	}




	



























