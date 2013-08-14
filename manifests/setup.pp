group { "puppet":
  ensure => "present",
}

exec { "apt-get update":
  path => "/usr/bin",
}

$default_packages = [ 'apache2', 'jenkins-tomcat', 'ssl-cert' ]
package { $default_packages :
  ensure => present,
}

service { "tomcat6":
  ensure => running,
  enable => true,
  hasrestart => true,
}

service { "apache2":
  ensure => running,
  enable => true,
  hasrestart => true,
}
