#http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps
puts 'server starts'
require 'sinatra/base'

puts 'initializing'
require File.expand_path (File.dirname(__FILE__) + '/config/application.rb'), __FILE__

puts 'using Mongo DB'
require 'mongoid'

puts 'loading Models'
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file|
  puts "pust loading #{file}"; require file 
}

class ShopDetective < Sinatra::Application
  get '/' do
    'Welcome to ShopDetective!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end