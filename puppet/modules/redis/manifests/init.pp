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
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$redis::params::filename"
  }

  -> exec{"redis::untar":
    command => "tar xvfz /var/tmp/$redis::params::filename",
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$redis::params::folder"
  }
}

class redis::install{
  exec{"redis::install":
    command => "echo 1 && make && make install",
    cwd     => "/var/tmp/$redis::params::folder",
    unless  => "test -e /usr/local/bin/redis-server"
  }
}

class redis::configs{
  file{
    ["/etc/sv/redis-server",
    "/etc/sv/redis-server/log"]:
    ensure => directory
  }
  -> file{"/etc/sv/redis-server/run":
    content => "#!/bin/bash \
exec 2>&1 \
exec redis-server",
    mode    => 0755
  }
  -> file{"/etc/sv/redis-server/log/run":
    content => "#!/bin/bash \
\
set -e \
exec 2>&1 \
exec svlogd -tt -b 10000 .",
    mode => 0755
  }
}

class redis::service{

}
