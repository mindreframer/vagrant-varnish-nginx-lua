local lustache = require "lustache"

view_model = {
  title = "Joe Cocker",
  calc = function ()
    return 2 + 433;
  end
}

output = lustache:render("{{title}} spends {{calc}}", view_model)
ngx.say(output)