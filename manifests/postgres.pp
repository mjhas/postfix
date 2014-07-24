# == Class: postfix::postgres
#
# Set up postgres backend for postfix
#
# === Parameters
#
# === Variables
#
# === Authors
#
# mjhas@github
class postfix::postgres (
  $dbname     = undef,
  $dbuser     = undef,
  $dbpassword = undef,
  $hosts      = 'localhost',
) {
  include postfix

  package { 'postfix-pgsql':
    ensure  => 'installed',
    require => Package['postfix'],
    notify  => Service['postfix'],
  }

  file { '/etc/postfix/postgresql':
    ensure => directory,
    mode   => '0750',
    owner  => root,
    group  => postfix,
    require=> Package['postfix-pgsql'],
  }

  file { '/etc/postfix/postgresql/virtual_email2email.cf':
    content => template('postfix/virtual_email2email.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }

  file { '/etc/postfix/postgresql/virtual_domains.cf':
    content => template('postfix/virtual_domains.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }

  file { '/etc/postfix/postgresql/virtual_forwardings.cf':
    content => template('postfix/virtual_forwardings.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }

  file { '/etc/postfix/postgresql/virtual_limit_maps.cf':
    content => template('postfix/virtual_limit_maps.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }

  file { '/etc/postfix/postgresql/virtual_mailboxes.cf':
    content => template('postfix/virtual_mailboxes.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }

  file { '/etc/postfix/postgresql/virtual_transports.cf':
    content => template('postfix/virtual_transports.cf'),
    require => File['/etc/postfix/postgresql'],
    mode    => '0640',
    owner   => root,
    group   => postfix,
  }
}
