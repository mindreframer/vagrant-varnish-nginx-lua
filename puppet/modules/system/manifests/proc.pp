define system::proc($value){
  exec{"system::proc::$name":
    command => "echo \"$value\" > $name",
    unless  => "cat $name |grep -v grep|grep $value"
  }
}