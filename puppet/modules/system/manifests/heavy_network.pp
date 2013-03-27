class system::heavy_network{

  system::proc{"/proc/sys/net/nf_conntrack_max": value => 65536}

  system::sysctl::add{"ip_local_port_range": line => "net.ipv4.ip_local_port_range='1024 65000'"}
  system::sysctl::add{"net.ipv4.tcp_fin_timeout": line => "net.ipv4.tcp_fin_timeout='15'"}
  system::sysctl::add{"net.core.netdev_max_backlog": line => "net.core.netdev_max_backlog='4096'"}
  system::sysctl::add{"net.core.rmem_max": line => "net.core.rmem_max='16777216'"}
  system::sysctl::add{"net.core.somaxconn": line => "net.core.somaxconn='4096'"}
  system::sysctl::add{"net.core.wmem_max": line => "net.core.wmem_max='16777216'"}

  system::sysctl::add{"net.ipv4.tcp_tw_reuse": line => "net.ipv4.tcp_tw_reuse='1'"}
  system::sysctl::add{"net.ipv4.tcp_tw_recycle": line => "net.ipv4.tcp_tw_recycle=1"}

  system::sysctl::add{"net.ipv4.tcp_max_syn_backlog": line => "net.ipv4.tcp_max_syn_backlog='20480'"}
  system::sysctl::add{"net.ipv4.tcp_max_tw_buckets": line => "net.ipv4.tcp_max_tw_buckets='400000'"}
  system::sysctl::add{"net.ipv4.tcp_no_metrics_save": line => "net.ipv4.tcp_no_metrics_save='1'"}
  system::sysctl::add{"net.ipv4.tcp_rmem": line => "net.ipv4.tcp_rmem='4096 87380 16777216'"}
  system::sysctl::add{"net.ipv4.tcp_syn_retries": line => "net.ipv4.tcp_syn_retries='2'"}
  system::sysctl::add{"net.ipv4.tcp_synack_retries": line => "net.ipv4.tcp_synack_retries='2'"}
  system::sysctl::add{"net.ipv4.tcp_wmem": line => "net.ipv4.tcp_wmem='4096 65536 16777216'"}
  system::sysctl::add{"vm.min_free_kbytes": line => "vm.min_free_kbytes='65536'"}
}