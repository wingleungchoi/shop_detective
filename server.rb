#http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps
puts 'server starts'
require 'sinatra/base' 

puts 'initializing'
Dir[File.dirname(__FILE__) + '/config/application.rb'].each {|file|
  puts "loading #{file}"; require file
}

puts 'loading Models'
Dir[File.dirname(__FILE__) + '/app/models/*.rb'].each {|file|
  puts "loading #{file}"; require file 
}
puts 'loading Workers'
Dir[File.dirname(__FILE__) + '/app/workers/*.rb'].each {|file|
  puts "loading #{file}"; require file 
}

class ShopDetective < Sinatra::Application
  get '/' do
    'Welcome to ShopDetective!'
  end

#TODO change to post
  get '/search.json' do
    content_type :json
    status 200
    body({companies: {keyword: params[:keyword], keyword_kind: params[:keyword_kind]}}.to_json)
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end