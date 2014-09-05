#
#  add ldap support to postfix server
#
class postfix::ldap {
  package { 'postfix-ldap':
     ensure => latest,
     notify => Service['postfix'],
  }
}