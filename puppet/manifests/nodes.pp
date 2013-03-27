node default {
  class{'basic':
    stage => first
  }

  class{"role_rvm":}
  class{"runit":}
  -> class{"yourapp":}
  -> class{"varnish":}
  -> class{"heartbeat":}
  -> class{"openresty":}
  -> class{"redis":}
  -> class{"memcached":}
  -> class{"benchmarking":}

  # needed for redis
  sysctl::add{"overcommit_memory": line => "vm.overcommit_memory = 1"}
}