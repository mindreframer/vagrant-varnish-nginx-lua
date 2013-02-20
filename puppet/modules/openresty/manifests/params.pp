class openresty::params{
  # http://openresty.org/download/ngx_openresty-1.2.6.6.tar.gz
  $version  = "1.2.6.6"
  $folder   = "ngx_openresty-$version"
  $filename = "$folder.tar.gz"
  $url      = "http://openresty.org/download/$filename"

  $packages = [
    'wget',
    'build-essential',
    'libncurses5',
    'libncurses5-dev',
    'libpcre3',
    'libpcre3-dev',
  ]
}