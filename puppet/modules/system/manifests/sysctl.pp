## example: sysctl::add{"overcommit_memory": line => "vm.overcommit_memory = 1"}
define system::sysctl::add($line){
  exec{"sysctl::add::$line":
    command =>  "echo \"$line\" >> /etc/sysctl.conf",
    unless  => "cat /etc/sysctl.conf|grep -v grep|grep \"$line\""
  }

  # exec{"sysctl::execline::$line":
  #   command => "sysctl -w $line",
  #   unless  => "sysctl -a |grep -v grep |grep '$line'"
  # }
}
