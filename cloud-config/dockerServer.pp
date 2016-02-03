$region=$::ec2_placement_availability_zone

file { '/etc/sysconfig/docker':
  ensure  => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  content  => template("/tmp/puppet/docker"),
}

file { '/etc/ecs/ecs.config':
  ensure => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  content => template('/tmp/puppet/ecs.config'),
}

# End node mynode.example.com