class role_rvm{
  class{"role_rvm::software":}
  -> class{"role_rvm::users":}
  -> class{"role_rvm::packages":}
  -> class{"role_rvm::rubies":}
}

class role_rvm::software{
  class{"rvm":}
}

class role_rvm::users{
  user{"vagrant": ensure => present}
  -> rvm::system_user { vagrant: ;}
}

class role_rvm::packages{
  $packages = ["libgdbm-dev", "libtool", "pkg-config", "libffi-dev"]
  package{ $packages : ensure => installed }
}



class role_rvm::rubies{
  rvm_system_ruby {
    'ruby-1.9.3-turbo':
      ensure => 'present',
      default_use => false;
    'ruby-2.0.0-turbo':
      ensure => 'present',
      default_use => false;
  }
}