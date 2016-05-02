include sumo

$region=$::ec2_placement_availability_zone

# file { '/etc/sysconfig/docker':
#   ensure   => "file",
#   owner    => "root",
#   group    => "root",
#   mode     => "644",
#   content  => template("/tmp/puppet/docker"),
# }

user { 'admin':
  ensure => "present",
  uid    => 1000,
  gid    => "admin",
  groups => ["adm","docker"],
}
service { 'docker':
  ensure    => 'running',
  # subscribe => File['/etc/sysconfig/docker'],
}

