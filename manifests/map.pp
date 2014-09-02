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
  } elsif $content {
    File[$name] {
      content => $content,
    }
  } else {
#
# if neither content nor source of map is given, we expect some local process
# to set the contents. Lets provide an valid but empty table for now.
#
    File[$name] {
      content => '#
# Partially Controlled by Puppet!!
#
# The attribues of this file will be managed by Puppet, but content will
# hopefully be controled by some local process, as no valid content was
# supplied
#',
      replace => false,
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
