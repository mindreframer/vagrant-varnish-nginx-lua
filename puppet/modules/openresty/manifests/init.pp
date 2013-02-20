class openresty{
  class{"openresty::params":}
  -> class{"openresty::dependencies":}
  -> class{"openresty::download":}
  -> class{"openresty::install":}
}


class openresty::dependencies{
  openresty::package{$openresty::params::packages :}
}

define openresty::package{
  if ! defined(Package[$name])    { package { $name: ensure => installed } }
}


class openresty::download{

}


class openresty::install{

}