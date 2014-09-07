#
# define a test map as a smoke test
#
postfix::map { '/etc/aliases':
  content => "we: me,you,him,her,others@example.com",
  type => 'hash'
}
