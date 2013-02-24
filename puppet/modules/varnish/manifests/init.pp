class varnish{
  class{"varnish::params":}
  -> class{"varnish::add_repo":}
  -> class{"varnish::packages":}
}

class varnish::add_repo{
  exec{"varnish::add_key":
    command => "curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -",
    unless  => "apt-key list|grep varnish-cache"
  }
  -> exec{"varnish::add_repo":
    command => "echo \"deb http://repo.varnish-cache.org/ubuntu/ precise varnish-3.0\" | sudo tee -a /etc/apt/sources.list",
    unless  => "grep varnish /etc/apt/sources.list"
  }
  -> exec{"varnish::update_sources":
    command => "sudo apt-get update && touch /var/tmp/.apt-get-update-for-varnish",
    unless  => "test -e /var/tmp/.apt-get-update-for-varnish"
  }
}

class varnish::packages{
  package{"varnish":}
}