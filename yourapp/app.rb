require 'sinatra/base'

class YourApp < Sinatra::Base
  set :sessions, true
  set :foo, 'bar'

  get '/' do
    #erb :index
    'Hello world!'
  end
end