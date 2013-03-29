class openresty{
  class{"openresty::params":}
  -> class{"openresty::dependencies":}
  -> class{"openresty::path":}
  -> class{"openresty::download":}
  -> class{"openresty::install":}
  -> class{"openresty::configs":}
  ~> class{"openresty::service":}
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
    cwd     => "/var/tmp",
    unless  => "test -e /var/tmp/$openresty::params::folder"
  }

}

class openresty::install{
  exec{"openresty::install":
    command => "echo 1 && \
    ./configure --with-luajit && \
    make && make install",
    cwd     => "/var/tmp/$openresty::params::folder",
    unless  => "test -e /usr/local/openresty && \
      /usr/local/openresty/nginx/sbin/nginx  -v  2>&1|grep $openresty::params::version |grep -v grep"
  }
}


class openresty::configs{
  file{["/etc/sv/openresty", "/etc/sv/openresty/log"]:
    ensure => directory
  }
  -> file{"/etc/sv/openresty/run":
    content => template("openresty/sv/run"),
    mode    => 0755,
  }
  -> file{"/etc/sv/openresty/log/run":
    content => template("openresty/sv/log/run"),
    mode    => 0755,
  }

  -> file{"/usr/local/openresty/nginx/conf/nginx.conf":
    #content => template("openresty/config/nginx.conf.erb")
    #content => template("openresty/config/nginx.luafun.conf.erb")
    content => template("openresty/config/nginx.accelerator.conf.erb")
  }

  -> file{"/usr/local/openresty/nginx/conf/bar.lua":
    content => template("openresty/config/bar.lua.erb")
  }
  -> file{"/usr/local/openresty/nginx/conf/foo.lua":
    content => template("openresty/config/foo.lua.erb")
  }

}

class openresty::service{
 # https://github.com/puppetlabs/puppet/blob/master/lib/puppet/provider/service/runit.rb
  service { "openresty" :
    enable     => "true",
    ensure     => "running",
    provider   => "runit",
    hasstatus  => "true",
    hasrestart => "true",
  }
}
