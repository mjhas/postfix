# == Class: postfix::database
#
# Set up postgres/mysql backend for postfix
#
# === Parameters
# "rdbms" => can either be "mysql" or "postgres"
# "schema" => supported values are "custom" for the original datbaase schema
# and "postfixadmin" to be used with their web-interface.
#
# === Variables
#
# === Authors
#
# mjhas@github
# nerdyness@github
class postfix::database (
  $dbname     = undef,
  $dbuser     = undef,
  $dbpassword = undef,
  $hosts      = 'localhost',
  $rdbms      = 'postgresql',
  $schema     = 'custom',
) {
  include postfix

  package { "postfix-$rdbms":
    ensure  => 'installed',
    require => Package['postfix'],
    notify  => Service['postfix'],
  }

  file { "/etc/postfix/$rdbms":
    ensure  => directory,
    mode    => '0750',
    owner   => root,
    group   => postfix,
    require => Package["postfix-$rdbms"],
  }

  if $schema == "custom" {
    $schema_files = {
      "/etc/postfix/$rdbms/virtual_domains.cf" => {
        content => template("postfix/$schema/virtual_domains.cf") },
      "/etc/postfix/$rdbms/virtual_email2email.cf" => {
        content => template("postfix/$schema/virtual_email2email.cf") },
      "/etc/postfix/$rdbms/virtual_forwardings.cf" => {
        content => template("postfix/$schema/virtual_forwardings.cf") },
      "/etc/postfix/$rdbms/virtual_limit_maps.cf" => {
        content => template("postfix/$schema/virtual_limit_maps.cf") },
      "/etc/postfix/$rdbms/virtual_mailboxes.cf" => {
        content => template("postfix/$schema/virtual_mailboxes.cf") },
      "/etc/postfix/$rdbms/virtual_transports.cf" => {
        content => template("postfix/$schema/virtual_transports.cf") },
    }
   } elsif $schema == 'postfixadmin' {
     $schema_files = {
       "/etc/postfix/$rdbms/relay_domains.cf" => {
         content => template("postfix/$schema/relay_domains.cf") },
       "/etc/postfix/$rdbms/virtual_alias_domain_catchall_maps.cf" => {
         content => template("postfix/$schema/virtual_alias_domain_catchall_maps.cf") },
       "/etc/postfix/$rdbms/virtual_alias_domain_mailbox_maps.cf" => {
         content => template("postfix/$schema/virtual_alias_domain_mailbox_maps.cf") },
       "/etc/postfix/$rdbms/virtual_alias_domain_maps.cf" => {
         content => template("postfix/$schema/virtual_alias_domain_maps.cf") },
       "/etc/postfix/$rdbms/virtual_alias_maps.cf" => {
         content => template("postfix/$schema/virtual_alias_maps.cf") },
       "/etc/postfix/$rdbms/virtual_domains_maps.cf" => {
         content => template("postfix/$schema/virtual_domains_maps.cf") },
       "/etc/postfix/$rdbms/virtual_mailbox_domains.cf" => {
         content => template("postfix/$schema/virtual_mailbox_domains.cf") },
       "/etc/postfix/$rdbms/virtual_mailbox_maps.cf" => {
         content => template("postfix/$schema/virtual_mailbox_maps.cf") },
     }
   } else {
     fail("Schema $schema is unsupported.")
   }

  $defaults = {
    'require' => File["/etc/postfix/$rdbms"],
    'mode'    => '0640',
    'owner'   => root,
    'group'   => postfix,
  }
  create_resources(file, $schema_files, $defaults)
}
