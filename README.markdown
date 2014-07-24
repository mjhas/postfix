# postfix #

master branch: [![Build Status](https://secure.travis-ci.org/mjhas/postfix.png?branch=master)](http://travis-ci.org/mjhas/postfix)

This is the postfix module. It provides installation and configuration routines using Puppet.

Simplest Configuration:
=============


    include postfix


It will just install the postfix package and ensure that postfix is running.

---------------------------------------

Simple Configuration:
=============


    include postfix

    class { 'postfix::config':
      smtpd_banner        => 'example.org ESMTP example.org (Debian/GNU)',
    }

It will just install the postfix package and ensure that postfix is running and set the SMTP Banner to the specified.


Relay Configuration:
=============


    include postfix

    class {'postfix::relay':
          sender_hostname=>'sender.example.org',
          masquerade_domains=>'example.org',
          relayhost=>'receiver.example.org'
    }


It will just install the postfix package and ensure that postfix is running and that emails are forwarded to the relayhost.

---------------------------------------

Real World Configuration:
=============

    include postfix

    class { 'postfix::postgres':
      dbname     => 'dbname',
      dbpassword => 'dbpassword',
      dbuser     => 'dbusername',
    }

    class { 'postfix::config':
      alias_maps          => 'hash:/etc/aliases',
      append_dot_mydomain => 'no',
      biff                => 'no',
      broken_sasl_auth_clients             => 'no',
      content_filter      => 'amavis:[127.0.0.1]:10024',
      disable_vrfy_command                 => 'yes',
      import_environment  => 'MAIL_CONFIG MAIL_DEBUG MAIL_LOGTAG TZ XAUTHORITY DISPLAY LANG=C RESOLV_MULTI=on',
      mail_spool_directory                 => '/var/mail',
      mailbox_size_limit  => '100000000',
      message_size_limit  => '60485760',
      mydestination       => 'mail.example.org, localhost, localhost.localdomain',
      myhostname          => 'mail.example.org',
      mynetworks          => '127.0.0.0/8, 192.168.122.0/24',
      myorigin            => '/etc/mailname',
      local_recipient_maps                 => 'proxy:unix:passwd.byname $alias_maps',
      proxy_read_maps     => '$local_recipient_maps $mydestination $virtual_alias_maps $virtual_alias_domains $virtual_mailbox_maps $virtual_mailbox_domains $relay_recipient_maps $relay_domains $canonical_maps $sender_canonical_maps $recipient_canonical_maps $relocated_maps $transport_maps $mynetworks',
      receive_override_options             => 'no_address_mappings',
      show_user_unknown_table_name         => 'no',
      smtp_sasl_security_options           => 'yes',
      smtp_tls_CAfile     => '/etc/ssl/certs/CAcert_chain.pem',
      smtp_tls_note_starttls_offer         => 'yes',
      smtp_use_tls        => 'yes',
      smtpd_banner        => 'example.org ESMTP example.org (Debian/GNU)',
      smtpd_data_restrictions              => 'reject_unauth_pipelining,     permit',
      smtpd_delay_reject  => 'yes',
      smtpd_helo_required => 'yes',
      smtpd_recipient_restrictions         => 'reject_invalid_hostname,     permit_sasl_authenticated,      reject_non_fqdn_hostname,     reject_non_fqdn_sender,     reject_non_fqdn_recipient,      reject_unknown_sender_domain,     reject_unknown_recipient_domain,            reject_unauth_pipelining,     permit_mynetworks,      reject_unauth_destination,      reject_rbl_client zen.spamhaus.org, reject_rbl_client bl.spamcop.net      permit',
      smtpd_sasl_auth_enable               => 'yes',
      smtpd_sasl_local_domain              => '$myhostname',
      smtpd_sasl_security_options          => 'noanonymous',
      smtpd_sender_restrictions            => 'permit_sasl_authenticated, permit_mynetworks',
      smtpd_tls_auth_only => 'no',
      smtpd_tls_cert_file => '/etc/ssl/certs/example_server.pem',
      smtpd_tls_key_file  => '/etc/ssl/private/example_privatekey.pem',
      smtpd_tls_loglevel  => '1',
      smtpd_tls_received_header            => 'yes',
      smtpd_tls_session_cache_timeout      => '3600s',
      smtpd_use_tls       => 'yes',
      tls_random_source   => 'dev:/dev/urandom',
      transport_maps      => 'proxy:pgsql:/etc/postfix/postgresql/virtual_transports.cf',
      virtual_alias_maps  => 'proxy:pgsql:/etc/postfix/postgresql/virtual_forwardings.cf',
      virtual_gid_maps    => 'static:5000',
      virtual_mailbox_base                 => '/srv/vmail',
      virtual_mailbox_domains              => 'proxy:pgsql:/etc/postfix/postgresql/virtual_domains.cf',
      virtual_mailbox_limit                => '100000000',
      virtual_mailbox_maps                 => 'proxy:pgsql:/etc/postfix/postgresql/virtual_mailboxes.cf',
      virtual_uid_maps    => 'static:5000',
      smtpd_sasl_type     => 'dovecot',
      smtpd_sasl_path     => 'private/auth',
      virtual_transport   => 'dovecot',
      dovecot_destination_recipient_limit  => '1',
      maildrop_destination_recipient_limit => '1',
    }


Well, it does something more. You could reuse this piece of code but you need to have a dovecot running and a database with the correct schema. 

## Contributors

[Andschwa](https://github.com/andschwa)
[cpganderton](https://github.com/cpganderton)
