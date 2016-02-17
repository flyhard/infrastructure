class sumo::config (
  $sumo_exec       = $sumo::params::sumo_exec,
  $sumo_short_arch = $sumo::params::sumo_short_arch,
) inherits sumo::params {

  file {
    '/usr/local/sumo':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root';
    '/etc/sumo.conf':
      ensure => present,
      owner  => root,
      mode   => '0600',
      group  => root,
      content => template('sumo/sumo.erb');
    '/usr/local/sumo/sumo.json':
      ensure  => present,
      owner   => 'root',
      mode    => '0600',
      group   => 'root',
      source  => 'puppet:///modules/sumo/sumo.json',
      require => File['/usr/local/sumo'];
  }

  exec { 'Download Sumo Executable':
    command => "/usr/bin/curl -o /usr/local/sumo/${sumo_exec} https://collectors.sumologic.com/rest/download/linux/${sumo_short_arch}",
    cwd     => '/usr/bin',
    path    => [ '/usr/bin', '/usr/local/bin' ],
    creates => "/usr/local/sumo/${sumo_exec}",
    require => File['/usr/local/sumo'],
  }

  exec { 'Execute sumo':
    command => "/bin/sh /usr/local/sumo/${sumo_exec} -q",
    cwd     => '/usr/local/sumo',
    creates => '/opt/SumoCollector',
    path    => ['/usr/local/sumo', '/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require => Exec['Download Sumo Executable'],
  }
}
