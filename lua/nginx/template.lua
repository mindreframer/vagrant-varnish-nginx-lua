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
{{say}}
{{#beatles}}
  {{name}}
  {{hipstername}}
{{/beatles}}

]]
data = {
  beatles = {
    { name = "John Lennon" },
    { name = "Paul McCartney" },
    { name = "George Harrison" },
    { name = "Ringo Starr" }
  },
  say         = function() return "Saying "  end,
  hipstername = function (self) return self.name .. " was a hipster" end,
}
ngx.say(lustache:render(template, data, partials))



-- functions with args

template = [[
{{#link}}
{{#bold}}Hi {{name}}.{{/bold}}
{{/link}}
]]

data = {
  name = "Tater",
  bold = function(self, text, render)
    return "<b>" .. render(text) .. "</b>"
  end,
  link = function(self, text, render )
    return "<a>" .. render(text) .. "</a>"
  end
}
ngx.say(lustache:render(template, data, partials))