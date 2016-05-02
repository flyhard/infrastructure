include sumo
#include yum::update

$region=$::ec2_placement_availability_zone

file { '/etc/sysconfig/docker':
  ensure   => "file",
  owner    => "root",
  group    => "root",
  mode     => "644",
  content  => template("/tmp/puppet/docker"),
}
file { '/var/lib/ecs/data':
  ensure => directory,
  purge => true,
  recurse => true,
  force => true
}

file { '/etc/ecs/ecs.config':
  ensure  => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  notify  => [Exec['start ecs'],File['/var/lib/ecs/data']],
  content => template('/tmp/puppet/ecs.config'),
}

user { 'admin':
  ensure => "present",
  uid    => 500,
  gid    => "admin",
  groups => ["wheel","docker"],
}
service { 'docker':
  ensure    => 'running',
  subscribe => File['/etc/sysconfig/docker'],
}

