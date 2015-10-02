#http://www.sinatrarb.com/intro.html#Sinatra::Base%20-%20Middleware,%20Libraries,%20and%20Modular%20Apps
puts 'server starts'
require 'sinatra/base' 
require 'json'

class ShopDetective < Sinatra::Application
  set :root, File.dirname(__FILE__)
  Dir[File.dirname(__FILE__) + '/config/application.rb'].each {|file|
    puts "loading #{file}"; require file
  }

  get '/' do
    'Welcome to ShopDetective!'
  end

#TODO change to post
  post '/yelp/search.json' do
    keyword = params['keyword']
    type    = params['type']
    scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
    search_results = scrapper.search_companies(keyword, type, 10) # find 10 companies for testing
    search_result_manager = SearchResultManager.new(results: search_results)
    content_type :json
    status 200
    body(
      search_result_manager.get_companies_json
    )
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
end

=begin  
  [Country, State, Zip, Location, Company, Subcategory, OrganizationKind].each do |c|
    c.delete_all
  end
=end
