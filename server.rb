#http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps
require 'sinatra/base'

class ShopDetective < Sinatra::Application
  get '/' do
    'Welcome to ShopDetective!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end