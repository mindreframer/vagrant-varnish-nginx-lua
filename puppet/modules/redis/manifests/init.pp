class redis{
  class{"redis::params":}
  -> class{"redis::dependencies":}
  -> class{"redis::download":}
  -> class{"redis::install":}
  -> class{"redis::configs":}
  -> class{"redis::service":}
}

class redis::dependencies{
  redis::package{$redis::params::dependencies :}
}

define redis::package{
  if ! defined(Package[$name])    { package { $name: ensure => installed } }
}

class redis::download{
  exec{"redis::download":
    command => "wget $redis::params::url",
    cwd     => "/tmp",
    unless  => "test -e /tmp/$redis::params::filename"
  }

  -> exec{"redis::untar":
    command => "tar xvfz /tmp/$redis::params::filename",
    unless  => "test -e /tmp/$redis::params::folder"
  }
}

class redis::install{
  exec{"redis::install":
    command => "echo 1 && make && make install",
    cwd     => "/tmp/$redis::params::folder",
    unless  => "test -e /usr/local/bin/redis-server"
  }
}

class redis::configs{

}

class redis::service{

}
