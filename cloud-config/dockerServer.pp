$region=$::ec2_placement_availability_zone

file { '/etc/sysconfig/docker':
  ensure   => "file",
  owner    => "root",
  group    => "root",
  mode     => "644",
  content  => template("/tmp/puppet/docker"),
}

file { '/etc/ecs/ecs.config':
  ensure  => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  content => template('/tmp/puppet/ecs.config'),
}

user { 'ec2-user':
  ensure => "present",
  uid    => 500,
  gid    => "ec2-user",
  groups => ["wheel","docker"],
}
service { 'docker':
  ensure    => 'running',
  subscribe => File['/etc/sysconfig/docker'],
}
exec { '/usr/libexec/amazon-ecs-init pre-start':
  require => [Service['docker'],File['/etc/ecs/ecs.config']],
  path    => "/usr/local/bin:/usr/bin:/bin",
  onlyif  => 'test ! $(docker ps |grep ecs-agent)',
}
exec { '/usr/libexec/amazon-ecs-init start':
  require => Exec['/usr/libexec/amazon-ecs-init pre-start'],
  path    => "/usr/local/bin:/usr/bin:/bin",
  onlyif  => 'test ! $(docker ps |grep ecs-agent)',

}
# End node mynode.example.com