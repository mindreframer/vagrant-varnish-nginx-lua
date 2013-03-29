-- ngx.arg[2] = true ==> set eof or last chain buffer
ngx.arg[1] = string.gsub(ngx.arg[1], "My", "Your CRAZY")
ngx.arg[2] = true