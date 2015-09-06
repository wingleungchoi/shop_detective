if Sinatra::Base.environment != :production
  require 'pry'  
end
# before all initializers
Dir[File.dirname(__FILE__) + '/initializers/*.rb'].each {|file|
  puts "loading #{file}"; require file 
}
