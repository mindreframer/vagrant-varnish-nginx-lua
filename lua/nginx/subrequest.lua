local res = ngx.location.capture("/sub")
if res.status >= 500 then
    ngx.exit(res.status)
end
ngx.status = res.status
ngx.say("This is comming from another request")
ngx.say(res.body)