node default {
  class{'basic':
    stage => first
  }

  class{"role_rvm":}
  class{"runit":}
  -> class{"yourapp":}
  -> class{"varnish":}
  # -> class{"heartbeat":}
  -> class{"openresty":}
  -> class{"lua::luarocks":}
  -> class{"redis":}
  -> class{"memcached":}
  -> class{"postgres::v9_2":}
  -> class{"benchmarking":}

  # needed for redis
  system::sysctl::add{"overcommit_memory": line => "vm.overcommit_memory = 1"}
  class{"system::heavy_network":}
}


