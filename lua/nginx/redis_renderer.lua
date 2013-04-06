-- https://github.com/agentzh/lua-resty-redis
local cjson = require "cjson"
local redis = require "resty.redis"
local red   = redis:new()

red:set_timeout(1000) -- 1 sec

-- or connect to a unix domain socket file listened
-- by a redis server:
--     local ok, err = red:connect("unix:/path/to/redis.sock")

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("failed to connect: ", err)
    return
end

ok, err = red:set("dog", "an animal")
if not ok then
    ngx.say("failed to set dog: ", err)
    return
end
ngx.say("set result: ", ok)

local templates = {}
templates.user = "hey, this rocks, you {{name}}"
templates.admin = "admin, greetings on {{server}}"
ok, err = red:set("templates", cjson.encode(templates))


red:hmset("template_partials", "message", "message: {{{ message }}}")
red:hmset("template_partials", "user", "user: {{{ user }}}")

res, err = red:hget("template_partials", "user")
ngx.say(res)

res, err = red:hget("template_partials", "message")
ngx.say(res)

local res, err = red:get("dog")
if not res then
    ngx.say("failed to get dog: ", err)
    return
end

if res == ngx.null then
    ngx.say("dog not found.")
    return
end

ngx.say("dog: ", res)

red:init_pipeline()
red:set("cat", "Marry")
red:set("horse", "Bob")
red:get("cat")
red:get("horse")
local results, err = red:commit_pipeline()
if not results then
    ngx.say("failed to commit the pipelined requests: ", err)
    return
end

for i, res in ipairs(results) do
    if type(res) == "table" then
        if not res[1] then
            ngx.say("failed to run command ", i, ": ", res[2])
        else
            -- process the table value
        end
    else
        -- process the scalar value
    end
end




-- or just close the connection right away:
-- local ok, err = red:close()
-- if not ok then
--     ngx.say("failed to close: ", err)
--     return
-- end

-- put it into the connection pool of size 100,
-- with 0 idle timeout
local ok, err = red:set_keepalive(0, 100)
if not ok then
    ngx.say("failed to set keepalive: ", err)
    return
end
