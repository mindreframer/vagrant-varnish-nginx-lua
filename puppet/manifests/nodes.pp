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
}