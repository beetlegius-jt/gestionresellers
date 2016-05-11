FactoryGirl.define do
  factory :provider do
    sequence(:name) { |i| "Provider #{i}" }
  end
end
