## example: sysctl::add{"overcommit_memory": line => "vm.overcommit_memory = 1"}
define sysctl::add($line){
  exec{"sysctl::add::$line":
    command =>  "echo '$line' >> /etc/sysctl.conf",
    unless  => "cat /etc/sysctl.conf|grep -v grep|grep '$line'"
  }
}

