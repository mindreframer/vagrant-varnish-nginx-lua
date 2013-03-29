
-- http://www.londonlua.org/scripting_nginx_with_lua/slides.html?full#cosocket-memcached
local memcached = require "resty.memcached"
local memc = memcached:new()
local ok, err = memc:connect("127.0.0.1", 11211)


local ok, err = memc:set("dog", "bar", 3600)
if ok then
    ngx.say("STORED")
end

memc:replace("dog", "a kind of animal")
ngx.say("dog: ", memc:get("dog"))

memc:set_keepalive()