# == Define: postfix::maincf
#
# define to build up main.cf for postfix
#
# === Parameters
#
# === Variables
#
# === Authors
#
# mjhas@github
define postfix::config::maincf(
  $ensure = present,
  $value  = undef,
) {
  Augeas {
    context => '/files/etc/postfix/main.cf',
    notify  => Service['postfix'],
    require => Exec['postfix']
  }

  case $ensure {
    present: {
      if !$value {
        fail("postfix main.cf ${name} value not set")
      }
      augeas { "postfix main.cf ${name}":
        changes => "set ${name} '${value}'",
      }
    }

    absent: {
      augeas { "postfix main.cf ${name}":
        changes => "rm ${name}",
      }
    }
    default : {
      notice('unknown ensure value use absent or present')
    }
  }
}

