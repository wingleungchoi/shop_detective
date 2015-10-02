FactoryGirl.define do
  factory :location do
    association :company
    association :zip
    association :state
  end
end