class memcached{
  package { "memcached":
    ensure => installed,
  }
  -> service{"memcached":
    ensure => running
  }
}