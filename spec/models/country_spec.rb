require File.expand_path '../../../server.rb', __FILE__

RSpec.describe Country do
  it "has a name, String attribute" do
    country = Country.new(name: 'US')
    expect(country.name).to eq('US')
  end
end