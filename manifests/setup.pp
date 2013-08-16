group { "puppet":
  ensure => "present",
}

exec { "apt-get update":
  path => "/usr/bin",
}

package { 'jenkins-tomcat':
  ensure => 'present',
  before => Service['tomcat6'],
}

service { 'tomcat6':
  ensure => 'running',
  enable => 'true',
}

class { 'apache':
  default_vhost     => false,
  default_ssl_vhost => false,
}

apache::mod { 'rewrite': }
apache::mod { 'proxy_ajp': }
apache::vhost { 'jenkins-vagrant.jdydev.com':
  port         => 80,
  docroot      => '/var/www/',
  rewrite_rule => '(.*) https://%{HTTP_HOST}%{REQUEST_URI} [R,L]',
}
apache::vhost {'jenkins-vagrant.jdydev.com-ssl':
  port         => 443,
  ssl          => true,
  docroot      => '/var/www/',
  rewrite_rule => '^/$  /jenkins  [R,L]',
  proxy_pass   => [ {
    'path' => '/jenkins',
    'url'  => 'ajp://localhost:8009/jenkins'
  }, ],
}

