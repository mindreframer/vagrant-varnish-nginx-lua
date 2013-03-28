class openresty::path{
  file{"/etc/profile.d/openresty.sh":
    content => "PATH=\$PATH:/usr/local/openresty/luajit/bin:/usr/local/openresty/lua/bin:/usr/local/openresty/nginx/sbin\n"
  }
}