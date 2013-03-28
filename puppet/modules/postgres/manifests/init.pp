class postgres::v9_2{
  class{"postgres::params":}
    -> class{"postgres::add_repo":}
    -> class{"postgres::v9_2::package":}
    -> class{"postgres::v9_2::config":}
    ~> class{"postgres::v9_2::service":} # notify service
}

class postgres::params{
}

class postgres::add_repo{
  exec{"postgres::add_key":
    command => "curl http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -",
    unless  => "apt-key list|grep PostgreSQL"
  }
  -> file{"/etc/apt/sources.list.d/pgdg.list":
    content => "deb http://apt.postgresql.org/pub/repos/apt/ $::lsbdistcodename-pgdg main"
  }
  -> exec{"postgres::update_sources":
    command => "sudo apt-get update && touch /var/tmp/.apt-get-update-for-posgres",
    unless  => "test -e /var/tmp/.apt-get-update-for-posgres"
  }
}

class postgres::v9_2::package{
  package{"postgresql-9.2": ensure => installed}
}

class postgres::v9_2::config{
  file{"/etc/postgresql/9.2/main/postgresql.conf":
    content => template("postgres/9.2/postgresql.conf.erb"),
    owner => postgres, group => postgres
  }
}

class postgres::v9_2::service{
  service{"postgresql":
    ensure     => running,
    hasstatus  => "true",
    hasrestart => "true",
    provider   => "init"
  }
}