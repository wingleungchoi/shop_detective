FactoryGirl.define do
  factory :state do
    association :country
  end
end