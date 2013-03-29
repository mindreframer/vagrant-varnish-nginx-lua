-- https://github.com/Olivine-Labs/lustache/blob/master/spec/render_spec.lua
local lustache = require "lustache"

view_model = {
  title = "Joe Cocker",
  calc = function ()
    return 2 + 4;
  end
}

ngx.say(lustache:render("{{title}} spends {{calc}}", view_model))

template = "{{ title }}{{> message_template }}"
data = { title = "Message: " }
partials = { message_template = "Hi, Jack" }

ngx.say( lustache:render(template, data, partials))


template = "{{ title }}{{> message_template }}"
data = { title = "Message: ", message = "Hi, Jack, i'm in a partial. Überlegen Sie bitte!" }
partials = { message_template = "{{{ message }}}" }
ngx.say(lustache:render(template, data, partials))



-- arrays
template = [[
{{#beatles}}
  {{name}} -> Rockstar
{{/beatles}}
]]
data = {
  beatles = {
    { name = "John Lennon" },
    { name = "Paul McCartney" },
    { name = "George Harrison" },
    { name = "Ringo Starr" }
  }
}
ngx.say(lustache:render(template, data, partials))