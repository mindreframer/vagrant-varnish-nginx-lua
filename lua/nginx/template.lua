-- https://github.com/Olivine-Labs/lustache/blob/master/spec/render_spec.lua
local lustache = require "lustache"

view_model = {
  title = "Joe Cocker",
  calc = function ()
    return 2 + 4;
  end
}

output = lustache:render("{{title}} spends {{calc}}", view_model)
ngx.say(output)