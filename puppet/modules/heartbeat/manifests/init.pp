class heartbeat{
  class{"heartbeat::params":}
  -> class{"heartbeat::packages":}
  -> class{"heartbeat::configs":}
  -> class{"heartbeat::service":}
}

class heartbeat::packages{
  package{"heartbeat":}
}

class heartbeat::configs{

}


class heartbeat::service{

}