if Sinatra::Base.environment != :production
  require 'pry'  
end
puts 'start initializing'
# before all initializers
Dir["#{ShopDetective.root}/config/initializers/*.rb"].each {|file|
  puts "loading #{file}"; require file 
}

%w{ lib/shop_detective models workers services}.each do |folder_name|
  puts "loading #{folder_name.titleize}"
  Dir["#{ShopDetective.root}/app/#{folder_name}/*.rb"].each {|file|
    puts "loading #{file}"; require file 
  }
end