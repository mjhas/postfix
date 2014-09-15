# == Define: postfix::config::mastercf
#
# define to build up master.cf
#
# === Parameters
#  ensure       = (Default: present)
#  type         = (Default: 'unix')
#  private      = (Default: '-')
#  unprivileged = (Default: '-')
#  chroot       = (Default: '-')
#  wakeup       = (Default: '-')
#  limit        = (Default: '-')
#  command      = (Default: 'echo',
#  options      = a hash of option, value pairs, creating '-o <option>=<value>'
#                 statements after the command. Any options in this hash will
#                 be placed after any options written directly with the command.
#                 (Default is empty)
#
# === Variables
#
# === Authors
#
# mjhas@github
#
define postfix::config::mastercf (
  $ensure       = present,
  $type         = 'unix',
  $private      = '-',
  $unprivileged = '-',
  $chroot       = '-',
  $wakeup       = '-',
  $limit        = '-',
  $command      = 'echo',
  $options      = {},) {
  Augeas {
    context => '/files/etc/postfix/master.cf',
    notify  => Service['postfix'],
    require => Exec['postfix'],
  }

  if is_hash($options) {
    $option_line = join (prefix (join_keys_to_values($options, '='), '-o '), ' ')
  } else {
    warning("parameter options should be a hash of options and values")
    $option_line = $options
  }
  $full_command =  "${command} ${option_line}"

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
          "set ${name}/command '${full_command}'",
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

