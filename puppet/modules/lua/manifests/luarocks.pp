# http://openresty.org/#UsingLuaRocks
class lua::luarocks::params{
  #http://luarocks.org/releases/luarocks-2.0.12.tar.gz
  $version  = "2.0.12"
  $folder   = "luarocks-$version"
  $filename = "$folder.tar.gz"
  $url      = "http://luarocks.org/releases/$filename"
}


class lua::luarocks{
  class{"lua::luarocks::params":}
  -> class{"lua::luarocks::packages":}
  -> class{"lua::luarocks::download":}
  -> class{"lua::luarocks::install":}
}

class lua::luarocks::packages{
  if ! defined(Package['unzip'])    { package { 'unzip': ensure => installed } }
}

class lua::luarocks::download{
  exec{"lua::luarocks::download":
    command => "wget $lua::luarocks::params::url",
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$lua::luarocks::params::filename"
  }

  -> exec{"lua::luarocks::untar":
    command => "tar xvfz /var/tmp/$lua::luarocks::params::filename",
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$lua::luarocks::params::folder"
  }
}

class lua::luarocks::install{
  exec{"lua::luarocks::install":
    command => "echo 1 && \
    ./configure --prefix=/usr/local/openresty/luajit \
      --with-lua=/usr/local/openresty/luajit/ \
      --lua-suffix=jit \
      --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.0 && \
    make && make install",
    cwd     => "/var/tmp/$lua::luarocks::params::folder",
    unless  => "test -e /usr/local/openresty/luajit/bin/luarocks"
  }
}
