include postfix

postfix::ldap_map { 'some_stuff':
  server_host      => 'ldap.example.com',
  server_port      => '389',
  scope            => 'one',
  ldap_version     => '2',
  start_tls        => 'no',
  query_filter     => '(uid=%s)',
  result_attribute => 'mail',
}