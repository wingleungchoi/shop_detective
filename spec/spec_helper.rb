# http://recipes.sinatrarb.com/p/testing/rspec
require 'rack/test'
require 'rspec'
require 'factory_girl'

require File.expand_path '../../server.rb', __FILE__

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods
  def ShopDetective(); Sinatra::Application; end
end

# For RSpec 2.x
RSpec.configure { |c|
  # Use color in STDOUT
  c.color = true

  # Use Factory Girl
  c.include FactoryGirl::Syntax::Methods
  
  c.include RSpecMixin 
}

# Loading factories
FactoryGirl.find_definitions

# for testing server.rb (kind of controllers)
# http://tarynsauer.tumblr.com/post/72337538488/using-rspec-to-test-sinatra-controller
def app
  ShopDetective.new
end