#http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps
puts 'server starts'
require 'sinatra/base' 
class ShopDetective < Sinatra::Application
  set :root, File.dirname(__FILE__)
  Dir[File.dirname(__FILE__) + '/config/application.rb'].each {|file|
    puts "loading #{file}"; require file
  }

  get '/' do
    'Welcome to ShopDetective!'
  end

#TODO change to post
  get '/:website/search.json' do
    case params['website']
    when 'yelp'
      scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')  
    end
    content_type :json
    status 200
    body(
      {companies: {keyword: params[:keyword], keyword_kind: params[:keyword_kind]}
      }.to_json
    )
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end