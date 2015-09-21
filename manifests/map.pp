#
# A lookup table to be used in postfix
#
# Parameters:
# - The $source file to copy the map contents from
# - The $content of the map
# - The type of the map. May be one of 'hash', 'btree', 'cdb', 'dbm'. Default
#   is 'hash', valid values depend on the database libraries installed on the
#   machine
#
# sample usage:
#    postfix::map { '/etc/aliases':
#      source => 'puppet:///modules/site/mail.aliases',
#    }
#
#
# If neither $source nor $content are given, the input file for the map is assumed
# to be created by some other procces on the target machine.
# A common use case is to combine this with a metaparameter like this:
#
#      postfix::map { '/etc/postfix/external_mailinglists':
#        subscribe => Exec['/etc/postfix/create_exml.sh'],
#      }
#
# If the input file does not exist yet, it will be created with dummy content.
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
    warning("As neither source nor contents attribute are set a dummy content may be created for postfix::map ${name}")
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
  }
}
