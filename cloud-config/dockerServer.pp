$region=$::ec2_placement_availability_zone

file { '/etc/sysconfig/docker':
  ensure  => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  content  => template("/tmp/puppet/docker"),
}

$ecs_config = @(END)
  ECS_CLUSTER=$cluster_name
END

file { '/etc/ecs/ecs.config':
  ensure => "file",
  content => inline_template($ecs_config)
}

# End node mynode.example.com