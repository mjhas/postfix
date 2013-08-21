define postfix::config::maincfhelper ($value = undef) {
  if $value {
    postfix::config::maincf { $name: value => $value, }
  } else {
    postfix::config::maincf { $name: ensure => absent, }
  }
}
