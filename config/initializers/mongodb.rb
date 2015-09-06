puts 'using Mongo DB'
require 'mongoid'
#http://docs.mongodb.org/ecosystem/tutorial/ruby-mongoid-tutorial/#ruby-mongoid-tutorial
Mongoid.load!((Dir.pwd+ '/config/secrets/mongoid.yml'), Sinatra::Base.environment)
