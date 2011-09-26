# This will install nagios and needed modules.
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
				require    => Package["nagios"],
                                                }
                        }
                        ubuntu:
                        {       package { [ "nagios-nrpe-server" ]:
                                ensure => installed,
				require    => Package["nagios"],
                                                }
                        }
                        default:
                        {       package { ["nagios-plugins","nagios-nrpe"]:
                                ensure => installed,
				require    => Package["nagios"],
                                                }
                        }
                }
        }

class nagios::web{
			case $operatingsystem
                {	   debian:  {       exec { "password":
							logoutput => true,
							command =>"/etc/puppet/modules/nagios/scripts/ubuntu_web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
						ubuntu:	{       exec { "password":
							logoutput => true,
							command =>"/etc/puppet/modules/nagios/scripts/ubuntu_web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
						centos: {    	file { "/etc/httpd/conf.d/nagios.conf":
                                                        ensure  => present,
                                                        source => "puppet:///modules/nagios/nagios.conf",
                                                        require => Class["nagios::install"],
                                                       }	
										exec { "password":
							logoutput => true,
							command =>"/etc/puppet/modules/nagios/scripts/centos_web_interface_password.sh $nagiosadmin_password",
							require => Service["${nagios::params::servicename}"]
											}
								}
				}
}

class nagios {
	require nagios::params
	include nagios::install, nagios::web, nagios::modules
	}




	



























