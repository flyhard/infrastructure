file { '/etc/sysconfig/docker':
  ensure  => "file",
  owner   => "root",
  group   => "root",
  mode    => "644",
  source  => "/tmp/puppet/docker",
}

# End node mynode.example.com