require 'spec_helper'
RSpec.describe Country do
  it "has a name, String attribute" do
    country = Country.new(name: 'US')
    expect(country.name).to eq('US')
  end
  it "has many states" do
    country1 = Country.new(name: 'US')
    state1 = State.new(name: 'NY')
    country1.states = [state1]
  end
end