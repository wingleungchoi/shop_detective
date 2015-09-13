require 'spec_helper'
RSpec.describe OrganizationKind do
  it "has a name, String attribute" do
    origanization_kind = OrganizationKind.new(name: 'Business')
    expect(origanization_kind.name).to eq('Business')
  end
  it "has many categories" do
    origanization_kind = OrganizationKind.new(name: 'Business')
    category1 = Category.new(name: 'Beauty')
    origanization_kind.categories = [category1]
  end
end