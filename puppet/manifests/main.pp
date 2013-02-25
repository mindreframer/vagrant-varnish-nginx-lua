Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
File { owner => 0, group => 0, mode => 0644 }
stage { 'first': }
stage { 'last': }
Stage['first'] -> Stage['main'] -> Stage['last']

import 'basic.pp'
import 'nodes.pp'

class{'basic':
  stage => first
}


class{"runit":}
-> class{"yourapp":}
-> class{"varnish":}
-> class{"heartbeat":}
-> class{"openresty":}
-> class{"redis":}
-> class{"memcached":}