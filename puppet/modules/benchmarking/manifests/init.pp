class benchmarking{
  package { "apache2-utils":
    ensure => installed,
  }
  package{"gdb": ensure => installed}
  package{"telnet": ensure => installed}
  package{"lsof": ensure => installed}
}