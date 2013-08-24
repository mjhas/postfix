class postfix::relay (
  $relayhost,
  $masquerade_domains,
  $sender_hostname = $::fqdn,
) {
  include postfix

  postfix::config::maincfhelper { 'append_dot_mydomain': value => 'yes', }

  postfix::config::maincfhelper { 'myhostname': value => "${sender_hostname}", }

  postfix::config::maincfhelper { 'myorigin': value => "${sender_hostname}", }

  postfix::config::maincfhelper { 'mydestination': value => "${sender_hostname}, ${::hostname}, localhost.localdomain, localhost", }

  postfix::config::maincfhelper { 'relayhost': value => "${relayhost}", }

  postfix::config::maincfhelper { 'mynetworks': value => "127.0.0.0/8 [::ffff:127.0.0.0]/104 [::1]/128", }

  postfix::config::maincfhelper { 'mailbox_size_limit': value => "0", }

  postfix::config::maincfhelper { 'masquerade_domains': value => "${masquerade_domains}", }

  postfix::config::maincfhelper { 'inet_interfaces': value => "loopback-only", }
}
