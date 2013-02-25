require 'sinatra/base'
require 'json'

class EnvApp < Sinatra::Base

  get '*' do
    #  ["REQUEST_PATH", "REQUEST_URI", "REQUEST_METHOD", "REQUEST_PATH", "PATH_INFO"]
    keys =  (request.env.keys.grep(/REQ/) + request.env.keys.grep(/PATH/))
    r = {}
    keys.each {|k| r[k] = request.env[k]}
    JSON.unparse(r)
  end
end