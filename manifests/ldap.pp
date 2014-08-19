#
#
#
class postfix::ldap {
  package { 'postfix-ldap':
     ensure => latest,
     notify => Service['postfix'],
  }
}