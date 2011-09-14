
class nagios::install {

    # Basic Package - Service - Configuration file management
    package { "nagios":
        name   => "${nagios::params::packagename}",
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

class nagios::modules {

                case $operatingsystem
                {
                        debian:
                        {       package { [ "nagios-nrpe-server" ]:
                                ensure => installed,
                                                }
                        }
                        ubuntu:
                        {       package { [ "nagios-nrpe-server" ]:
                                ensure => installed,
                                                }
                        }
                        default:
                        {       package { ["nagios-plugins","nagios-plugins-setuid","nagios-nrpe"]:
                                ensure => installed,
                                                }
                        }
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
	require nagios::params
	include apache, apache::params, nagios::install, nagios::web, nagios::modules
	}




	



























