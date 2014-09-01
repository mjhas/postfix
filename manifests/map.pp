#
# a table used in postfix
#
define postfix::map (
  $source  = undef,
  $content = undef,
  $type = 'hash',) {
  #
  # the second files for types dbm and sdbm are ignored, as they are updated
  # with the pag files.
  #

  if (! $source) and (!$content) {
    fail("Either source or contents attribute must be set for type postfix::map")
  }

  case $type {
    'btree', 'hash' : {
      $ext = 'db'
    }
    'cdb'           : {
      $ext = 'cdb'
    }
    'dbm', 'sdbm'   : {
      $ext = 'pag'
    }
    default         : {
      fail("the type ${type} does not need to pre-processed. Simply set as file")
    }

  }

  file { $name:
    ensure => file,
    mode   => '0644',
    owner  => 'root',
    group  => 'root',
  }

  if $source {
    File[$name] {
      source => $source,
    }
  } else {
    if $content {
      File[$name] {
        content => $content,
      }
    }
  }
  if $ext {
    File[$name] {
      notify => Exec["/usr/sbin/postmap ${type}:${name}"],
    }
  }

  exec { "/usr/sbin/postmap ${type}:${name}":
    subscribe   => File[$name],
    refreshonly => true,
    creates     => "${name}.${ext}",
    notify      => Service['postfix'],
  }
}
