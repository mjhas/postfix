#
# Define a LDAP map
#
# server_host:      Must either be hostname or a valid LDAP URL.
#                   All LDAP URLs accepted by the OpenLDAP  library  are  supported,
#                   including  connections  over  UNIX  domain sockets, and LDAP SSL
#                   (the last one provided that OpenLDAP was compiled  with  support
#                   for SSL) (Default: localhost)
# search_base:      dn for search base
# scope:            depth of search: sub|base|one (Default: sub)
# query_filter:     Attribute und Werte die den Such-Filter angeben. Dieser
#                   mu337 die Liste der Ergebnise-Eintr344ge liefern.
# result_attribute: Attribute die als R374ckgabewert f374r den Lookup genutzt
#                   werden sollen.

#
#
define postfix::ldap_map (
  $server_host = 'localhost',
  $server_port = '389',
  $scope = 'sub',
  $ldap_version = '3',
  $start_tls = 'yes',
  $query_filter = '(mail=%s)',
  $result_attribute = 'uid',
){

  $valid_scope_names = ['sub', 'base', 'one']

  if !member($valid_scope_names, $scope) {
    fail("the scope must be one of ${valid_scope_names}")
  }

  #
  # template uses:
  #  map_name
  #  server_host
  #  ldap_version
  #  start_tls
  #  query_filter
  #  result_attribute
  #
  file{"/etc/postfix/${name}.cf":
    ensure => file,
    owner => 'root',
    group => 'root',
    mode  => 644,
    content => template("${module_name}/ldap_map.cf.erb"),
  }
}