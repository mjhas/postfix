# == Define: postfix::config::mastercf
#
# define to build up master.cf
#
# === Parameters
#
# === Variables
#
# === Authors
#
# mjhas@github
define postfix::config::mastercf (
  $ensure       = present,
  $type         = 'unix',
  $private      = '-',
  $unprivileged = '-',
  $chroot       = '-',
  $wakeup       = '-',
  $limit        = '-',
  $command      = 'echo',) {
  Augeas {
    context => '/files/etc/postfix/master.cf',
    notify  => Service['postfix'],
    require => Exec['postfix'],
  }

  case $ensure {
    present : {
      augeas { "postfix master.cf ${name}":
        changes => [
          "set ${name}/type ${type}",
          "set ${name}/private ${private}",
          "set ${name}/unprivileged ${unprivileged}",
          "set ${name}/chroot ${chroot}",
          "set ${name}/wakeup ${wakeup}",
          "set ${name}/limit ${limit}",
          "set ${name}/command ${command}",
          ],
      }
    }

    absent  : {
      augeas { "postfix master.cf ${name}": changes => "rm ${name}", }
    }
    default : {
      notice('unknown ensure value use absent or present')
    }
  }
}

