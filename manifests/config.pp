# == Class: postfix::config
#
# postfix class configuration
#
# === Parameters
#
# === Variables
#
# === Authors
#
# mjhas@github
class postfix::config (
  $alias_maps                           = undef,
  $append_dot_mydomain                  = undef,
  $biff                                 = undef,
  $broken_sasl_auth_clients             = undef,
  $content_filter                       = undef,
  $disable_vrfy_command                 = undef,
  $home_mailbox                         = undef,
  $import_environment                   = undef,
  $mailbox_size_limit                   = undef,
  $mail_spool_directory                 = undef,
  $message_size_limit                   = undef,
  $mydestination                        = undef,
  $myhostname                           = undef,
  $mynetworks                           = undef,
  $myorigin                             = undef,
  $proxy_read_maps                      = undef,
  $local_recipient_maps                 = undef,
  $receive_override_options             = undef,
  $show_user_unknown_table_name         = undef,
  $smtpd_banner                         = undef,
  $smtpd_data_restrictions              = undef,
  $smtpd_delay_reject                   = undef,
  $smtpd_helo_required                  = undef,
  $smtpd_recipient_restrictions         = undef,
  $smtpd_sasl_auth_enable               = undef,
  $smtpd_sasl_local_domain              = undef,
  $smtpd_sasl_security_options          = undef,
  $smtpd_sender_restrictions            = undef,
  $smtpd_sasl_type                      = undef,
  $smtpd_sasl_path                      = undef,
  $smtpd_tls_auth_only                  = undef,
  $smtpd_tls_cert_file                  = undef,
  $smtpd_tls_key_file                   = undef,
  $smtpd_tls_loglevel                   = undef,
  $smtpd_tls_received_header            = undef,
  $smtpd_tls_session_cache_timeout      = undef,
  $smtpd_use_tls                        = undef,
  $smtp_sasl_security_options           = undef,
  $smtp_tls_CAfile                      = undef,
  $smtp_tls_note_starttls_offer         = undef,
  $smtp_use_tls                         = undef,
  $soft_bounce                          = undef,
  $strict_rfc821_envelopes              = undef,
  $tls_random_source                    = undef,
  $transport_maps                       = undef,
  $virtual_transport                    = undef,
  $virtual_alias_maps                   = undef,
  $virtual_create_maildirsize           = undef,
  $virtual_gid_maps                     = undef,
  $virtual_mailbox_base                 = undef,
  $virtual_mailbox_domains              = undef,
  $virtual_mailbox_extended             = undef,
  $virtual_mailbox_limit                = undef,
  $virtual_mailbox_limit_maps           = undef,
  $virtual_mailbox_limit_override       = undef,
  $virtual_mailbox_maps                 = undef,
  $virtual_maildir_limit_message        = undef,
  $virtual_overquota_bounce             = undef,
  $virtual_uid_maps                     = undef,
  $maildrop_destination_recipient_limit = undef,
  $dovecot_destination_recipient_limit  = undef,
  $luser_relay                          = undef,
  $mastercfs                            = {},
) {
  include postfix

  create_resources(postfix::config::mastercf, $mastercfs)

  postfix::config::maincfhelper { 'luser_relay': value => $luser_relay, }

  postfix::config::maincfhelper { 'smtpd_sasl_type': value => $smtpd_sasl_type, }

  postfix::config::maincfhelper { 'smtpd_sasl_path': value => $smtpd_sasl_path, }

  postfix::config::maincfhelper { 'virtual_transport': value => $virtual_transport, }

  postfix::config::maincfhelper { 'dovecot_destination_recipient_limit': value => $dovecot_destination_recipient_limit, }

  postfix::config::maincfhelper { 'maildrop_destination_recipient_limit': value => $maildrop_destination_recipient_limit, }

  postfix::config::maincfhelper { 'alias_maps': value => $alias_maps }

  postfix::config::maincfhelper { 'append_dot_mydomain': value => $append_dot_mydomain }

  postfix::config::maincfhelper { 'biff': value => $biff }

  postfix::config::maincfhelper { 'broken_sasl_auth_clients': value => $broken_sasl_auth_clients }

  postfix::config::maincfhelper { 'content_filter': value => $content_filter }

  postfix::config::maincfhelper { 'disable_vrfy_command': value => $disable_vrfy_command }

  postfix::config::maincfhelper { 'home_mailbox': value => $home_mailbox }

  postfix::config::maincfhelper { 'import_environment': value => $import_environment }

  postfix::config::maincfhelper { 'mailbox_size_limit': value => $mailbox_size_limit }

  postfix::config::maincfhelper { 'mail_spool_directory': value => $mail_spool_directory }

  postfix::config::maincfhelper { 'message_size_limit': value => $message_size_limit }

  postfix::config::maincfhelper { 'mydestination': value => $mydestination }

  postfix::config::maincfhelper { 'myhostname': value => $myhostname }

  postfix::config::maincfhelper { 'mynetworks': value => $mynetworks }

  postfix::config::maincfhelper { 'myorigin': value => $myorigin }

  postfix::config::maincfhelper { 'proxy_read_maps': value => $proxy_read_maps }

  postfix::config::maincfhelper { 'local_recipient_maps': value => $local_recipient_maps }

  postfix::config::maincfhelper { 'receive_override_options': value => $receive_override_options }

  postfix::config::maincfhelper { 'show_user_unknown_table_name': value => $show_user_unknown_table_name }

  postfix::config::maincfhelper { 'smtpd_banner': value => $smtpd_banner }

  postfix::config::maincfhelper { 'smtpd_data_restrictions': value => $smtpd_data_restrictions }

  postfix::config::maincfhelper { 'smtpd_delay_reject': value => $smtpd_delay_reject }

  postfix::config::maincfhelper { 'smtpd_helo_required': value => $smtpd_helo_required }

  postfix::config::maincfhelper { 'smtpd_recipient_restrictions': value => $smtpd_recipient_restrictions }

  postfix::config::maincfhelper { 'smtpd_sasl_auth_enable': value => $smtpd_sasl_auth_enable }

  postfix::config::maincfhelper { 'smtpd_sasl_local_domain': value => $smtpd_sasl_local_domain }

  postfix::config::maincfhelper { 'smtpd_sasl_security_options': value => $smtpd_sasl_security_options }

  postfix::config::maincfhelper { 'smtpd_sender_restrictions': value => $smtpd_sender_restrictions }

  postfix::config::maincfhelper { 'smtpd_tls_auth_only': value => $smtpd_tls_auth_only }

  postfix::config::maincfhelper { 'smtpd_tls_cert_file': value => $smtpd_tls_cert_file }

  postfix::config::maincfhelper { 'smtpd_tls_key_file': value => $smtpd_tls_key_file }

  postfix::config::maincfhelper { 'smtpd_tls_loglevel': value => $smtpd_tls_loglevel }

  postfix::config::maincfhelper { 'smtpd_tls_received_header': value => $smtpd_tls_received_header }

  postfix::config::maincfhelper { 'smtpd_tls_session_cache_timeout': value => $smtpd_tls_session_cache_timeout }

  postfix::config::maincfhelper { 'smtpd_use_tls': value => $smtpd_use_tls }

  postfix::config::maincfhelper { 'smtp_sasl_security_options': value => $smtp_sasl_security_options }

  postfix::config::maincfhelper { 'smtp_tls_CAfile': value => $smtp_tls_CAfile }

  postfix::config::maincfhelper { 'smtp_tls_note_starttls_offer': value => $smtp_tls_note_starttls_offer }

  postfix::config::maincfhelper { 'smtp_use_tls': value => $smtp_use_tls }

  postfix::config::maincfhelper { 'soft_bounce': value => $soft_bounce }

  postfix::config::maincfhelper { 'strict_rfc821_envelopes': value => $strict_rfc821_envelopes }

  postfix::config::maincfhelper { 'tls_random_source': value => $tls_random_source }

  postfix::config::maincfhelper { 'transport_maps': value => $transport_maps }

  postfix::config::maincfhelper { 'virtual_alias_maps': value => $virtual_alias_maps }

  postfix::config::maincfhelper { 'virtual_create_maildirsize': value => $virtual_create_maildirsize }

  postfix::config::maincfhelper { 'virtual_gid_maps': value => $virtual_gid_maps }

  postfix::config::maincfhelper { 'virtual_mailbox_base': value => $virtual_mailbox_base }

  postfix::config::maincfhelper { 'virtual_mailbox_domains': value => $virtual_mailbox_domains }

  postfix::config::maincfhelper { 'virtual_mailbox_extended': value => $virtual_mailbox_extended }

  postfix::config::maincfhelper { 'virtual_mailbox_limit': value => $virtual_mailbox_limit }

  postfix::config::maincfhelper { 'virtual_mailbox_limit_maps': value => $virtual_mailbox_limit_maps }

  postfix::config::maincfhelper { 'virtual_mailbox_limit_override': value => $virtual_mailbox_limit_override }

  postfix::config::maincfhelper { 'virtual_mailbox_maps': value => $virtual_mailbox_maps }

  postfix::config::maincfhelper { 'virtual_maildir_limit_message': value => $virtual_maildir_limit_message }

  postfix::config::maincfhelper { 'virtual_overquota_bounce': value => $virtual_overquota_bounce }

  postfix::config::maincfhelper { 'virtual_uid_maps': value => $virtual_uid_maps }
}
