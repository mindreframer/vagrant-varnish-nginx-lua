class apt-fast{
  exec{"apt-fast::download":
    command => "wget https://raw.github.com/ilikenwf/apt-fast/master/apt-fast && chmod +x apt-fast",
    cwd     => "/usr/local/bin",
    unless  => "test -e /usr/local/bin/apt-fast"
  }

  file{"/etc/apt-fast.conf":
    content => template("apt-fast/apt-fast.conf.erb")
  }

  if ! defined(Package["aria2"])    { package { "aria2": ensure => installed } }
}
