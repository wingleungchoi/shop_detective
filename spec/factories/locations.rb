FactoryGirl.define do
  factory :location do
    association :company
    association :zip
  end
end