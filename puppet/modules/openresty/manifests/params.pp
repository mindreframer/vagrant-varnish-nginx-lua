class openresty::params{
  # http://openresty.org/download/ngx_openresty-1.2.6.6.tar.gz
  $packages = [
    'build-essential',
    'libncurses5',
    'libncurses5-dev',
    'libpcre3',
    'libpcre3-dev'
  ]
}