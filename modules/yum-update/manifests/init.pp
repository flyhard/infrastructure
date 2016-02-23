# == Class: update
#
# Full description of class update here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'update':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class yum {

  class yum::update
  {
    # Notes: A longer timout is required for this particular run,
    #        The time check can be overridden if a specific file exists in /var/tmp
    exec
    {
      "monthly-yum-update":
        command => "yum clean all; yum -q -y update --exclude cvs; rm -rf /var/tmp/forceyum",
        timeout => 1800,
#        onlyif => "/usr/bin/test `/bin/date +%d` -eq 06 && test `/bin/date +%H` -eq 11 || test -e /var/tmp/forceyum",
    }
  }
}
