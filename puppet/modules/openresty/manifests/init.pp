class openresty{
  class{"openresty::params":}
  -> class{"openresty::dependencies":}
  -> class{"openresty::download":}
  -> class{"openresty::install":}
}


class openresty::dependencies{
  openresty::package{$openresty::params::dependencies :}
}

define openresty::package{
  if ! defined(Package[$name])    { package { $name: ensure => installed } }
}


class openresty::download{
  exec{"openresty::download":
    command => "wget $openresty::params::url",
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$openresty::params::filename"
  }

  -> exec{"openresty::untar":
    command => "tar xvfz /var/tmp/$openresty::params::filename",
    unless  => "test -e /var/tmp/$openresty::params::folder"
  }

}

class openresty::install{
  exec{"openresty::install":
    command => "echo 1 && ./configure && make && make install",
    cwd     => "/var/tmp/$openresty::params::folder",
    unless  => "test -e /usr/local/openresty"
  }
}