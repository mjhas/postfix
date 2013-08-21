include postfix

class { 'postfix::relay':
  relayhost          => 'example.org',
  masquerade_domains => 'relay.example.org'
}