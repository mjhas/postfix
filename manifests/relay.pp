# == Class: postfix::relay
#
# Set up a postfix server as a relay
#
# === Parameters
#
# === Variables
#
# === Authors
#
# mjhas@github
class postfix::relay (
  $relayhost = undef,
  $masquerade_domains = $::hostname,
  $sender_hostname = $::fqdn,
  $smtp_sasl_auth_enable = undef,
  $smtp_sasl_password_maps = undef,
  $smtp_sasl_security_options = undef,
  $smtp_tls_CAfile = undef,
  $smtp_tls_note_starttls_offer = undef,
  $smtp_tls_security_level = undef,
  $smtp_use_tls = undef,
) {
  include postfix

  postfix::config::maincfhelper { 'append_dot_mydomain': value => 'yes', }

  postfix::config::maincfhelper { 'myhostname': value => $sender_hostname, }

  postfix::config::maincfhelper { 'myorigin': value => $sender_hostname, }

  if $::fqdn != $sender_hostname {
    postfix::config::maincfhelper { 'mydestination': value => "${sender_hostname}, ${::fqdn}, ${::hostname}, localhost.localdomain, localhost", }
  }
  else {
    postfix::config::maincfhelper { 'mydestination': value => "${sender_hostname}, ${::hostname}, localhost.localdomain, localhost", }
  }

  postfix::config::maincfhelper { 'relayhost': value => $relayhost, }

  postfix::config::maincfhelper { 'smtp_sasl_auth_enable': value => $smtp_sasl_auth_enable }

  postfix::config::maincfhelper { 'smtp_sasl_password_maps': value => $smtp_sasl_password_maps }

  postfix::config::maincfhelper { 'smtp_sasl_security_options': value => $smtp_sasl_security_options }

  postfix::config::maincfhelper { 'smtp_tls_CAfile': value => $smtp_tls_CAfile }

  postfix::config::maincfhelper { 'smtp_tls_note_starttls_offer': value => $smtp_tls_note_starttls_offer }

  postfix::config::maincfhelper { 'smtp_tls_security_level': value => $smtp_tls_security_level }

  postfix::config::maincfhelper { 'smtp_use_tls': value => $smtp_use_tls }

  postfix::config::maincfhelper { 'mynetworks': value => '127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128', }

  postfix::config::maincfhelper { 'mailbox_size_limit': value => '0', }

  postfix::config::maincfhelper { 'masquerade_domains': value => $masquerade_domains, }

  postfix::config::maincfhelper { 'inet_interfaces': value => 'loopback-only', }
}
