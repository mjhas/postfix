#
# Define a LDAP map
#
# Parameters:
# - search_base:      dn for search base. This parameter is required!
# - server_host:      Must either be hostname or a valid LDAP URL.
#                     All LDAP URLs accepted by the OpenLDAP library are
#                     supported, including connections over UNIX domain
#                     sockets, and LDAP SSL (the last one provided that
#                     OpenLDAP was compiled with support for SSL)
#                     (Default: localhost)
# - server_port       Port of the service (Default: 389).
# - scope:            depth of search: sub|base|one (Default: sub)
# - query_filter:     Search filter expression (Default: '(mail=%s)').
# - result_attribute: Attribute to be used as return value (Default: 'uid').
# - ldap_version      LDAP protocol version (Default: 3).
# - start_tls         Whether to use the Start_SSL command. Must be true or
#                     false (Default: true),
# - tls_require_cert  Whether to require a valid certificate to be returned by
#                     the TLS protocol. Will not be set if start_tls is set to
#                     false (Default: true).
# - tls_ca_cert_file  Path to the TLS CA certificate file. Will not be set if
#                     start_tls is set to false.
# - bind              Whether to bind prior to searching for entry. Must be
#                     true or false (Default: false).
# - bind_dn           DN to bind to. Will not be set if bind is false.
# - bind_pw           PW to bind with. Will not be set if bind is false.
#
define postfix::ldap_map (
  $search_base,
  $server_host = 'localhost',
  $server_port = '389',
  $scope = 'sub',
  $ldap_version = '3',
  $start_tls = true,
  $tls_require_cert = true,
  $tls_ca_cert_file = undef,
  $query_filter = '(mail=%s)',
  $result_attribute = 'uid',
  $bind = false,
  $bind_dn = undef,
  $bind_pw = undef,
){

  include postfix::ldap

  $valid_scope_names = ['sub', 'base', 'one']

  if !member($valid_scope_names, $scope) {
    fail("the scope must be one of ${valid_scope_names}")
  }

  validate_bool($bind)
  validate_bool($start_tls)
  validate_bool($tls_require_cert)

  $map_name = $name

  #
  # template uses:
  #  map_name
  #  server_host
  #  server_port
  #  ldap_version
  #  start_tls
  #  search_base
  #  query_filter
  #  scope
  #  result_attribute
  #  tls_ca_cert_file
  #  tls_require_cert
  #  bind
  #  bind_dn
  #  bind_pw
  #
  file{"/etc/postfix/${name}.cf":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode  => 644,
    content => template("${module_name}/ldap_map.cf.erb"),
  }
}