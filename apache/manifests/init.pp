# Class: apache
#
# Manages apache.
# Include it to install and run apache with default settings
#
# Usage:
# include apache


class apache {
    
    require apache::params

    package { "apache":
        name   => "${apache::params::packagename}",
        ensure => present,
    }

    service { "apache":
        name       => "${apache::params::servicename}",
        ensure     => running,
        enable     => true,
        pattern    => "${apache::params::servicepattern}",
        hasrestart => true,
        hasstatus  => "${apache::params::hasstatus}",
        require    => Package["apache"],
        subscribe  => File["httpd.conf"],
    }

    file { "httpd.conf":
        path    => "${apache::params::configfile}",
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package["apache"],
        ensure  => present,
    }

    case $operatingsystem {
        debian: { include apache::debian }
        ubuntu: { include apache::debian }
        default: { }
    }

    
}

